import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:exhibition_guide_app/model/ble_device.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:permission_handler/permission_handler.dart';

class DevicesProvider extends ChangeNotifier {
  final List<BleDevice> bleDevices = <BleDevice>[];
  BleManager _bleManager;

  DevicesProvider(this._bleManager);

  // 초기값
  List<BleDevice> _visibleDevicesController = <BleDevice>[];
  // 스트림
  StreamController<BleDevice> _devicePickerController = StreamController<BleDevice>();

  StreamSubscription<ScanResult> _scanSubscription;
  StreamSubscription _devicePickerSubscription;

  List<BleDevice> get visibleDevicesController => _visibleDevicesController;

  PermissionStatus _locationPermissionStatus = PermissionStatus.unknown;

  // Stream<BleDevice> get pickDevice => _deviceRepository

  // void _handlePickedDevice(BleDevice bleDevice) {
  //   _deviceRepository.pickDevice(bleDevice);
  // }

  void dispose() {
    print("##### cancel _devicePickerSubscription");
    _devicePickerSubscription.cancel();
    // _visibleDevicesController.close();
    _devicePickerController.close();
    _scanSubscription?.cancel();
  }

  void init() {
    print("##### Init devices bloc");
    bleDevices.clear();

    _bleManager
        .createClient(restoreStateAction: (peripherals) {
      /**
       * restoreStateAction: 시스템에서 복원 한 주변 장치에 대해 알리는 데 사용되는 콜백입니다.
       * iOS 전용
       */

      // 복원된 주변장치
      peripherals?.forEach((peripheral) {
        print("##### Restored peripheral: ${peripheral.name}");
      });
    })
        .catchError((e) => print("##### Couldn't create BLE client: $e"))
        .then((_) => _checkPermissions()) // 권한 확인
        .catchError((e) => print("##### Permission check error: $e"))
        .then((_) => _waitForBluetoothPoweredOn())  //블루투스 통신
        .then((_) => _startScan());

    if (_visibleDevicesController.isEmpty) {
      _visibleDevicesController = <BleDevice>[];
    }

    // 스트림 close
    if (_devicePickerController.isClosed) {
      // 스트림 초기화
      _devicePickerController = StreamController<BleDevice>();
    }

    print("##### listen to _devicePickerController.stream");
    // _devicePickerSubscription =
    //       _devicePickerController.stream.listen(_handlePickedDevice);
  }

  // 권한 체크
  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      var permissionStatus = await PermissionHandler()
          .requestPermissions([PermissionGroup.location]);

      _locationPermissionStatus = permissionStatus[PermissionGroup.location];

      if (_locationPermissionStatus != PermissionStatus.granted) {
        return Future.error(Exception("##### Location permission not granted"));
      }
    }
  }


  // 블루투스 통신을 기다린다.
  Future<void> _waitForBluetoothPoweredOn() async {
    Completer completer = Completer();
    StreamSubscription<BluetoothState> subscription;

    /**
     * observeBluetoothState: Bluetooth 어댑터의 상태에 대한 변경 스트림을 반환
     * 기본적으로 현재 상태로 스트림을 시작하지만
     * emitCurrentValue로 false를 전달하여 재정의 할 수 있습니다.
     */
    subscription = _bleManager
        .observeBluetoothState(emitCurrentValue: true)
        .listen((bluetoothState) async {
      if (bluetoothState == BluetoothState.POWERED_ON && !completer.isCompleted) {
        await subscription.cancel();
        completer.complete();
      }
    });
    print("##### completer.future: ${completer.future}");
    return completer.future;
  }

  void _startScan() {
    print("##### Ble client created");
    _scanSubscription = _bleManager.startPeripheralScan().listen((ScanResult scanResult) {
      var bleDevice = BleDevice(scanResult);
      if (scanResult.advertisementData.localName != null && !bleDevices.contains(bleDevice)) {
        print('found new device ${scanResult.advertisementData.localName} ${scanResult.peripheral.identifier}');
        bleDevices.add(bleDevice);
        // _visibleDevicesController.add(bleDevices.sublist(0));

        print("##### bleDevices: ${bleDevices}");
        print("##### _visibleDevicesController: ${_visibleDevicesController}");
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
        .catchError((e) => print("##### Couldn't refresh: $e"));
  }

}