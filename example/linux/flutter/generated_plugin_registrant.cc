//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <zebra_bluetooth/zebra_bluetooth_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) zebra_bluetooth_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ZebraBluetoothPlugin");
  zebra_bluetooth_plugin_register_with_registrar(zebra_bluetooth_registrar);
}
