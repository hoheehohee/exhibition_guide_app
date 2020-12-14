import 'dart:async';
import 'dart:io';

import 'package:exhibition_guide_app/model/ble_device.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceProvider extends ChangeNotifier {
  final List<BleDevice> bleDevices = <BleDevice>[];
  BleManager _bleManager;
  StreamSubscription<ScanResult> _scanSubscription;
  DeviceProvider(this._bleManager);
  PermissionStatus _locationPermissionStatus = PermissionStatus.unknown;

  void dispose() {
    print("cancel _devicePickerSubscription");
    _scanSubscription?.cancel();
  }

  void init(){
    print("Init devices bloc");
    bleDevices.clear();
    _bleManager
        .createClient(
        // restoreStateIdentifier: "example-restore-state-identifier",
        restoreStateAction: (peripherals) {
          peripherals?.forEach((peripheral) {
            print("Restored peripheral: ${peripheral.name}");
          });
        })
        .catchError((e) => print("Couldn't create BLE client: $e"))
        .then((_) => _checkPermissions())
        .catchError((e) => print("Permission check error: $e"))
        .then((_) => _waitForBluetoothPoweredOn())
        .then((_) => _startScan());


    // await _bleManager.startPeripheralScan(
    //   uuids: [
    //     "74278BDA-B644-4520-8F0C-720EAF059935",
    //   ],
    // ).listen((scanResult) {
    //   //Scan one peripheral and stop scanning
    //   print("Scanned Peripheral ${scanResult.peripheral.name}, RSSI ${scanResult.rssi}");
    //   _bleManager.stopPeripheralScan();
    // });
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      var permissionStatus = await PermissionHandler()
          .requestPermissions([PermissionGroup.location]);

      _locationPermissionStatus = permissionStatus[PermissionGroup.location];

      if (_locationPermissionStatus != PermissionStatus.granted) {
        return Future.error(Exception("Location permission not granted"));
      }
    }
  }

  Future<void> _waitForBluetoothPoweredOn() async {
    Completer completer = Completer();
    StreamSubscription<BluetoothState> subscription;
    subscription = _bleManager
        .observeBluetoothState(emitCurrentValue: true)
        .listen((bluetoothState) async {
      if (bluetoothState == BluetoothState.POWERED_ON &&
          !completer.isCompleted) {
        await subscription.cancel();
        completer.complete();
      }
    });
    return completer.future;
  }

  void _startScan() {
    print("Ble client created");
    _scanSubscription =
        _bleManager.startPeripheralScan().listen((ScanResult scanResult) {
          var bleDevice = BleDevice(scanResult);
          if (scanResult.advertisementData.localName != null &&
              !bleDevices.contains(bleDevice)) {
            print('found new device ${scanResult.advertisementData.localName} ${scanResult.peripheral.identifier}');
          }
        });
  }

  Future<void> refresh() async {
    _scanSubscription.cancel();
    await _bleManager.stopPeripheralScan();
    bleDevices.clear();
    // _visibleDevicesController.add(bleDevices.sublist(0));
    await _checkPermissions()
        .then((_) => _startScan())
        .catchError((e) => print("Couldn't refresh: $e}"));
  }

}