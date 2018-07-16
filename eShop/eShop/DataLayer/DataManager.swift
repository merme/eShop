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

    // MARK :- Products
    func find(productName:String, onComplete:@escaping ([Product]) -> Void ) {

        FirebaseManager.shared.find(productName: productName, onComplete: onComplete)
    }

    // MARK: - Shop
    func getShop(shopLocation:String, onComplete: @escaping ( Shop?) -> Void) {
        let _shop = Shop(shopLocation: shopLocation)
        FirebaseManager.shared.find(latitude: _shop.latitude, longitude: _shop.longitude, radiousInM: Shop.gapErrorDistanceM, onComplete: { shops in
            if shops.isEmpty == false {
                onComplete(shops.first)
            } else {
                onComplete(nil)
            }
        })
    }

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

    func find(latitude:Double,longitude:Double, barcode:String, sortByPrice:Bool) -> Single<Price> {
        return Single.create {  [weak self] single in
            let disposable = Disposables.create()

            DataManager.shared.find(latitude: latitude,
                                    longitude: longitude,
                                    barcode: barcode,
                                    radiousInM: Shop.gapErrorDistanceM,
                                    sortByPrice:sortByPrice).subscribe({ event in
                                        switch event {
                                        case .success(let prices):
                                            guard prices.isEmpty == false else {
                                                DataManager.shared.find(latitude: latitude, longitude: longitude, barcode: barcode, onComplete: { (product, shop) in
                                                    let price = Price(product:product,
                                                                      shop: shop,
                                                                      price: nil)

                                                    single(.success(price))
                                                })
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

    private func find(latitude:Double,longitude:Double, barcode:String, onComplete: @escaping ( Product, Shop) -> Void ) {
        var product =  Product(name: nil, barcode: barcode)
        FirebaseManager.shared.find(barcode: barcode, onComplete: { productFound in
            if productFound != nil {
                product = productFound!
            }

            var shop = Shop(name: nil, latitude: latitude, longitude: longitude)
            FirebaseManager.shared.find(latitude: latitude, longitude: longitude, radiousInM: Shop.gapErrorDistanceM, onComplete: { shops in
                if shops.isEmpty == false {
                    shop = shops[0]
                }
                onComplete(product,shop)

            })
        })
    }

    func find(latitude:Double,longitude:Double, barcode:String, radiousInM: Double, sortByPrice: Bool) -> Single<[Price]> {
        return Single.create { single in
            let disposable = Disposables.create()

            FirebaseManager.shared.find(latitude: latitude,
                                        longitude: longitude,
                                        radiousInM: radiousInM,
                                        barcode: barcode,
                                        sortByPrice: sortByPrice,
                                        onComplete: { prices in
                                            single(.success(prices))
            })

            return disposable
        }
    }

}
