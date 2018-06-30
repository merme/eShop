//
//  BarcodeScannerContainerVC.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxSwift
import RxCocoa
import CocoaLumberjack
import CoreLocation

class ProductPricesContentVC: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var tblProductPrices: UITableView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var productFilterView: ProductFilterView!
    
    // MARK: - Callbacks
   var onDone:(() -> Void) = {  }
  var onSortBy: (SortingType) -> Void = { _ in }
    
 
    // MARK: - Public/Attributes
    var prices:[Price] = [] {
        didSet {
            self.datasource.value = prices
        }
    }
    
    var deviceLocation:CLLocation?  {
        didSet {
            self._refreshContentViewController()
        }
    }
    
    // MARK: - Private attributes
    private var datasource:Variable<[Price]> = Variable([])
    
    private var newProductName:String?
    private var newShopName:String?
    private var newPriceValue:String?
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewController()
        self.refreshViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private/Internal
    private func setupViewController() {
        
        self.navigationItem.hidesBackButton = true
        
        self.productFilterView.dropShadow()
        
        self.tblProductPrices.tableFooterView = UIView()
        self.tblProductPrices.estimatedRowHeight = 100
        self.tblProductPrices.backgroundColor = UIColor.clear
        
        self.productFilterView.onSortBy = { [weak self] sortingType in
            guard let weakSelf = self else { return }
            weakSelf.onSortBy(sortingType)
        }
        
        self.datasource.asDriver().drive( self.tblProductPrices.rx.items(cellIdentifier: R.reuseIdentifier.productPricesTVC.identifier, cellType: ProductPricesTVC.self)) { [weak self] (_, price, productPricesTVC ) in
            
                guard let weakSelf = self else { return}
               weakSelf.configureShopPriceTVC(price: price,
                                              productPricesTVC: productPricesTVC,
                                              location: weakSelf.deviceLocation)
            
            }.disposed(by: disposeBag)
        
    }
    
    func _refreshContentViewController() {
        self.tblProductPrices.reloadData()
    }
    
    private func configureShopPriceTVC(price: Price, productPricesTVC: ProductPricesTVC, location: CLLocation?) {
        
        productPricesTVC.location  = location
        productPricesTVC.price = price
       
      /*
        shopPriceTVC.key = shopPriceContentField.key()
        shopPriceTVC.value = shopPriceContentField.value() ?? "nil"
        shopPriceTVC.shopPriceContentField = shopPriceContentField
        shopPriceTVC.onEditingEnd = { [weak self] shopPriceContentField, newValue in
            guard let weakSelf = self else { return }
            print("\(newValue)")
            switch shopPriceContentField {
            case .productName:  weakSelf.newProductName = (newValue == nil) ? weakSelf.price?.product?.name : newValue
            case .shopName:     weakSelf.newShopName = (newValue == nil) ? weakSelf.price?.shop?.name : newValue
            case .priceValue:   weakSelf.newPriceValue = (newValue == nil) ? weakSelf.price?.price : Double(newValue!) 
            default: return
            }
            weakSelf.onPriceUpdated(weakSelf.updateNewPrice(productName: weakSelf.newProductName,
                                               shopName: weakSelf.newShopName,
                                               priceValue: weakSelf.newPriceValue))
        }
 */
    }
    /*
    func updateNewPrice(productName:String?,  shopName:String?, priceValue:Double?) -> Price {
        
        var product = price?.product//Product(name: "", barcode: "")
        if let _productName = productName,
            let _product = price?.product {
            product = Product(name: _productName, barcode: _product.barcode)
        }
        
        var shop = price?.shop//Shop(name: "", latitude: 0, longitude: 0)
        if let _shopName = shopName,
            let _shop = price?.shop {
            shop = Shop(name: _shopName, latitude: _shop.latitude, longitude: _shop.longitude)
        }
        
        var _price = price?.price
        if let _priceValue = priceValue, _priceValue > 0 {
            _price = priceValue
        }
        
        return Price(product: product!, shop: shop!, price: _price)
    }
    */
    private func refreshViewController() {
        guard prices != nil else { return }
      //  DDLogVerbose("\(self.price!)")
        self.tblProductPrices.reloadData()
    }

}
