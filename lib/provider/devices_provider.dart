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
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
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
  List<BetterPlayerDataSource> _dataSourceList = [];

  String _beaconResult = '';
  String _audioUrl = '';
  String _beforeBeaconIdx = "-1";
  String _minor = "";
  String _major = "";
  int _nrMessaggesReceived = 0;

  bool _playing = false; // 재성버튼 활성 default
  bool _isRunning = true;
  bool _beaconConnect = false;
  bool _autoPlayAudio = false;
  bool _isBeaconLoading = false;

  bool get isBeaconLoading => _isBeaconLoading;
  bool get isRunning => _isRunning;
  bool get isPlaying => _playing;
  bool get isBeaconConnect => _beaconConnect;
  bool get autoPlayAudio => _autoPlayAudio;
  List get dataSourceList => _dataSourceList;
  String get beforeBeaconIdx => _beforeBeaconIdx;
  BeaconModel get cBeaconData => beaconData;
  BeaconContentModel get beaconConteantList => _beaconContentList;

  DevicesProvider() {
    setDevicePreferences();
  }

  void initailBeaconData() {
    _major = "";
    _minor = "";
    print("##### initailBeaconData");
  }
  void setBeforeBeaconIdx (String idx) {
    _beforeBeaconIdx = idx;
    notifyListeners();
  }
  void setDevicePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final deacon = prefs.getBool("beaconOnOff");
    final audio = prefs.getBool("autoPlayAudio");

    _isRunning = deacon == null ? false : deacon;
    _autoPlayAudio = audio == null ? false : audio;

    becaonScan(_isRunning);
    setAutoPlayAudio(_autoPlayAudio);
  }

  void setIsRunning(bool running) {
    _isRunning = running;
    notifyListeners();
  }

  void setPlaying(bool py) {
    _playing = py;
    notifyListeners();
  }

  void setBeaconConnect(bool type) {
    _beaconConnect = type;
    notifyListeners();
  }
  void setIsBeaonLoading(result) {
    _isBeaconLoading = result;
    notifyListeners();
  }

  void becaonScan(bool type) async{
    _isBeaconLoading = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isRunning = type;
    prefs.setBool("beaconOnOff", type);
    if (type) {
      init();
      await BeaconsPlugin.startMonitoring();
      Timer(Duration(seconds: 10), () {
        if (!_isBeaconLoading) setIsBeaonLoading(false);
      });
    } else {
      await BeaconsPlugin.stopMonitoring();
      if (Platform.isAndroid) {
        // await BeaconsPlugin.runInBackground(false);
      }
      _isBeaconLoading = false;
    }
    notifyListeners();
  }

  void setInitdataSourceList() async {
    _dataSourceList = [];
  }

  void init() async {
    if (!_isRunning) {
      if (Platform.isIOS) {
        setIsBeaonLoading(false);
      }
      return;
    }

    if (Platform.isAndroid) {
      await BeaconsPlugin.startMonitoring();
      await BeaconsPlugin.runInBackground(true);

      _isBeaconLoading = false;
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "Need Location Permission",
          message: "This app collects location data to work with beacons.");
      // await BeaconsPlugin.clearDisclosureDialogShowFlag(true);
    }
    await BeaconsPlugin.listenToBeacons(beaconEventsController);
    BeaconsPlugin.setDebugLevel(2);
    // 비콘 정보
    // await BeaconsPlugin.clearRegions();
    await BeaconsPlugin.addRegion("test", "fda50693-a4e2-4fb1-afcf-c6eb07647825");
    // fda50693-a4e2-4fb1-afcf-c6eb07647825
    // UUID에 맞는 비콘 연결
    beaconEventsController.stream.listen((data) {
        if (data.isNotEmpty) {
          _beaconResult = data;
          setBeaconConnect(true);
          try{
            Map beacon = jsonDecode(data);
            beaconData = BeaconModel.fromJson(beacon);
            // print("#####_major: $_major");

            // 안드로이드 addRegion에 안걸릴 때
            if (beaconData.uuid == "fda50693-a4e2-4fb1-afcf-c6eb07647825"
                || beaconData.uuid == "FDA50693-A4E2-4FB1-AFCF-C6EB07647825") {

              if (_major == beaconData.major && _minor == beaconData.minor) return;

              _major = beaconData.major;
              _minor = beaconData.minor;

              beaconContentSelCall();
            }

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

    await BeaconsPlugin.runInBackground(true);
    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring();
          setIsRunning(true);
        }
      });
    } else if (Platform.isIOS) {
      // await BeaconsPlugin.runInBackground(true);
      await BeaconsPlugin.startMonitoring();
      setIsBeaonLoading(false);
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
        "UUID": beaconData.uuid,
        "Major": beaconData.major,
        "Minor": beaconData.minor,
      });
      print('##### beaconContentSelCall: $resp');
      final jsonData = json.decode("$resp");
      _exhibitItem = ExhibitItemModel.fromJson(jsonData);

      if (_exhibitItem.data != null) {
        int idx = _exhibitItem.data.idx;

        _audioUrl = _exhibitItem.data.voiceFile;
        temp.add(
          BetterPlayerDataSource(
            BetterPlayerDataSourceType.network,
            _exhibitItem.data.videoFile
          )
        );
        _dataSourceList = temp;
        if (_beforeBeaconIdx != idx.toString()) stopAudio();
        _beforeBeaconIdx = idx.toString();

        Getx.Get.to(ExhibitDetail(idx));
        // print("####t: $beforeBeaconIdx");

      }

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
      qrCodeDataSel(barcode);
    }catch(e) {
      print("#### scan error: $e");
    }
  }

  Future<void> qrCodeDataSel(code) async {
    try{
      Response resp;
      Dio dio = new Dio();

      resp = await dio.get(code);
      Map<String, dynamic> result = jsonDecode(resp.toString());

      Getx.Get.to(ExhibitDetail(result['data']['idx']));

    }catch(error) {
      print("##### qrCodeDataSel: $error");
    }
  }

  void setAutoPlayAudio(bool type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _autoPlayAudio = type;
    prefs.setBool("autoPlayAudio", type);
    notifyListeners();
  }

  //오디오 재생
  void playAudio() async {
    if (_playing) {
      // pause song
      var res = await audioPlayer.pause();
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

  void setExhibitDetAudio(String url) {
    _audioUrl = url;
  }

}