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

    // MARK: - Private attributes
    private struct ReferenceKey {
        static let products = "products"
        static let shops  = "shops"
        static let prices = "prices"
    }

    private let productsKeyReference = Database.database().reference(withPath:ReferenceKey.products)
    private let shopsKeyReference = Database.database().reference(withPath:ReferenceKey.shops)
    private let pricesKeyReference = Database.database().reference(withPath:ReferenceKey.prices)

    private init() {

    }

    func reset() {
        self.productsKeyReference.ref.removeValue()
        self.shopsKeyReference.ref.removeValue()
        self.pricesKeyReference.ref.removeValue()
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

    func exists(latitude: Double, longitude: Double,onComplete:@escaping (Shop?) -> Void) {
        self.find(latitude: latitude, longitude: longitude, radious: Shop.gapErrorDistance) { shops in
            // guard shops.isEmpty else { onComplete(nil); return }
            onComplete(shops.first ?? nil)
        }
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

    func find(latitude:Double, longitude:Double, radious:Double,  onComplete:@escaping ([Shop]) -> Void ) {

        shopsKeyReference
            .queryOrdered(byChild: Shop.Field.creation)
            .observeSingleEvent(of: .value, with: { snapshot in
                let shops:[Shop] = snapshot.children.map {
                    let jsonShop = $0
                    let shop = Shop(snapshot: jsonShop as! DataSnapshot) ?? Shop(name: "Invalid", latitude: 0, longitude: 0)
                    return shop.isPointInRadious(latitude: latitude, longitude: longitude, radiousM: radious) ?
                        shop : Shop(name: "Invalid", latitude: 0, longitude: 0)
                    }.filter {
                        return $0.name != "Invalid"
                }
                onComplete(shops)
            })
    }

    // MARK: - Price
    
    func create(price:Price) {

        self.pricesKeyReference.child(price.getKey()).setValue(price.toAnyObject())
    }

    func find(product:Product, shop:Shop, onComplete: @escaping (Price) -> Void) {
        let _key:String = "\(product.barcode)-\(shop.getKey())"
        pricesKeyReference.child(_key).observeSingleEvent(of: .value, with: { snapshot in

            //var price = Price(snapshot: snapshot )
            var price = Price(barcode: product.getKey(), shop: shop.getKey(), price: nil)
            if Price(snapshot: snapshot) == nil {
                self.create(price: price)
            } else {
                price = Price(snapshot: snapshot )!
            }

            price.shop = shop
            price.product = product
            onComplete(price)
        })
    }
    
    func find(latitude:Double,longitude:Double, barcode:String, onComplete: @escaping  (Price) -> Void ) {
        
        self.find(latitude: latitude, longitude: longitude, radious: Shop.gapErrorDistance) { shopsFound in
            
            var shop =  Shop(name: nil, latitude: latitude, longitude: longitude)
            if shopsFound.isEmpty {
                self.create(shop: shop)
            } else {
                shop = shopsFound.first!
            }
            
            self.find(barcode: barcode, onComplete: { productFound in
                
                var product =  Product(name: nil, barcode: barcode)
                if productFound == nil {
                    self.create(product: product)
                } else {
                    product = productFound!
                }
                
                self.find(product: product, shop: shop, onComplete: { price in
                    onComplete(price)
                })
            })
        }
    }
    
    func find(latitude:Double,longitude:Double, radious: Double, barcode:String, sortByPrice:Bool = false, onComplete: @escaping  ([Price]) -> Void ) {
        
        pricesKeyReference
            .queryOrdered(byChild: Price.Field.barcode)
            .queryEqual(toValue: barcode).observeSingleEvent(of: .value) { snapshot in
            let prices:[Price] = snapshot.children
                .map { return Price(snapshot: $0 as! DataSnapshot) ?? Price(barcode: "", shop: "", price: nil) }
                .filter { return $0.price != nil }
                .sorted(by: {
                    /*if sortByPrice {
                      return   $0.price! < $1.price!
                    } else {
                      return  $0.distanceInM(latitude:latitude,longitude:longitude) < $1.distanceInM(latitude:latitude,longitude:longitude)
                    }*/
                    return sortByPrice ? $0.price! < $1.price! : $0.distanceInM(latitude:latitude,longitude:longitude) < $1.distanceInM(latitude:latitude,longitude:longitude)
                    
                })
            
            onComplete(prices)
        }
        
    }
}
