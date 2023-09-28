#ifndef FLUTTER_PLUGIN_ZEBRA_BLUETOOTH_PLUGIN_H_
#define FLUTTER_PLUGIN_ZEBRA_BLUETOOTH_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace zebra_bluetooth {

class ZebraBluetoothPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ZebraBluetoothPlugin();

  virtual ~ZebraBluetoothPlugin();

  // Disallow copy and assign.
  ZebraBluetoothPlugin(const ZebraBluetoothPlugin&) = delete;
  ZebraBluetoothPlugin& operator=(const ZebraBluetoothPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace zebra_bluetooth

#endif  // FLUTTER_PLUGIN_ZEBRA_BLUETOOTH_PLUGIN_H_
