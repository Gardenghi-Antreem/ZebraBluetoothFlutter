package com.gellify.zebra_bluetooth

import androidx.annotation.NonNull
import com.zebra.sdk.comm.BluetoothConnection
import com.zebra.sdk.printer.SGD
import com.zebra.sdk.printer.ZebraPrinterFactory

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ZebraBluetoothPlugin */
class ZebraBluetoothPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "zebra_bluetooth")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
      "onDiscovery" -> result.success(emptyArray<String>());
      "printZPLOverBluetooth"-> {
        printZPLOverBluetooth(call.arguments)
        result.success("print lunched");
      };
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun onDiscovery():Array<String>{
    return emptyArray<String>()
  }

  private fun printZPLOverBluetooth(arguments: Any){
    try {
      var data = arguments as Map<String,String>;
      var zpl = data["zpl"];
      var printer = data["printer"];

      // Instantiate connection for given Bluetooth Device Name or MAC Address.
      val thePrinterConn = BluetoothConnection(printer)

      // Initialize
      thePrinterConn.open() // with the bluetooth connection raw data are sent
      SGD.SET("device.languages", "zpl", thePrinterConn)

      // Open the connection - physical connection is established here.
      val zPrinterIns = ZebraPrinterFactory.getInstance(thePrinterConn)

      Thread.sleep(100) //1sec

      // Send the data to printer
      zPrinterIns.sendCommand(zpl)

      // Make sure the data got to the printer before closing the connection
      Thread.sleep(500)

      // Close the connection to release resources.
      thePrinterConn.close()

      sendPrintResponse(null);
    } catch (e:Exception){
      sendPrintResponse(e.message);
    }
  }


  fun sendPrintResponse(error: String?) {
    channel.invokeMethod("printResponse", mapOf("error" to error))
  }
}

