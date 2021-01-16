import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/foundation.dart';


class DevicesProvider with ChangeNotifier {
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();

  final StreamController<String> beaconEventsController = StreamController<String>.broadcast();

  String _beaconResult = 'Not Scanned Yet.';
  String _qrCode = '';
  int _nrMessaggesReceived = 0;

  bool _playing = false; // 재성버튼 활성 default
  bool _isRunning = false;

  get isRunning => _isRunning;
  get isPlaying => _playing;

  void setIsRunning(bool running) {
    _isRunning = running;
    notifyListeners();
  }

  void setPlaying(bool py) {
    _playing = py;
  }

  void becaonScan(bool type) async{
    if (type) {
      await BeaconsPlugin.startMonitoring;
    } else {
      await BeaconsPlugin.stopMonitoring;
    }
    setIsRunning(type);
  }

  void init() async {
      if (Platform.isAndroid) {
        await BeaconsPlugin.setDisclosureDialogMessage(
            title: "Need Location Permission",
            message: "This app collects location data to work with beacons.");
      }

      BeaconsPlugin.listenToBeacons(beaconEventsController);

      // 비콘 정보
      await BeaconsPlugin.addRegion("wwwhohee42878", "74278BDA-B644-4520-8F0C-720EAF059935");

      // UUID에 맞는 비콘 연결
      beaconEventsController.stream.listen((data) {

          if (data.isNotEmpty) {
            print("##### Beacons DataReceived: $data");
            _beaconResult = data;
            _nrMessaggesReceived++;
          }
      },
      onDone: () {
        print("##### onDone");
      },
      onError: (error) {
        print("##### error: $error");
      });

      // 백그라운드에서 실행
      await BeaconsPlugin.runInBackground(true);

      if (Platform.isAndroid) {
        BeaconsPlugin.channel.setMethodCallHandler((call) async {
          if (call.method == 'scannerReady') {
            await BeaconsPlugin.startMonitoring;
            setIsRunning(true);
          }
        });
      } else if (Platform.isIOS) {
        await BeaconsPlugin.startMonitoring;
        setIsRunning(true);
      }
  }

  void dispose() {
    beaconEventsController.close();
  }

  // qr코드 스캔 함수 (simulator는 지원 안됨)
  void scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print("#### barcode: ${barcode}");
    }catch(e) {
      print("#### scan error: $e");
    }
  }

  //오디오 재생
  void playAudio() async {
    if (_playing) {
      // pause song
      var  res = await audioPlayer.pause();
      if (res == 1) {
        setPlaying(false);
      }

    } else {
      // play song
      var res = await audioPlayer.play('https://luan.xyz/files/audio/ambient_c_motion.mp3');
      if (res == 1) {
        setPlaying(true);
      }
    }

    audioPlayer.onDurationChanged.listen((Duration dd) {
      duration = dd;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      position = dd;
      notifyListeners();
    });
  }

}