import 'dart:async';
import 'dart:io';

import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class DevicesProvider extends ChangeNotifier {
  final StreamController<String> beaconEventsController = StreamController<String>.broadcast();

  String _beaconResult = 'Not Scanned Yet.';
  int _nrMessaggesReceived = 0;
  bool isRunning = false;

  void init() async {
      if (Platform.isAndroid) {
        await BeaconsPlugin.setDisclosureDialogMessage(
            title: "Need Location Permission",
            message: "This app collects location data to work with beacons.");
      }

      BeaconsPlugin.listenToBeacons(beaconEventsController);

      await BeaconsPlugin.addRegion("wwwhohee42878", "74278BDA-B644-4520-8F0C-720EAF059935");

      beaconEventsController.stream.listen((data) {
          print("############ beaconEventsController ########### ");
          if (data.isNotEmpty) {
            print("##### Beacons DataReceived: $data");
            _beaconResult = data;
            _nrMessaggesReceived++;
          }
      },
      onDone: () {},
      onError: (error) {
        print("##### error: $error");
      });

      // 백그라운드에서 실행
      await BeaconsPlugin.runInBackground(true);

      if (Platform.isAndroid) {
        BeaconsPlugin.channel.setMethodCallHandler((call) async {
          if (call.method == 'scannerReady') {
            await BeaconsPlugin.startMonitoring;
            isRunning = true;
          }
        });
      } else if (Platform.isIOS) {
        await BeaconsPlugin.startMonitoring;
        isRunning = true;
      }
  }

  void dispose() {
    beaconEventsController.close();
  }
}