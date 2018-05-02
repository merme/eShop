//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase

struct ShopPrice {

    struct Field {
        static let shop  = "shop"
        static let price     = "price"
        static let creation = "creation"
    }

    let key: String
    let shop: String
    let price: Double
    let creation: Double
    let ref: DatabaseReference?

    init(shop: String, price: Double, key: String = "") {
        self.key = key
        self.shop = shop
        self.price = price
        self.creation = Date().timeIntervalSince1970
        self.ref = nil
    }

    init?(snapshot: DataSnapshot) {
        guard let _snapshotValue = snapshot.value as? [String: AnyObject] ,
            let _name = _snapshotValue[Field.name] as? String ,
            let _barcode = _snapshotValue[Field.barcode] as? String,
            let _creation = _snapshotValue[Field.creation] as? Double else { return nil }

        key = snapshot.key
        name = _name
        barcode = _barcode
        creation = _creation
        ref = snapshot.ref
    }

    func toAnyObject() -> Any {
        return [
            Field.name: name,
            Field.barcode: barcode,
            Field.creation:  creation
        ]
    }

}
