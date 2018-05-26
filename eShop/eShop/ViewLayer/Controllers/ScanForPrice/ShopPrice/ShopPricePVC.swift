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

class ShopPricePVC: UIViewController {
    
    // MARK :- Callbacks
    var onPriceUpdated:((Price) -> Void) = { _ in }
    
    // MARK :- Public attributes
    var price:Price?
    
   // private var priceUpdated:Price?
    
    // MARK :- Private attributes
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let shopPriceContentVC = segue.destination as? ShopPriceContentVC,
            (segue.identifier ==  R.segue.shopPricePVC.shopPriceSegue.identifier) {
           
            shopPriceContentVC.price = self.price ?? nil
            
            shopPriceContentVC.onPriceUpdated = { [weak self] priceUpdated in
                   // DDLo("\(price)")
                guard let weakSelf = self else { return }
                guard  priceUpdated != weakSelf.price else { weakSelf.onPriceUpdated(priceUpdated); return }
                
                // todo: check whether price has really changed
                DDLogInfo("\(priceUpdated)")
                //private var disposeBag = DisposeBag()
                ScanForPriceUC.shared.update(price:priceUpdated).subscribe { [weak self] event in
                    guard let weakSelf = self else { return }
                    switch event {
                        case .completed:
                            weakSelf.onPriceUpdated(priceUpdated)
                        case .error(let error):
                            DDLogError("\(error)")
                    }
                    }.disposed(by: DisposeBag())
            }
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
