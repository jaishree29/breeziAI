import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  Future<void> toggle(String state) async {
    if (state == 'on') {
      await FlutterBluePlus.turnOn();
      print("Bluetooth turned ON");
    } else if (state == 'off') {
      await FlutterBluePlus.turnOff();
      print("Bluetooth turned OFF");
    }
  }
}
