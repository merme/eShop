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

    init(product: Product, shop: Shop, price: Double?) {
        
        self.init(barcode: product.barcode, shop: shop.getKey(), price: price)
        self.product = product
        self.shop = shop
    }
    
    init? (price:Price) {
        
        guard let _product = price.product,
            let _shop = price.shop else { return nil }
        
        self.init(product: _product, shop: _shop, price: price.price)
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
    
    func distanceInM(latitude: Double, longitude: Double) -> Double {
        return Shop(shopLocation: self.shopLocation).distanceInM(latitude: latitude, longitude: longitude)
    }
    
    func getShop(shopLocation:String, onCompletion: @escaping (Shop?) -> Void ) {
        DataManager.shared.getShop(shopLocation: shopLocation, onComplete: onCompletion)
    }

}

extension Price: Equatable {
    static func == (lhs: Price, rhs: Price) -> Bool {
        guard let _lhsShop = lhs.shop, let _rhsShop = rhs.shop else { return false }
        guard let _lhsProduct = lhs.product, let _rhsProduct = rhs.product else { return false }
        guard let _lhsPrice = lhs.price, let _rhsPrice = rhs.price else { return false }
        
        
        
        return _lhsShop == _rhsShop  && _lhsProduct == _rhsProduct && _lhsPrice == _rhsPrice
    }
}
