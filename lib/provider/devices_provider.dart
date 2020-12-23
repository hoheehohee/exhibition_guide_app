import 'dart:async';
import 'dart:io';

import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class DevicesProvider extends ChangeNotifier {
  final StreamController<String> beaconEventsController = StreamController<String>.broadcast();

  String _beaconResult = 'Not Scanned Yet.';
  int _nrMessaggesReceived = 0;

  bool _isRunning = false;

  get isRunning => _isRunning;

  void setIsRunning(bool running) {
    _isRunning = running;
    notifyListeners();
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
}