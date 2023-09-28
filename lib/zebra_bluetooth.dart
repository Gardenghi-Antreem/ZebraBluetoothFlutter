
import 'zebra_bluetooth_platform_interface.dart';

class ZebraBluetooth {
  Future<String?> getPlatformVersion() {
    return ZebraBluetoothPlatform.instance.getPlatformVersion();
  }
}
