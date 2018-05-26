//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase
import RxSwift

final class DataManager {

    static let shared = DataManager()

    private init() {

    }

    func reset() {
        FirebaseManager.shared.reset()
    }
    
    // MARK:- Products
    
    // MARK: - Shop
    
    // MARK: - Price
    func create(price:Price) -> Completable {
        return Completable.create { completable in
            
            FirebaseManager.shared.create(price:price)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func find(latitude:Double,longitude:Double, barcode:String, onComplete: @escaping  (Price) -> Void ) {
        
        FirebaseManager.shared.find(latitude: latitude, longitude: longitude, barcode: barcode, onComplete: onComplete)
    }
    
    func find(latitude:Double,longitude:Double, barcode:String) -> Single<Price> {
        return Single.create {  [weak self] single in
                let disposable = Disposables.create()
            /*
            FirebaseManager.shared.find(latitude: latitude, longitude: longitude, barcode: barcode, onComplete: { price in
                single(.success(price))
            })*/
            DataManager.shared.find(latitude: latitude,
                                    longitude: longitude,
                                    barcode: barcode,
                                    radious: Shop.gapErrorDistanceM).subscribe({ event in
                switch event {
                case .success(let prices):
                    guard prices.isEmpty == false else {
                        DataManager.shared.find(latitude: latitude, longitude: longitude, barcode: barcode, onComplete: { (product, shop) in
                            let price = Price(product:product,
                                              shop: shop,
                                              price: nil)
                            
                            single(.success(price))
                        })
                        /*
                        var product =  Product(name: nil, barcode: barcode)
                        FirebaseManager.shared.find(barcode: barcode, onComplete: { productFound in
                            if productFound != nil {
                                product = productFound!
                            }
                            
                            var shop = Shop(name: nil, latitude: latitude, longitude: longitude)
                            FirebaseManager.shared.find(latitude: latitude, longitude: longitude, radious: Shop.gapErrorDistanceM, onComplete: { shops in
                                if shops.isEmpty == false {
                                    shop = shops[0]
                                }
                                
                                let price = Price(product:product,
                                                  shop: shop,
                                                  price: nil)
                                
                                single(.success(price))
                                
                            })
                            
                        })
                        */
                        return
                    }
                    DataManager.shared.find(latitude: latitude, longitude: longitude, barcode: barcode, onComplete: { (product, shop) in
                        let price = Price(product:product,
                                          shop: shop,
                                          price: prices[0].price)
                        
                        single(.success(price))
                    })
                    
                    
                case .error(let error):
                    single(.error(error))
                }
            })/*.disposed(by: disposeBag)*/
            
            
            return disposable
        }
    }
    
    
    private func find(latitude:Double,longitude:Double, barcode:String, onComplete: @escaping ( Product, Shop) ->Void ){
        var product =  Product(name: nil, barcode: barcode)
        FirebaseManager.shared.find(barcode: barcode, onComplete: { productFound in
            if productFound != nil {
                product = productFound!
            }
            
            var shop = Shop(name: nil, latitude: latitude, longitude: longitude)
            FirebaseManager.shared.find(latitude: latitude, longitude: longitude, radious: Shop.gapErrorDistanceM, onComplete: { shops in
                if shops.isEmpty == false {
                    shop = shops[0]
                }
                
                /* let price = Price(product:product,
                 shop: shop,
                 price: nil)*/
                
                onComplete(product,shop)
                
            })
        })
    }
    
    func find(latitude:Double,longitude:Double, barcode:String, radious: Double) -> Single<[Price]> {
        return Single.create { single in
            let disposable = Disposables.create()
            
            FirebaseManager.shared.find(latitude: latitude,
                                        longitude: longitude,
                                        radious: radious,
                                        barcode: barcode,
                                        onComplete: { prices in
                single(.success(prices))
            })
            
            return disposable
        }
    }
    
    
/*
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
        self.find(latitude: latitude, longitude: longitude, radious: Shop.gapErrorDistanceM) { shops in
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

        self.find(latitude: latitude, longitude: longitude, radious: Shop.gapErrorDistanceM) { shopsFound in

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
                    .filter {
                        let isInRange = Shop(key: $0.shopLocation).distanceInM(latitude: latitude, longitude: longitude) <= radious
                        return $0.price != nil && isInRange
                    }
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
 */
}
