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

    let key: String
    let latitude: Float
    let longitude: Float
    let name: String
    let ref: DatabaseReference?
    
    // MARK: - Private attribute
    let creation: Double

    // MARK: - Initializers
    init(name: String, latitude: Float, longitude: Float, key: String = "") {
        self.key = key
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.creation  = Date().timeIntervalSince1970
        self.ref = nil
    }

    init?(snapshot: DataSnapshot) {
        
        guard let _snapshotValue = snapshot.value as? [String: AnyObject] ,
            let _name = _snapshotValue[Field.name] as? String ,
            let _latitude = _snapshotValue[Field.latitude] as? Float,
            let _longitude = _snapshotValue[Field.longitude] as? Float,
            let _creation  =  _snapshotValue[Field.creation] as? Double else { return nil }

        key = snapshot.key
        name = _name
        latitude = _latitude
        longitude = _longitude
        creation = _creation
        ref = snapshot.ref
    }

    // MARK: - Public
    func toAnyObject() -> Any {
        return [
            Field.name: name,
            Field.latitude: latitude,
            Field.longitude: longitude,
            Field.creation: creation
        ]
    }

    func getKey() -> String {
        return String(format: "%.4f-%.4f", latitude, longitude)
            .replacingOccurrences(of: ".", with: "p", options: .literal, range: nil)
    }
    
    func isPointInRadious(latitude: Float, longitude: Float, radiousM:Float ) -> Bool {
        
        let user = CLCircularRegion(center: CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude)),
                                    radius: CLLocationDistance(radiousM), identifier: "user")
        return user.contains(CLLocationCoordinate2DMake(CLLocationDegrees(self.latitude), CLLocationDegrees(self.longitude)))
        /*
        let userSquare = CGRect(x: CGFloat(latitude - radious),
                                y: CGFloat(latitude + radious),
                                width: CGFloat(radious * 2),
                                height: CGFloat(radious * 2))
        
        let shopPoint = CGPoint(x: CGFloat(self.latitude),
                                y: CGFloat(self.longitude))
        
        return userSquare.contains(shopPoint)*/
    }

}
