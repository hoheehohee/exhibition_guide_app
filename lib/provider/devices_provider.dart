import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:better_player/better_player.dart';
import 'package:dio/dio.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_detail.dart';
import 'package:exhibition_guide_app/message.dart';
import 'package:exhibition_guide_app/model/beacon_content_model.dart';
import 'package:exhibition_guide_app/model/beacon_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as Getx;


class DevicesProvider with ChangeNotifier {
  final StreamController<String> beaconEventsController = StreamController<String>.broadcast();
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();

  BeaconModel beaconData;
  BeaconContentModel _beaconContentList = BeaconContentModel.fromJson({"data": []});
  // List _dataSourceList = List<BetterPlayerDataSource>();
  List<BetterPlayerDataSource> _dataSourceList = [];

  bool _beaconConnect = false;
  String _qrCode = '';
  String _beaconResult = '';
  String _audioUrl = '';
  int _nrMessaggesReceived = 0;

  bool _playing = false; // 재성버튼 활성 default
  bool _isRunning = true;

  bool get isRunning => _isRunning;
  bool get isPlaying => _playing;
  bool get isBeaconConnect => _beaconConnect;
  List get dataSourceList => _dataSourceList;
  BeaconContentModel get beaconConteantList => _beaconContentList;

  void setIsRunning(bool running) {
    _isRunning = running;
    notifyListeners();
  }

  void setPlaying(bool py) {
    _playing = py;
  }

  void setBeaconConnect(bool type) {
    _beaconConnect = type;
  }

  void becaonScan(bool type) async{
    print("####becaonScan ${type}");
    if (type) {
      await BeaconsPlugin.startMonitoring;
    } else {
      await BeaconsPlugin.stopMonitoring;
    }
    _isRunning = type;
    notifyListeners();
  }

  void setInitdataSourceList() async {
    _dataSourceList = [];
  }

  void init() async {
    // beaconContentSelCall();
    if (Platform.isAndroid) {
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "Need Location Permission",
          message: "This app collects location data to work with beacons.");
    }

    BeaconsPlugin.listenToBeacons(beaconEventsController);

    // 비콘 정보
    await BeaconsPlugin.addRegion("", "FDA50693-A4E2-4FB1-AFCF-C6EB07647825");
    // UUID에 맞는 비콘 연결
    beaconEventsController.stream.listen((data) {
        if (data.isNotEmpty) {
          _beaconResult = data;
          print("###### beacon data: $data");
          try{
            Map beacon = jsonDecode(data);
            beaconData = BeaconModel.fromJson(beacon);
            beaconContentSelCall();
          }catch(error) {
            print("error: $error");
          }
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

  // 비콘 API Call
  Future<void> beaconContentSelCall() async {
    Dio dio = new Dio();
    Response resp;
    List<BetterPlayerDataSource> temp = [];
    try{
      resp = await dio.get(BASE_URL + '/beaconSearch.do', queryParameters: {
        "UUID": beaconData.uuid,
        "Major": beaconData.major,
        "Minor": beaconData.minor,
      });
      final jsonData = json.decode("$resp");
      _beaconContentList = BeaconContentModel.fromJson(jsonData);
      // 비콘 통신 목록 중 첫번째 오디오 데이터 저장
      _audioUrl = _beaconContentList.data[0].voiceFile;
      // 비콘 통신 목록 중 비디오 목록 데이터 저장
      _beaconContentList.data.forEach((element) {
        print("### element.videoFile ${element.videoFile}");
        temp.add(
          BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            element.videoFile
            // "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4"
          ),
        );
      });
      _dataSourceList = temp;
      _beaconConnect = true;
      becaonScan(false);

      Getx.Get.to(ExhibitDetail(_beaconContentList.data[0].idx));

    }catch(error) {
      becaonScan(false);
      print("#### beaconContentSelCall error: $error");
    }
    notifyListeners();
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
      // var res = await audioPlayer.play('https://luan.xyz/files/audio/ambient_c_motion.mp3');
      var res = await audioPlayer.play(_audioUrl);
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

  // 오디오 정지
  void stopAudio() async {
    position = new Duration();
    duration = new Duration();
    audioPlayer.stop();
    setPlaying(false);

    notifyListeners();
  }

  // 전시물 상세 동영상 지정
  void setExhibitDetVideo(String url) {
    _dataSourceList.add(
      BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        url
      ),
    );
  }

}