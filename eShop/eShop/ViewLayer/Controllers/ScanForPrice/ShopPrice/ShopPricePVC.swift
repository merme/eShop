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

class ShopPricePVC: BaseViewController {
    
    // MARK :- Callbacks
    var onPriceUpdated:((Price) -> Void) = { _ in }
    var onClose: ( ) -> Void = { }
    
    // MARK :- Public attributes
    var price:Price?
    
   // private var priceUpdated:Price?
    
    // MARK :- Private attributes
    private var  shopPriceContentVC :ShopPriceContentVC = ShopPriceContentVC()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._setupPresenterViewController()
        
        guard let _product = price?.product else { return }
        self.fetchProductPrices(product: _product, radiousInM: 10000, sortByPrice: false)
        
       
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let _shopPriceContentVC = segue.destination as? ShopPriceContentVC,
            (segue.identifier ==  R.segue.shopPricePVC.shopPriceSegue.identifier) {
           shopPriceContentVC = _shopPriceContentVC
            shopPriceContentVC.price = self.price ?? nil
            shopPriceContentVC.onPriceUpdated = { [weak self] priceUpdated in
                   // DDLo("\(price)")
                guard let weakSelf = self else { return }
                guard  priceUpdated != weakSelf.price else { weakSelf.onPriceUpdated(priceUpdated); return }
                
                if priceUpdated.price == nil {
                    print("stop")
                }
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
    func _setupPresenterViewController() {
        
        self.title = R.string.localizable.shop_price_title.key.localized
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.addCloseButton()
    }
    
    private func addCloseButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.img_close(),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(closeAction))
        
        self.navigationItem.rightBarButtonItem?.tintColor = ColorsEShop.NavigationBar.TitleFontColor
    }
    
    @objc func closeAction() {
        self.onClose()
    }

    func refreshViewController() {
        
    }
   
    
    func fetchProductPrices(product:Product, radiousInM: Double,sortByPrice:Bool)  {
        
        ScanForPriceUC.shared.find(barcode: product.barcode, radiousInM: 10000,sortByPrice:sortByPrice ).subscribe { [weak self] event in
                guard let weakSelf = self else { return }
                switch event {
                case .success(let prices):
                    weakSelf.shopPriceContentVC.pricesFound = prices.count
                case .error(let error):
                    DDLogError("Error. ScanForPriceUC failed!")
                }
            }.disposed(by: self.disposeBag)
    }
    
}
