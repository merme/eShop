//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase

struct Price {

    struct Field {
        static let barcode  = "barcode"
        static let shop      = "shop"
        static let price     = "price"
        static let creation  = "creation"
    }

    let key: String
    let barcode: String
    let shopLocation: String
    let price: Double?
    let creation: Double
    let ref: DatabaseReference?

    var product:Product?
    var shop:Shop?

    init (barcode: String, shop: String,price: Double?, key: String = "") {
        self.key = key
        self.price = price
        self.barcode = barcode
        self.shopLocation = shop
        self.creation = Date().timeIntervalSince1970
        self.ref = nil
    }

    init?(snapshot: DataSnapshot) {
        guard let _snapshotValue = snapshot.value as? [String: AnyObject] ,
            let _price = _snapshotValue[Field.price] as? Double ,
            let _barcode = _snapshotValue[Field.barcode] as? String,
            let _shop = _snapshotValue[Field.shop] as? String,
            let _creation = _snapshotValue[Field.creation] as? Double else { return nil }

        key = snapshot.key
        price = _price == 0 ? nil : _price
        barcode = _barcode
        shopLocation = _shop
        creation = _creation
        ref = snapshot.ref
    }

    func toAnyObject() -> Any {
        return [
            Field.shop: shopLocation,
            Field.barcode: barcode,
            Field.price: price == nil ? 0 : price!,
            Field.creation:  creation
        ]
    }

    // MARK: - Public methods
    func getKey() -> String {
        return "\(barcode)-\(shopLocation)"
    }
 /*
    func shop(onComplete: @escaping (Shop) -> Void ) {
        guard shop == nil else { onComplete(self.shop!); return }
        var shop = Shop(key: shopLocation)
        FirebaseManager.shared.find(latitude: shop.latitude, longitude: shop.longitude, radious: Shop.gapErrorDistance) { shops in
            guard shops.count == 1 else { return }
            onComplete(shops[1])
        }
    }
    
    func product(onComplete: (Shop) -> Void ) {
        guard product == nil else { onComplete(self.product!); return}
        FirebaseManager.shared.find(barcode: barcode) { productFound in
            guard let _product = productFound else { return }
            onComplete(_product)
        }
    }
*/
    func distanceInM(latitude: Double, longitude: Double) -> Double {
        return Shop(key: self.shopLocation).distanceInM(latitude: latitude, longitude: longitude)
    }

}
