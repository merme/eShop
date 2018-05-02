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
    static let gapErrorDistance:Double = 15.0

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

    init(key:String) {
        //41p4189-2p0008
        let splitted = key.replacingOccurrences(of: "p", with: ".").components(separatedBy: "-")
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

        let shop:CLLocation = CLLocation(latitude: CLLocationDegrees(self.latitude),
                                         longitude: CLLocationDegrees(self.latitude))

        let distance:Double = shop.distance(from: CLLocation(latitude: CLLocationDegrees(latitude),
                                                             longitude: CLLocationDegrees(latitude)))

        return Double(round(10000 * distance) / 10000)
    }

}
