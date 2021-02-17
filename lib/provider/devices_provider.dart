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
import 'package:exhibition_guide_app/model/exhibit_item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as Getx;
import 'package:shared_preferences/shared_preferences.dart';


class DevicesProvider with ChangeNotifier {
  final StreamController<String> beaconEventsController = StreamController<String>.broadcast();
  var _language;

  Duration duration = new Duration();
  Duration position = new Duration();
  AudioPlayer audioPlayer = new AudioPlayer();

  BeaconModel beaconData;
  BeaconContentModel _beaconContentList = BeaconContentModel.fromJson({"data": []});
  ExhibitItemModel _exhibitItem = ExhibitItemModel.fromJson({"data": null});
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
  BeaconModel get cBeaconData => beaconData;
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
    notifyListeners();
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
    print("#####${Platform.isAndroid}");

    // 백그라운드에서 실행
    // await BeaconsPlugin.startMonitoring;
    // await BeaconsPlugin.runInBackground(true);

    if (Platform.isAndroid) {
      // 백그라운드에서 실행
      await BeaconsPlugin.startMonitoring;
      await BeaconsPlugin.runInBackground(true);

      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "Need Location Permission",
          message: "This app collects location data to work with beacons.");
    }
    await BeaconsPlugin.listenToBeacons(beaconEventsController);

    // 비콘 정보
    await BeaconsPlugin.addRegion("", "FDA50693-A4E2-4FB1-AFCF-C6EB07647825");

    // UUID에 맞는 비콘 연결
    beaconEventsController.stream.listen((data) {
      print("###### beacon data: $data");
        if (data.isNotEmpty) {
          _beaconResult = data;
          setBeaconConnect(true);
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



    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
          setIsRunning(true);
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.runInBackground(true);
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

      SharedPreferences prefs = await SharedPreferences.getInstance();
      _language = prefs.getString('language');

      resp = await dio.get(BASE_URL + '/beaconSearchOne.do', queryParameters: {
        // "UUID": beaconData.uuid,
        // "Major": beaconData.major,
        // "Minor": beaconData.minor,
        "UUID": "FDA50693-A4E2-4FB1-AFCF-C6EB07647825",
        "Major": "10004",
        "Minor": "54460"
      });
      final jsonData = json.decode("$resp");
      _exhibitItem = ExhibitItemModel.fromJson(jsonData);

      if (_exhibitItem.data != null) {
        int idx = _exhibitItem.data.idx;
        Getx.Get.to(ExhibitDetail(idx));

        _audioUrl = _exhibitItem.data.voiceFile;
        temp.add(
          BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            _exhibitItem.data.videoFile
          )
        );
        _dataSourceList = temp;
        Getx.Get.to(ExhibitDetail(idx));
      }

      becaonScan(false);

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
      qrCodeDataSel(barcode);
    }catch(e) {
      print("#### scan error: $e");
    }
  }

  Future<void> qrCodeDataSel(code) async {
    try{
      Response resp;
      Dio dio = new Dio();

      resp = await dio.get(
        BASE_URL + '/QRSearch.do',
        queryParameters: {"QRCode": code}
      );
      Map<String, dynamic> result = jsonDecode(resp.toString());

      Getx.Get.to(ExhibitDetail(result['data']['idx']));

    }catch(error) {
      print("##### qrCodeDataSel: $error");
    }
  }

  //오디오 재생
  void playAudio() async {
    print("#####_playing $_playing");
    if (_playing) {
      // pause song
      var  res = await audioPlayer.pause();
      if (res == 1) {
        setPlaying(false);
      }
    } else {
      // play song
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
    duration = Duration(seconds: 0);
    position = Duration(seconds: 0);

    audioPlayer.stop();
    setPlaying(false);

    notifyListeners();
  }

  // 전시물 상세 동영상 지정
  void setExhibitDetVideo(String url) {
    List<BetterPlayerDataSource> temp = [];
    temp.add(
      BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          url
      ),
    );
    _dataSourceList = temp;
  }

}