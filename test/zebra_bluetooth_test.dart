import 'package:flutter_test/flutter_test.dart';
import 'package:zebra_bluetooth/zebra_bluetooth.dart';
import 'package:zebra_bluetooth/zebra_bluetooth_platform_interface.dart';
import 'package:zebra_bluetooth/zebra_bluetooth_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZebraBluetoothPlatform
    with MockPlatformInterfaceMixin
    implements ZebraBluetoothPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ZebraBluetoothPlatform initialPlatform = ZebraBluetoothPlatform.instance;

  test('$MethodChannelZebraBluetooth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZebraBluetooth>());
  });

  test('getPlatformVersion', () async {
    ZebraBluetooth zebraBluetoothPlugin = ZebraBluetooth();
    MockZebraBluetoothPlatform fakePlatform = MockZebraBluetoothPlatform();
    ZebraBluetoothPlatform.instance = fakePlatform;

    expect(await zebraBluetoothPlugin.getPlatformVersion(), '42');
  });
}
