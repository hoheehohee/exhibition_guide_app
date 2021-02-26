import UIKit
import Flutter
import CoreLocation
import NaverThirdPartyLogin
import FBSDKCoreKit


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

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      let scheme = url.scheme

      if scheme!.contains("naver"){
        return NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
      } else if scheme!.contains("fb"){
        ApplicationDelegate.shared.application(
                UIApplication.shared,
                open: url,
                sourceApplication: nil,
                annotation: [UIApplication.OpenURLOptionsKey.annotation]
            )
      }
      return false
  }

}
