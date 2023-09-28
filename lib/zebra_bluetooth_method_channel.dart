import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'zebra_bluetooth_platform_interface.dart';

/// An implementation of [ZebraBluetoothPlatform] that uses method channels.
class MethodChannelZebraBluetooth extends ZebraBluetoothPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zebra_bluetooth');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
