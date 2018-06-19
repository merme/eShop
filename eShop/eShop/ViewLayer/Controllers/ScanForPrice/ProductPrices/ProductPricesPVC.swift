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

class ProductPricesPVC: BaseViewController {
    
    // MARK :-
    
    // MARK:- Callbacks
    var onDone:(() -> Void) = {  }
    
    
    // MARK:- Public attributes
    var product:Product? {
        didSet {
            self.refreshViewController()
        }
    }
    var radiousInM:Int = 0
    
   // private var priceUpdated:Price?
    
    // MARK:- Private attributes
    private var productPricesContentVC = ProductPricesContentVC()
    private var disposeBag = DisposeBag()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//DataManager.shared.reset()
        // Do any additional setup after loading the view.
     /*
        priceUpdated = Price(product: Product(name: price?.product?.name, barcode:  (price?.product?.barcode)!),
                             shop: Shop(name: price?.shop?.name, latitude:  (price?.shop?.latitude)!,longitude:  (price?.shop?.longitude)!),
                             price: price?.price)
 */
        self._setupPresenterViewController()
        

        self._fetchProductPrices(sortByPrice: false)
        LocationManager.shared.getCurrentLocation().subscribe(onSuccess: { [weak self] cllocation in
            guard let weakSelf = self else { return }
            weakSelf.productPricesContentVC.deviceLocation = cllocation
        }) { error in
            print("todo")
        }
    }


    
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
            self.productPricesContentVC.onSortBy = { sortingType in
                self._fetchProductPrices(sortByPrice: sortingType.rawValue == SortingType.price.rawValue)
            }
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
        self.onDone()
    }
    
    func _fetchProductPrices(sortByPrice:Bool) {
        guard let _product = self.product else { return }
        self.fetchProductPrices(product: _product,
                                radiousInM: Double(self.radiousInM),
                                sortByPrice:sortByPrice).subscribe(onSuccess: { [weak self] prices in
            guard let weakSelf = self else { return }
            weakSelf.productPricesContentVC.prices = prices
        }) { error in
            print("todo")
            }.disposed(by: disposeBag)
    }
    
    
    func fetchProductPrices(product:Product, radiousInM: Double,sortByPrice:Bool) -> Single<[Price]>  {
        return Single.create { single in
            let disposable = Disposables.create()
            //let disposeBag = DisposeBag()
            ScanForPriceUC.shared.find(barcode: product.barcode, radiousInM: radiousInM,sortByPrice:sortByPrice).subscribe { event in
                
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
    

    
        

    func setupViewController() {
        
    }

    func refreshViewController() {
        
    }
   
}
