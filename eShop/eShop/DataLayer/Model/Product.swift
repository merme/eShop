//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase

struct Product {
    
    let key: String
    let barcode: String
    let name: String
    let ref: DatabaseReference?
    
    
    init(name: String, barcode: String, key: String = "") {
        self.key = key
        self.name = name
        self.barcode = barcode
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let _snapshotValue = snapshot.value as? [String: AnyObject] ,
         let _name = _snapshotValue["name"] as? String ,
         let _barcode = _snapshotValue["barcode"] as? String else { return nil }
        
        key = snapshot.key
        name = _name
        barcode = _barcode
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "barcode": barcode
        ]
    }
    
}
