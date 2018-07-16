//
//  GeoLocationManager.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import RxSwift
import RxCocoa

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared: LocationManager = LocationManager()

    struct DefaultPosition {
        static let latitude = 41.4189
        static let longitude = 2.0008
    }

    static let zoomDegree = 0.04 //2 Kms
    static let locationUpdateNotification = "locationUpdateNotification"

    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 100
        return manager
    }()

    var isAuthorizadionDenied:Bool {
        return CLLocationManager.authorizationStatus() == .denied
    }

    var disposeBag = DisposeBag()

    private var currentLocation:CLLocation?

    override private init() {
        super.init()
    }

    // MARK: - Public / Helpers
    func requestOrRememberLocationAuthorization() {

        if  self.isAuthorizadionDenied {
            self.informUserOfPermissions()
        } else {
            locationManager.requestAlwaysAuthorization()//requestWhenInUseAuthorization()
        }
    }

    // MARK: - CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            self.informUserOfPermissions()
        } else {
            manager.startUpdatingLocation()
        }
    }
    enum LocationError:Error {
        case noCurrentLocation
    }

    func getCurrentLocation() -> Single<CLLocation> {
        return Single.create(subscribe: { [weak self] single -> Disposable in

            let disposable = Disposables.create()

            guard  NSClassFromString("XCTest") == nil else {
                single(.success(CLLocation(latitude: LocationManager.DefaultPosition.latitude/*41.4189*/,longitude: LocationManager.DefaultPosition.longitude/*2.0008*/)))
                return disposable
            }

            guard let weakSelf = self,
                let _currentLocation = weakSelf.currentLocation else {
                    single(.error(LocationError.noCurrentLocation))
                    return disposable
            }
            single(.success(_currentLocation))
            return disposable
        })
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.isEmpty == false else { return }
        self.currentLocation = locations[0]
        print("lat:\(locations[0].coordinate.latitude) lon:\(locations[0].coordinate.longitude)")
        //  NotificationManager.shared.notify(name:GeoLocationManager.locationUpdateNotification, userInfo: nil)
    }

    // MARK: - Private/Internal
    func informUserOfPermissions() {

        //let disposeBag = DisposeBag()
        guard let _topController = UIApplication.topViewController() else { return }

        let actions: [UIAlertController.AlertAction] = [
            .action(title: "OK", style: .destructive),
            .action(title: "feedback_messages_multiple_screens_location_services_not_granted_label_message.key.localized" )
        ]

        UIAlertController
            .present(in: _topController,
                     title: "feedback_messages_multiple_screens_location_services_not_granted_label_title",
                     message: "message",
                     style: .alert,
                     actions: actions)
            .subscribe {
                switch $0 {
                case .success(let buttonIndex):
                    if buttonIndex == 1 {
                        guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
                        UIApplication.shared.fvc_open(url)
                    }
                default: return
                }
        }/*.disposed(by: disposeBag)*/ // COMMENT IN BECAUSE IN A SINGLETON CLASS LIKE THIS ONE disposable observable code is called just before receiving first next.

        /*
         let alertController = UIAlertController(title: "feedback_messages_multiple_screens_location_services_not_granted_label_title",
         message: "feedback_messages_multiple_screens_location_services_not_granted_label_message.key.localized",
         preferredStyle: .alert)
         let dismiss = UIAlertAction(title: "OK", style: .default ,handler: nil)
         alertController.addAction(dismiss)

         let openSettings = UIAlertAction(title: "Open",
         style: .default, handler: { _ in
         guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }
         UIApplication.shared.fvc_open(url)
         })
         alertController.addAction(openSettings)
         UIApplication.present(viewController: alertController, animated: true, completion: nil)*/

    }
}

extension UIApplication {

}
