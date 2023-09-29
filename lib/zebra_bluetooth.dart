import 'zebra_bluetooth_platform_interface.dart';

class ZebraBluetooth {
  final ZebraBluetoothPlatform _platform = ZebraBluetoothPlatform.instance;

  ZebraBluetooth(void Function(String? error) onPrintResponse) {
    _platform.setOnPrintResponse(onPrintResponse);
  }

  Future<String?> getPlatformVersion() {
    return _platform.getPlatformVersion();
  }

  Future<List<String>> onDiscovery() {
    return _platform.onDiscovery();
  }

  Future<void> printZPLOverBluetooth(String zpl, String printer) {
    return _platform.printZPLOverBluetooth(zpl, printer);
  }
}
