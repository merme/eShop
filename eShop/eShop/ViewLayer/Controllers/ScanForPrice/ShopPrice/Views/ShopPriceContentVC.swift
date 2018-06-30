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
    case priceValue(String?)
    case count
    
    func key() -> String {
        switch self {
        case .shopName:      return R.string.localizable.start_scanning_shop_placeholder.key.localized
        case .productName:   return R.string.localizable.start_scanning_product_placeholder.key.localized
        case .priceValue:    return R.string.localizable.start_scanning_price_placeholder.key.localized
        default: return ""
         }
    }
    
    func emptyValue() -> String {
        switch self {
        case .shopName:      return ""
        case .productName:   return ""
        case .priceValue:    return "0"
        default: return ""
        }
    }
    
    func value() -> String? {
        switch self {
        case .shopName(let shopname):       return shopname
        case .productName(let productname): return productname
        case .priceValue(let priceValue):   return priceValue //String(format:"%.2f", priceValue ?? "8.88")
        default: return ""
        }
    }
    
    func font() -> UIFont {
        switch self {
        case .shopName:         return EShopFonts.ShopPrice.ShopFont
        case .productName:      return EShopFonts.ShopPrice.ProductFont
        case .priceValue:       return EShopFonts.ShopPrice.PriceFont
        default: return UIFont()
        }
    }
    
    func keyboardType() -> UIKeyboardType {
        switch self {
        case .shopName:         return UIKeyboardType.alphabet
        case .productName:      return UIKeyboardType.alphabet
        case .priceValue:       return UIKeyboardType.decimalPad
        default: return UIKeyboardType.alphabet
        }
    }
    
    func icon() -> UIImage {
        switch self {
        case .shopName:         return R.image.img_shop() ?? UIImage()
        case .productName:      return R.image.img_scancode() ?? UIImage()
        case .priceValue:       return R.image.img_price() ?? UIImage()
        default: return UIImage()
        }
    }
    
}

class ShopPriceContentVC: BaseViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var tblShopPrice: UITableView!
    @IBOutlet weak var tapGestureRecognizer:UITapGestureRecognizer!
    @IBOutlet weak var btnSaveAndContinue: UIButton!
    @IBOutlet weak var lblPricesFound: UILabel!
    @IBOutlet weak var svwPricesFound: UIView!
    
    
    // MARK: - Callbacks
    var onPriceUpdated: ((Price) -> Void) = { _ in }
    
    // MARK: - Public/Attributes
    var price:Price? {
        didSet {
            self.datasource.value = [ShopPriceContentField.shopName(price?.shop?.name),
                                     ShopPriceContentField.productName(price?.product?.name),
                                     ShopPriceContentField.priceValue("\(price?.price ?? 0.00 )")]
        }
    }
    
    var pricesFound:Int = 0 {
        didSet {
            self.vPriceFound.value = pricesFound
            self.refreshPricesFoundView()
        }
    }
    
    // MARK: - Private attributes
    private var datasource:Variable<[ShopPriceContentField]> = Variable([])
    private var vPriceFound:Variable<Int> = Variable(0)
    
    private var newProductName:String?
    private var newShopName:String?
    private var newPriceValue:Double? {
        didSet {
            print(">>>>>>>>>>>>>>> \(newPriceValue)")
        }
    }
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewController()
        self.refreshPricesFoundView()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private/Internal
    private func setupViewController() {
        self.tblShopPrice.tableFooterView = UIView()
        
        self.setupPricesFoundSubview()
        
        tapGestureRecognizer.rx.event
            .bind { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        tblShopPrice.alwaysBounceVertical = false
        tblShopPrice.tableFooterView = UIView()
        tblShopPrice.backgroundColor = UIColor.clear
        tblShopPrice.rowHeight = UITableViewAutomaticDimension
        tblShopPrice.estimatedRowHeight = 200
        //tblShopPrice.separatorStyle = .none
        tblShopPrice.allowsSelection = false

        self.datasource.asDriver().drive( self.tblShopPrice.rx.items(cellIdentifier: R.reuseIdentifier.shopPriceTVC.identifier, cellType: ShopPriceTVC.self)) { [weak self] (_, shopPriceContentField, shopPriceTVC ) in
            
                guard let weakSelf = self else { return }
                weakSelf.configureShopPriceTVC(shopPriceContentField: shopPriceContentField,
                                               shopPriceTVC: shopPriceTVC)
            
            }.disposed(by: disposeBag)
        
        
        
    }
    
    func setupPricesFoundSubview() {
        
        svwPricesFound.backgroundColor = ColorsEShop.ShopPrice.PricesFoundBackground
        svwPricesFound.dropUpperShadow()
        
        lblPricesFound.text = ""
        lblPricesFound.numberOfLines = 1
        lblPricesFound.textAlignment = .center
        lblPricesFound.font = EShopFonts.ShopPrice.PricesFoundFont
        lblPricesFound.textColor = ColorsEShop.ShopPrice.FontColor
        
        btnSaveAndContinue.setImage(R.image.img_continue(), for: .normal)
        self.btnSaveAndContinue.rx.tap.bind { [weak self] _ in
            guard let weakSelf = self else { return }
            //  if weakSelf.view.
           // weakSelf.view.endEditing(true)
            
            if weakSelf.newPriceValue == nil {
                print("stop!!")
            }
            
            weakSelf.onPriceUpdated(weakSelf.updateNewPrice(productName: weakSelf.newProductName,
                                                            shopName: weakSelf.newShopName,
                                                            priceValue: weakSelf.newPriceValue))
            }
            .disposed(by: disposeBag)
    }
    
    private func configureShopPriceTVC(shopPriceContentField: ShopPriceContentField, shopPriceTVC: ShopPriceTVC) {
        
       
        //shopPriceTVC.value = shopPriceContentField.value() ?? "nil"
        shopPriceTVC.shopPriceContentField = shopPriceContentField
        shopPriceTVC.onEditingEnd = { [weak self] shopPriceContentField in
            guard let weakSelf = self else { return }
            
            switch shopPriceContentField {
            case .productName(let productName) :  weakSelf.newProductName = productName
            case .shopName(let shopName):     weakSelf.newShopName = shopName
            case .priceValue(let priceValue):   //weakSelf.newPriceValue = Double(priceValue!) ?? 9.99//(newValue == nil) ? weakSelf.price?.price : Double(newValue!)
            guard let _priceValue = priceValue else {
                weakSelf.newPriceValue  = 9.99
                return
                }
            
                 weakSelf.newPriceValue = _priceValue.doubleValue
                
              /*  if newValue == nil {
                    weakSelf.newPriceValue =  weakSelf.price?.price
                } else {
                    weakSelf.newPriceValue =  Double(newValue!)
                }*/
            default: return
            }
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
    
    private func refreshPricesFoundView() {
        self.lblPricesFound.text = String(format: R.string.localizable.shop_price_prices_found.key.localized, vPriceFound.value)
        
    }
    
    private func refreshViewController() {
        
        
        DDLogVerbose("\(self.price!)")
        self.tblShopPrice.reloadData()
    }

}
