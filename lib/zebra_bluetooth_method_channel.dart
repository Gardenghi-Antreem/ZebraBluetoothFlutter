import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'zebra_bluetooth_platform_interface.dart';

/// An implementation of [ZebraBluetoothPlatform] that uses method channels.
class MethodChannelZebraBluetooth extends ZebraBluetoothPlatform {
  static const channelName = 'zebra_bluetooth';
  void Function(String? error)? onPrintResponse;

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(channelName);

  MethodChannelZebraBluetooth() {
    methodChannel.setMethodCallHandler(methodHandler);
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<String>> onDiscovery() async {
    final List<String>? printers =
        await methodChannel.invokeMethod<List<String>>('onDiscovery');
    return printers ?? [];
  }

  @override
  Future<void> printZPLOverBluetooth(
    String zpl,
    String printer,
  ) async {
    await methodChannel.invokeMethod<void>(
      'printZPLOverBluetooth',
      <String, String>{
        'zpl': zpl,
        'printer': printer,
      },
    );
  }

  @override
  void setOnPrintResponse(
    void Function(String? error) onPrintResponse,
  ) {
    this.onPrintResponse = onPrintResponse;
  }

  Future<void> methodHandler(MethodCall call) async {
    final String data = call.arguments;

    switch (call.method) {
      case 'printResponse':
        onPrintResponse?.call(data);
        break;
      default:
        print('no method handler for method ${call.method}');
    }
  }
}
