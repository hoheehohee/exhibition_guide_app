//디바이스 정보 저장용 클래스
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class BleDevice {
  String deviceName;
  Peripheral peripheral;
  int rssi;
  AdvertisementData advertisementData;
  BleDevice(this.deviceName, this.rssi, this.peripheral, this.advertisementData);
}