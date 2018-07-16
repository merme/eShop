//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase
import CoreGraphics
import CoreLocation

struct Shop {

    struct Field {
        static let latitude   = "latitude"
        static let longitude  = "longitude"
        static let name     = "name"
        static let creation    = "creation"
    }
    static let gapErrorDistanceM:Double = 1.1132 * 10 * 3 //15.0
    static let gapErrorDistanceDegrees:Double = Shop.m2Degree(m:gapErrorDistanceM)

    static func m2Degree(m:Double) -> Double {
        return m * 0.00001 / 1.1132
    }

    static func degree2m(degrees:Double) -> Double {
        return degrees * 1.1132 / 0.00001
    }

    let key: String
    let latitude: Double
    let longitude: Double
    let name: String?
    let ref: DatabaseReference?

    // MARK: - Private attribute
    let creation: Double

    // MARK: - Initializers
    init(name: String?, latitude: Double, longitude: Double, key: String = "") {
        self.key = key
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.creation  = Date().timeIntervalSince1970
        self.ref = nil
    }

    init(shopLocation:String) {
        //41p4189-2p0008
        let splitted = shopLocation.replacingOccurrences(of: "p", with: ".").components(separatedBy: "-")
        guard splitted.count == 2 else { self.init(name: nil, latitude: 0, longitude: 0); return }

        self.init(name: nil, latitude: Double(splitted[0]) ?? 0, longitude: Double(splitted[1]) ?? 0)
    }

    init?(snapshot: DataSnapshot) {

        guard let _snapshotValue = snapshot.value as? [String: AnyObject] ,
            let _name = _snapshotValue[Field.name] as? String ,
            let _latitude = _snapshotValue[Field.latitude] as? Double,
            let _longitude = _snapshotValue[Field.longitude] as? Double,
            let _creation  =  _snapshotValue[Field.creation] as? Double else { return nil }

        key = snapshot.key
        name = _name.isEmpty ? nil : _name
        latitude = _latitude
        longitude = _longitude
        creation = _creation
        ref = snapshot.ref
    }

    // MARK: - Public
    func toAnyObject() -> Any {
        return [
            Field.name: name ?? "",
            Field.latitude: latitude,
            Field.longitude: longitude,
            Field.creation: creation
        ]
    }

    func getKey() -> String {
        return String(format: "%.4f-%.4f", latitude, longitude)
            .replacingOccurrences(of: ".", with: "p", options: .literal, range: nil)
    }

    func isPointInRadious(latitude: Double, longitude: Double, radiousM:Double ) -> Bool {

        let user = CLCircularRegion(center: CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude)),
                                    radius: CLLocationDistance(radiousM), identifier: "user")
        return user.contains(CLLocationCoordinate2DMake(CLLocationDegrees(self.latitude), CLLocationDegrees(self.longitude)))
    }

    func distanceInM(latitude: Double, longitude: Double) -> Double {
        /*
         let shop:CLLocation = CLLocation(latitude: CLLocationDegrees(self.latitude),
         longitude: CLLocationDegrees(self.latitude))

         let distance:Double = shop.distance(from: CLLocation(latitude: CLLocationDegrees(latitude),
         longitude: CLLocationDegrees(latitude)))

         return Double(round(10000 * distance) / 10000)
         */

        // func distance(lat1:Double, self.longitude:Double, lat2:Double, longitude:Double, unit:String) -> Double {
        let theta = self.longitude - longitude
        var dist = sin(deg2rad(deg: self.latitude)) * sin(deg2rad(deg: latitude)) + cos(deg2rad(deg: self.latitude)) * cos(deg2rad(deg: latitude)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist *= ( 60 * 1.1515 )

        dist *=  (1.609344 * 1000)

        return dist
        // }

    }

    private func deg2rad(deg:Double) -> Double {
        return deg * .pi / 180
    }

    private func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / .pi
    }

}

extension Shop: Equatable {
    static func == (lhs: Shop, rhs: Shop) -> Bool {
        return lhs.name == rhs.name && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
