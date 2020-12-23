import UIKit
import Flutter
import KakaoOpenSDK
import CoreLocation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  let locationManager = CLLocationManager()

  override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

      locationManager.requestAlwaysAuthorization()
      GeneratedPluginRegistrant.register(with: self)

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      if KOSession.handleOpen(url) {
          return true
      }
      return false
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      if KOSession.handleOpen(url) {
          return true
      }
      return false
  }
}
