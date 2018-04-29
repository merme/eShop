//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase

final class FirebaseManager {

    static let shared = FirebaseManager()

    // MARK:- Private attributes
    private struct ReferenceKey {
        static let products = "products"
        static let shops  = "shops"
    }

    private let productsKeyReference = Database.database().reference(withPath:ReferenceKey.products)
    private let shopsKeyReference = Database.database().reference(withPath:ReferenceKey.shops)

    private init() {

    }

    func reset() {
        self.productsKeyReference.ref.removeValue()
        self.shopsKeyReference.ref.removeValue()
    }

    // MARK: - Products

    func create(product:Product) {

        self.productsKeyReference.child(product.barcode).setValue(product.toAnyObject())
    }

    func delete(product:Product) {

        self.productsKeyReference.child(product.barcode).ref.removeValue()
    }

    func products(onComplete:@escaping ([Product]) -> Void ) {

        productsKeyReference
            .queryOrdered(byChild: Shop.Field.creation)
            .observeSingleEvent(of: .value, with: { snapshot in
            let products:[Product] = snapshot.children.map {
                let jsonProduct = $0
                return Product(snapshot: jsonProduct as! DataSnapshot)!
            }
            onComplete(products)
        })
    }

    func find(barcode:String, onComplete:@escaping (Product?) -> Void ) {

        productsKeyReference.child(barcode).observeSingleEvent(of: .value, with: { snapshot in
            onComplete(Product(snapshot: snapshot ))
        })
    }

    // MARK: - Shop
    func create(shop:Shop) {

        self.shopsKeyReference.child(shop.getKey()).setValue(shop.toAnyObject())
    }
    
    func shops(onComplete:@escaping ([Shop]) -> Void ) {
        
        shopsKeyReference
            .queryOrdered(byChild: Shop.Field.creation)
            .observeSingleEvent(of: .value, with: { snapshot in
            let shops:[Shop] = snapshot.children.map {
                let jsonShop = $0
                return Shop(snapshot: jsonShop as! DataSnapshot)!
            }
            onComplete(shops)
        })
    }
    
    func find(latitude:Float, longitude:Float, radious:Float,  onComplete:@escaping ([Shop]) -> Void ) {
        
        shopsKeyReference
            .queryOrdered(byChild: Shop.Field.creation)
            .observeSingleEvent(of: .value, with: { snapshot in
            let shops:[Shop] = snapshot.children.map {
                let jsonShop = $0
                let shop = Shop(snapshot: jsonShop as! DataSnapshot) ?? Shop(name: "Invalid", latitude: 0, longitude: 0)
                return shop.isPointInRadious(latitude: latitude, longitude: longitude, radiousM: radious) ? shop : Shop(name: "Invalid", latitude: 0, longitude: 0)
                }.filter {
                    return $0.name != "Invalid"
            }
            onComplete(shops)
           
          //  onComplete(Product(snapshot: snapshot ))
        })
    }
}
