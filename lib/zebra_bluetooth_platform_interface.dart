import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'zebra_bluetooth_method_channel.dart';

abstract class ZebraBluetoothPlatform extends PlatformInterface {
  /// Constructs a ZebraBluetoothPlatform.
  ZebraBluetoothPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZebraBluetoothPlatform _instance = MethodChannelZebraBluetooth();

  /// The default instance of [ZebraBluetoothPlatform] to use.
  ///
  /// Defaults to [MethodChannelZebraBluetooth].
  static ZebraBluetoothPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZebraBluetoothPlatform] when
  /// they register themselves.
  static set instance(ZebraBluetoothPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  // return the list of printer device names
  Future<List<String>> onDiscovery() {
    throw UnimplementedError('onDiscovery() has not been implemented.');
  }

  // the response of this method is handled by the ZebraResponse class
  Future<void> printZPLOverBluetooth(
    String zpl,
    String printer,
  ) {
    throw UnimplementedError(
        'printZPLOverBluetooth() has not been implemented.');
  }

  void setOnPrintResponse(
    void Function(String? error) onPrintResponse,
  ) {
    throw UnimplementedError('setOnPrintResponse() has not been implemented.');
  }
}
