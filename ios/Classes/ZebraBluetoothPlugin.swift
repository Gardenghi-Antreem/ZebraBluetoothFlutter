import Flutter
import UIKit

public class ZebraBluetoothPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zebra_bluetooth", binaryMessenger: registrar.messenger())
    let instance = ZebraBluetoothPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "onDiscovery":
      result(onDiscovery())
    case "printZPLOverBluetooth":
      printZPLOverBluetooth(data: call.arguments)
      result("printZPLOverBluetooth")
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func onDiscovery() -> [String] {
    var serialNumbers:[String] = [];
      let sam = EAAccessoryManager.shared();
      var connectedAccessories = sam.connectedAccessories;
      for accessory in connectedAccessories{
          if accessory.protocolStrings.contains("com.zebra.rawport") {
              serialNumbers.append(accessory.serialNumber);
             }
      }
      return serialNumbers
  }

  private func printZPLOverBluetooth(data:Any) -> Void {
    var data = arguments as Map<String,String>;
    var zpl = data["zpl"];
    var printer = data["printer"];
    var errorMessage: String? = nil
    // execute print in a different thread than the Graphic one
    self.printOverBluetoothWithGCD(zpl: zpl,printer: printer);
  }

  // print over bluetooth with GCD
  func printOverBluetoothWithGCD(zpl: String, printer: String) {
          DispatchQueue.global(qos: .default).async {
            do {
                var thePrinterConn: (NSObjectProtocol & ZebraPrinterConnection)? = nil;
                // create a bluetooth connection
                thePrinterConn = try? MfiBtPrinterConnection(serialNumber: printer);
                // open bluetooth connection
                if let didOpen = thePrinterConn?.open() {
                    var error: NSError?;
                  //set printer language to zpl
                    try SGD.set("device.languages", withValue: "zpl", andWithPrinterConnection: thePrinterConn);
                  // Send the data to printer as a byte array.
                    try thePrinterConn?.write(zpl.data(using: .utf8), error: &error);
                  // Close the connection
                    thePrinterConn?.close();
                    self.sendPrintResponse(true, nil)
                } else {
                    self.completion(false, "Connection to the printer Failed");
                }
            } catch let error {
                let errorInfo = error.localizedDescription;
                self.sendPrintResponse(false, errorInfo);
            }
        }
  }

  func sendPrintResponse(error:String?){
     DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.channel.invokeMethod("nativeCallSomeFlutterMethod", arguments: ["error": error]])
        }
  }

}
