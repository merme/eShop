//
//  ScanForPriceUC.swift
//  eShop
//
//  Created by 08APO0516 on 09/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import RxSwift

class ScanForPriceUC {
    
    static let shared =  ScanForPriceUC()
    
    // MARK :- Private attributes
    var disposeBag = DisposeBag()
    
    // MARK :-
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    func find(barcode: String,sortByPrice:Bool) -> Single<Price> {
        return Single.create { single in
            let disposable = Disposables.create()
            
            let disposeBag = DisposeBag()
            LocationManager.shared.getCurrentLocation()
                .subscribe { event in
                    switch event {
                    case .success(let location):
                        DataManager.shared.find(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude,
                                                barcode: barcode,sortByPrice:sortByPrice)
                            .subscribe({ event in
                            switch event {
                            case .success(let price):
                                single(.success(price))
                            case .error(let error):
                                single(.error(error))
                            }
                        })/*.disposed(by: disposeBag)*/
                    case .error(let error):
                        single(.error(error))
                    }
                }.disposed(by: disposeBag)
            return disposable
        }
    }
    
    func update(price: Price) -> Completable {
        return Completable.create { completable in
            
            let disposeBag = DisposeBag()
            DataManager.shared.create(price: price).subscribe { event in
                //completable(event)
                switch event {
                case .completed:
                    completable(.completed)
                case .error(let error):
                    completable(.error(error))
                }
            }.disposed(by: disposeBag)
            return Disposables.create()
        }
    }
    
    func find(barcode: String, radiousInM: Double,sortByPrice:Bool) -> Single<[Price]> {
        return Single.create { single in
            let disposable = Disposables.create()
            
          //  let disposeBag = DisposeBag()
            LocationManager.shared.getCurrentLocation()
                .subscribe { event in
                    switch event {
                    case .success(let location):
                        DataManager.shared.find(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude,
                                                barcode: barcode,
                                                radiousInM:radiousInM,sortByPrice:sortByPrice)
                            .subscribe({ event in
                                switch event {
                                case .success(let prices):
                                    single(.success(prices))
                                case .error(let error):
                                    single(.error(error))
                                }
                            })/*.disposed(by: disposeBag)*/
                    case .error(let error):
                        single(.error(error))
                    }
                }.disposed(by: self.disposeBag)
            return disposable
        }
    }
    
}
