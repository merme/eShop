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

enum ShopPriceContentField {
    
    case shopName(String?)
    case productName(String?)
    case priceValue(Double?)
    case count
    
    func key() -> String {
        switch self {
        case .shopName:      return "_ShopName"
        case .productName:   return "_ProductName"
        case .priceValue:    return "_PriceValue"
        default: return ""
         }
    }
    
    func value() -> String? {
        switch self {
        case .shopName(let shopname):       return shopname
        case .productName(let productname): return productname
        case .priceValue(let priceValue):   return String(format:"%.2f", priceValue ?? 0.0)
        default: return ""
        }
    }
    
}

class ShopPriceContentVC: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var tblShopPrice: UITableView!
    @IBOutlet weak var tapGestureRecognizer:UITapGestureRecognizer!
    @IBOutlet weak var btnSaveAndContinue: UIButton!
    
    // MARK: - Callbacks
    var onPriceUpdated: ((Price) -> Void) = { _ in }
    
    // MARK: - Public/Attributes
    var price:Price? {
        didSet {
            self.datasource.value = [ShopPriceContentField.shopName(price?.shop?.name),
                                     ShopPriceContentField.productName(price?.product?.name),
                                     ShopPriceContentField.priceValue(price?.price)]
        }
    }
    
    // MARK: - Private attributes
    private var datasource:Variable<[ShopPriceContentField]> = Variable([])
    
    private var newProductName:String?
    private var newShopName:String?
    private var newPriceValue:Double?
    
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
        self.tblShopPrice.tableFooterView = UIView()
        
        self.btnSaveAndContinue.rx.tap.bind { [weak self] _ in
            guard let weakSelf = self else { return }
          //  if weakSelf.view.
            weakSelf.view.endEditing(true)
            
            weakSelf.onPriceUpdated(weakSelf.updateNewPrice(productName: weakSelf.newProductName,
                                                            shopName: weakSelf.newShopName,
                                                            priceValue: weakSelf.newPriceValue))
            }
        .disposed(by: disposeBag)
        
        tapGestureRecognizer.rx.event
            .bind { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        
        self.datasource.asDriver().drive( self.tblShopPrice.rx.items(cellIdentifier: R.reuseIdentifier.shopPriceTVC.identifier, cellType: ShopPriceTVC.self)) { [weak self] (_, shopPriceContentField, shopPriceTVC ) in
            
                guard let weakSelf = self else { return}
                weakSelf.configureShopPriceTVC(shopPriceContentField: shopPriceContentField,
                                               shopPriceTVC: shopPriceTVC)
            
            }.disposed(by: disposeBag)
        
    }
    
    private func configureShopPriceTVC(shopPriceContentField: ShopPriceContentField, shopPriceTVC: ShopPriceTVC) {
        
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
            /* This action is performed on pressing the button
            weakSelf.onPriceUpdated(weakSelf.updateNewPrice(productName: weakSelf.newProductName,
                                               shopName: weakSelf.newShopName,
                                               priceValue: weakSelf.newPriceValue))
 */
        }
    }
    
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
    
    private func refreshViewController() {
  
        DDLogVerbose("\(self.price!)")
        self.tblShopPrice.reloadData()
    }

}
