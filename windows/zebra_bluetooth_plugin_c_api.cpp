#include "include/zebra_bluetooth/zebra_bluetooth_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "zebra_bluetooth_plugin.h"

void ZebraBluetoothPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  zebra_bluetooth::ZebraBluetoothPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
