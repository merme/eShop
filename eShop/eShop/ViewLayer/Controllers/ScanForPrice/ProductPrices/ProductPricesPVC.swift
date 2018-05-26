//
//  ShopPricePVC.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxSwift
import RxCocoa
import CocoaLumberjack

class ProductPricesPVC: UIViewController {
    
    // MARK :-
    
    // MARK:- Callbacks
    var onDone:(() -> Void) = {  }
    
    // MARK:- Public attributes
    var product:Product? {
        didSet {
            self.refreshViewController()
        }
    }
    var radious:Double = 0.0
    
   // private var priceUpdated:Price?
    
    // MARK:- Private attributes
    private var productPricesContentVC = ProductPricesContentVC()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//DataManager.shared.reset()
        // Do any additional setup after loading the view.
     /*
        priceUpdated = Price(product: Product(name: price?.product?.name, barcode:  (price?.product?.barcode)!),
                             shop: Shop(name: price?.shop?.name, latitude:  (price?.shop?.latitude)!,longitude:  (price?.shop?.longitude)!),
                             price: price?.price)
 */
        guard let _product = self.product else { return }
        self.fetchProductPrices(product: _product, radious: self.radious).subscribe(onSuccess: { [weak self] prices in
            guard let weakSelf = self else { return }
            weakSelf.productPricesContentVC.prices = prices
        }) { error in
            print("todo")
        }.disposed(by: disposeBag)
        
    }

    
    func fetchProductPrices(product:Product, radious: Double) -> Single<[Price]>  {
        return Single.create { single in
            let disposable = Disposables.create()
            //let disposeBag = DisposeBag()
            ScanForPriceUC.shared.find(barcode: product.barcode, radious: radious).subscribe { event in
                
                switch event {
                case .success(let prices):
                   single(.success(prices))
                    
                  
                case .error(let error):
                    single(.error(error))
                }
                
                }.disposed(by: self.disposeBag)
            
            return disposable
        }
    }
    
    
    
    
/*
    func find(barcode: String, radious: Double) -> Single<[Price]> {
        return Single.create { single in
            let disposable = Disposables.create()
            
            let disposeBag = DisposeBag()
            LocationManager.shared.getCurrentLocation()
                .subscribe { event in
                    switch event {
                    case .success(let location):
                        DataManager.shared.find(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude,
                                                barcode: barcode,
                                                radious:radious)
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
                }.disposed(by: disposeBag)
            return disposable
        }
    }
    
    */
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  let destinationVC = segue.destination as? ProductPricesContentVC,
            (segue.identifier ==  R.segue.productPricesPVC.productPricesSegue.identifier) {
                self.productPricesContentVC = destinationVC
            self.productPricesContentVC.onDone = { [weak self] in
                guard let weakSelf =  self else { return }
                weakSelf.onDone()
            }
            
            /*
            shopPriceContentVC.price = self.price ?? nil
            
            shopPriceContentVC.onPriceUpdated = { [weak self] priceUpdated in
                   // DDLo("\(price)")
                guard let weakSelf = self,
                    priceUpdated != weakSelf.price else { return }
                
                // todo: check whether price has really changed
                DDLogInfo("\(priceUpdated)")
                //private var disposeBag = DisposeBag()
                ScanForPriceUC.shared.update(price:priceUpdated).subscribe { [weak self] event in
                    guard let weakSelf = self else { return }
                    switch event {
                        case .completed:
                            weakSelf.onPriceUpdated()
                        case .error(let error):
                            DDLogError("\(error)")
                    }
                    }.disposed(by: DisposeBag())
            }
 */
            /*
            startScanningContentVC?.onScan = { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.onScan3()
            }*/
        }
    }
    
    // MARK:- Private/internal
    func setupViewController() {
        
    }

    func refreshViewController() {
        
    }
   
}
