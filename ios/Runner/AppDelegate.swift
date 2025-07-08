import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "flutter_app_settings", binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler { (call, result) in
      if (call.method == "openAppSettings") {
        if let url = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
          result(true)
        } else {
          result(FlutterError(code: "UNAVAILABLE", message: "Cannot open settings", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
