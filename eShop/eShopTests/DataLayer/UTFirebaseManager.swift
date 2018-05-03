//
//  UTFirebaseManager.swift
//  eShopTests
//
//  Created by 08APO0516 on 28/04/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
import Firebase
@testable import eShop

class UTFirebaseManager: XCTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- Product
    func test_product_create() {

        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "berenjena", barcode: "2222")
        FirebaseManager.shared.create(product:product)
        FirebaseManager.shared.products { products in
            guard products.count == 2 else { XCTFail(); return }
            
            XCTAssertEqual(products[0].name,"patatas")
            XCTAssertEqual(products[0].barcode,"12345678")
            
            XCTAssertEqual(products[1].name,"berenjena")
            XCTAssertEqual(products[1].barcode,"2222")
            
            asyncExpectation.fulfill()
        }
       
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_product_overwrite() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "berenjena", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        FirebaseManager.shared.products { products in
            guard products.count == 1 else { XCTFail(); return }
            
            XCTAssertEqual(products[0].name, "berenjena")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_product_delete() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        let product2 = Product(name: "berenjena", barcode: "2222")
        FirebaseManager.shared.create(product:product2)
        FirebaseManager.shared.delete(product:product)
        
        FirebaseManager.shared.products { products in
            guard products.count == 1 else { XCTFail(); return }
            
            XCTAssertEqual(products[0].name, "berenjena")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_product_find_found() {
        FirebaseManager.shared.reset()
        
        var asyncExpectation:XCTestExpectation? = expectation(description: "\(#function)")
        
        var product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "berenjena", barcode: "2222")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "habas", barcode: "1111")
        FirebaseManager.shared.create(product:product)
        
        FirebaseManager.shared.find(barcode: "2222") { product in
            guard let _product = product else {  XCTFail(); return  }
            XCTAssertEqual(_product.name, "berenjena")
            XCTAssertEqual(_product.barcode, "2222")
            
            asyncExpectation?.fulfill()
            asyncExpectation = nil
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_product_find_Notfound() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "berenjena", barcode: "2222")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "habas", barcode: "1111")
        FirebaseManager.shared.create(product:product)
        
        FirebaseManager.shared.find(barcode: "333") { product in
            guard product == nil else {  XCTFail(); return }
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    // MARK: - Shop
    func test_shop_create() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "xxx", latitude: 1, longitude: -2)
        FirebaseManager.shared.create(shop: shop)
        shop = Shop(name: "y", latitude: -1, longitude: 5)
        FirebaseManager.shared.create(shop: shop)
        FirebaseManager.shared.shops { shops in
            guard shops.count == 2 else { XCTFail(); return }
            
            XCTAssertEqual(shops[0].name,"xxx")
            XCTAssertEqual(shops[0].latitude,1.0)
            XCTAssertEqual(shops[0].longitude,-2)
            
            XCTAssertEqual(shops[1].name,"y")
            XCTAssertEqual(shops[1].latitude,-1)
            XCTAssertEqual(shops[1].longitude,5)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_shop_exists_empty() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        //FirebaseManager.shared.create(shop: shop)
        FirebaseManager.shared.exists(latitude: shop.latitude, longitude: shop.longitude) { shop in
            XCTAssertNil(shop)
            asyncExpectation.fulfill()

        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_shop_exists_Found() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        shop = Shop(name: "Bon Preu", latitude:  41.4188, longitude: 2.0008)
        
        FirebaseManager.shared.exists(latitude: shop.latitude, longitude: shop.longitude) { shop in
            guard let _shop = shop else {XCTFail(); return}
            XCTAssertEqual(_shop.name, "Bon Preu Pallejà")
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_shop_exists_Notfound() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        shop = Shop(name: "Mercadona Pallejà", latitude:  41.4207, longitude: 1.9965)
        
        FirebaseManager.shared.exists(latitude: shop.latitude, longitude: shop.longitude) { shop in
            XCTAssertNil(shop)
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    
    func test_shop_find_10m_NotFound() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Carrefour Estepona", latitude:  36.4285, longitude: -5.1307)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Whole Foods Market Vancouver", latitude:  49.2901, longitude: -123.1325)
        FirebaseManager.shared.create(shop: shop)
        
        FirebaseManager.shared.find(latitude: 41.4213, longitude: 1.9998, radious: 10) { shops in
            XCTAssertEqual(shops.count, 0)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_shop_find_15m_Found() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Carrefour Estepona", latitude:  36.4285, longitude: -5.1307)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Whole Foods Market Vancouver", latitude:  49.2901, longitude: -123.1325)
        FirebaseManager.shared.create(shop: shop)
        
        FirebaseManager.shared.find(latitude: 41.4188, longitude: 2.0007, radious: 15) { shops in
            guard shops.count == 1 else { XCTFail(); return }
            XCTAssertEqual(shops[0].name, "Bon Preu Pallejà")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_shop_find_100m() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Mercadona Pallejà", latitude:  41.4207, longitude: 1.9965)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Carrefour Estepona", latitude:  36.4285, longitude: -5.1307)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Whole Foods Market Vancouver", latitude:  49.2901, longitude: -123.1325)
        FirebaseManager.shared.create(shop: shop)
        
        FirebaseManager.shared.find(latitude: 41.4191, longitude: 1.9999, radious: 100) { shops in
            guard shops.count == 1 else { XCTFail(); return }
            XCTAssertEqual(shops[0].name, "Bon Preu Pallejà")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_shop_find_1Km() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Mercadona Pallejà", latitude:  41.4207, longitude: 1.9965)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Carrefour Estepona", latitude:  36.4285, longitude: -5.1307)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Whole Foods Market Vancouver", latitude:  49.2901, longitude: -123.1325)
        FirebaseManager.shared.create(shop: shop)
        
        FirebaseManager.shared.find(latitude: 41.4191, longitude: 1.9999, radious: 1000) { shops in
            guard shops.count == 2 else { XCTFail(); return }
            XCTAssertEqual(shops[0].name, "Bon Preu Pallejà")
            XCTAssertEqual(shops[1].name, "Mercadona Pallejà")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_shop_find_1000Km() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Mercadona Pallejà", latitude:  41.4207, longitude: 1.9965)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Carrefour Estepona", latitude:  36.4285, longitude: -5.1307)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Whole Foods Market Vancouver", latitude:  49.2901, longitude: -123.1325)
        FirebaseManager.shared.create(shop: shop)
        
        FirebaseManager.shared.find(latitude: 41.4191, longitude: 1.9999, radious: 1000000) { shops in
            guard shops.count == 3 else { XCTFail(); return }
            XCTAssertEqual(shops[0].name, "Bon Preu Pallejà")
            XCTAssertEqual(shops[1].name, "Mercadona Pallejà")
            XCTAssertEqual(shops[2].name, "Carrefour Estepona")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func test_shop_find_10_000Km() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Mercadona Pallejà", latitude:  41.4207, longitude: 1.9965)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Carrefour Estepona", latitude:  36.4285, longitude: -5.1307)
        FirebaseManager.shared.create(shop: shop)
        
        shop = Shop(name: "Whole Foods Market Vancouver", latitude:  49.2901, longitude: -123.1325)
        FirebaseManager.shared.create(shop: shop)
        
        FirebaseManager.shared.find(latitude: 41.4191, longitude: 1.9999, radious: 10000 * 1000 ) { shops in
            guard shops.count == 4 else { XCTFail(); return }
            XCTAssertEqual(shops[0].name, "Bon Preu Pallejà")
            XCTAssertEqual(shops[1].name, "Mercadona Pallejà")
            XCTAssertEqual(shops[2].name, "Carrefour Estepona")
            XCTAssertEqual(shops[3].name, "Whole Foods Market Vancouver")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    // MARK: - Price
    func test_price_create() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(product: product, shop: shop) { price in
            XCTAssertEqual(price.price, 10.0)
             asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_create_overwrite() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        var price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
         price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 12.3)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(product: product, shop: shop) { price in
            
          //  guard let _price = price else {XCTFail(); return}
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertEqual(price.price, 12.3)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            guard let _productName = price.product?.name else  {XCTFail(); return}
            XCTAssertEqual(_productName, "patatas")
            
            
            asyncExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_create_find_priceNotFound() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        var product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        product = Product(name: "patatas", barcode: "1334")
        
        FirebaseManager.shared.find(product: product, shop: shop) { price in
           
            XCTAssertEqual(price.barcode,"1334")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "1334")
            guard let _productName = price.product?.name else  {XCTFail(); return}
            XCTAssertEqual(_productName, "patatas")
            
            asyncExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_ShopExists_ProductExists_PriceExists() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: shop.latitude, longitude: shop.longitude, barcode: product.barcode) { price in
            
          //  guard let _price = price else {XCTFail(); return}
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertEqual(price.price,10.0)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            guard let _productName = price.product?.name else  {XCTFail(); return}
            XCTAssertEqual(_productName, "patatas")
            
             asyncExpectation.fulfill()
            
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_ShopExistsNearby_ProductExists_PriceExists() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4188, longitude: 2.0007, barcode: product.barcode) { price in
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertEqual(price.price,10.0)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            guard let _productName = price.product?.name else  {XCTFail(); return}
            XCTAssertEqual(_productName, "patatas")
            
            asyncExpectation.fulfill()
            
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func test_price_find_ShopExists_ProductExists_PriceNotExists() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        //let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        //FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, barcode: product.barcode) { price in
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            guard let _productName = price.product?.name else  {XCTFail(); return}
            XCTAssertEqual(_productName, "patatas")
            
            asyncExpectation.fulfill()
            
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_ShopExistsNearby_ProductNotExists_PriceNotExists() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        //let product = Product(name: "patatas", barcode: "12345678")
        //FirebaseManager.shared.create(product:product)
        
       // let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
       // FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189 + 0.0001, longitude: 2.0008 + 0.0001, barcode: "12345678") { price in
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            XCTAssertNil(price.product?.name)
            
            FirebaseManager.shared.find(barcode: price.barcode, onComplete: { product in
                guard let _product = product else { XCTFail(); return }
                
                 XCTAssertNil(_product.name)
                XCTAssertEqual(_product.barcode,"12345678")
                asyncExpectation.fulfill()
            })
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_ShopExists_ProductNotExists_PriceNotExists() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        //let product = Product(name: "patatas", barcode: "12345678")
        //FirebaseManager.shared.create(product:product)
        
        // let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        // FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, barcode: "12345678") { price in
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            XCTAssertNil(price.product?.name)
            
            FirebaseManager.shared.find(barcode: price.barcode, onComplete: { product in
                guard let _product = product else { XCTFail(); return }
                
                XCTAssertNil(_product.name)
                XCTAssertEqual(_product.barcode,"12345678")
                asyncExpectation.fulfill()
            })
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func test_price_find_NotShopExists_ProductExists_PriceNotExists() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        //let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        //FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        // let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        // FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, barcode: "12345678") { price in
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            XCTAssertNil(price.shop?.name)
            
            guard let _productName = price.product?.name else  {XCTFail(); return}
            XCTAssertEqual(price.product?.barcode, "12345678")
            XCTAssertEqual(_productName,"patatas")
            
            FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: Shop.gapErrorDistanceM, onComplete: { shops in
                guard shops.isEmpty == false else { XCTFail(); return }
                
                XCTAssertNil(shops[0].name)
                XCTAssertEqual(shops[0].latitude,41.4189)
                XCTAssertEqual(shops[0].longitude,2.0008)
                
                asyncExpectation.fulfill()
            })
    
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_NotShopExists_ProductNotExists_PriceNotExists() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        //let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        //FirebaseManager.shared.create(shop: shop)
        
        //let product = Product(name: "patatas", barcode: "12345678")
       // FirebaseManager.shared.create(product:product)
        
        // let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        // FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, barcode: "12345678") { price in
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            XCTAssertNil(price.shop?.name)
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            XCTAssertNil(price.product?.name)
            
            FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: Shop.gapErrorDistanceM, onComplete: { shops in
                guard shops.isEmpty == false else { XCTFail(); return }
                
                XCTAssertNil(shops[0].name)
                XCTAssertEqual(shops[0].latitude,41.4189)
                XCTAssertEqual(shops[0].longitude,2.0008)
                
                FirebaseManager.shared.find(barcode: price.barcode, onComplete: { product in
                    guard let _product = product else { XCTFail(); return }
                    
                    XCTAssertNil(_product.name)
                    XCTAssertEqual(_product.barcode,"12345678")
                    asyncExpectation.fulfill()
                })
            })
            
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func test_price_find() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop3 = Shop(name: "Shop3", latitude:  40.4289, longitude: 3.0108)
        FirebaseManager.shared.create(shop: shop3)
        let shop1 = Shop(name: "Shop1", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4289, longitude: 2.0108)
        FirebaseManager.shared.create(shop: shop2)
        
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        var price = Price(barcode: product.getKey(), shop: shop1.getKey(), price: 10.0)
         FirebaseManager.shared.create(price: price)
        price = Price(barcode: product.getKey(), shop: shop2.getKey(), price: 15.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product.getKey(), shop: shop3.getKey(), price: 15.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000 * 1000, barcode: "12345678") { prices in
            XCTAssertEqual(prices.count, 3)
            
            XCTAssertEqual(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008), 0)
            XCTAssertTrue(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008) - 1390.062 <= 0.0001)
            XCTAssertTrue(prices[2].distanceInM(latitude: 41.4189, longitude: 2.0008) - 138983.5492 <= 0.0001)
            
            asyncExpectation.fulfill()
        }
       
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_3shops_3products_11111111() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        self.set3Products3Shops()
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000 * 1000, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 3)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 139.0062 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "41p4199-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) <= prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008))
            
            XCTAssertTrue(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008) - 1390.062 <= 0.0001)
            XCTAssertEqual(prices[1].price!, 2)
            XCTAssertEqual(prices[1].shopLocation, "41p4289-2p0008")
            XCTAssertEqual(prices[1].barcode, "11111111")
            print("\(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008))")
            XCTAssertTrue(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008) <= prices[2].distanceInM(latitude: 41.4189, longitude: 2.0008))
            
            XCTAssertTrue(prices[2].distanceInM(latitude: 41.4189, longitude: 2.0008) - 13897.2178 <= 0.0001)
            XCTAssertEqual(prices[2].price!, 1)
            XCTAssertEqual(prices[2].shopLocation, "41p5189-2p0008")
            XCTAssertEqual(prices[2].barcode, "11111111")
            print("\(prices[2].distanceInM(latitude: 41.4189, longitude: 2.0008))")
         
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_3shops_3products_22222222() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        self.set3Products3Shops()
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000 * 1000, barcode: "22222222") { prices in
            XCTAssertEqual(prices.count, 1)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 1390.062 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 5)
            XCTAssertEqual(prices[0].shopLocation, "41p4289-2p0008")
            XCTAssertEqual(prices[0].barcode, "22222222")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_3shops_3products_33333333() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        self.set3Products3Shops()
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000 * 1000, barcode: "33333333") { prices in
            XCTAssertEqual(prices.count, 2)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 139.0096 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 6)
            XCTAssertEqual(prices[0].shopLocation, "41p4199-2p0008")
            XCTAssertEqual(prices[0].barcode, "33333333")
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) <= prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008))
            
            XCTAssertTrue(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008) - 13897.2178 <= 0.0001)
            XCTAssertEqual(prices[1].price!, 4)
            XCTAssertEqual(prices[1].shopLocation, "41p5189-2p0008")
            XCTAssertEqual(prices[1].barcode, "33333333")
            print("\(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008))")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_3shops_3products_11111111_sortByPrice() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        self.set3Products3Shops()
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000 * 1000, barcode: "11111111",sortByPrice: true) { prices in
            XCTAssertEqual(prices.count, 3)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 13897.2178 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 1)
            XCTAssertEqual(prices[0].shopLocation, "41p5189-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertTrue(prices[0].price! <= prices[1].price!)
            
            XCTAssertTrue(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008) - 1390.062 <= 0.0001)
            XCTAssertEqual(prices[1].price!, 2)
            XCTAssertEqual(prices[1].shopLocation, "41p4289-2p0008")
            XCTAssertEqual(prices[1].barcode, "11111111")
            print("\(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008))")
            XCTAssertTrue(prices[1].price! <= prices[2].price!)
            
            XCTAssertTrue(prices[2].distanceInM(latitude: 41.4189, longitude: 2.0008) - 139.0062 <= 0.0001)
            XCTAssertEqual(prices[2].price!, 3)
            XCTAssertEqual(prices[2].shopLocation, "41p4199-2p0008")
            XCTAssertEqual(prices[2].barcode, "11111111")
            print("\(prices[2].distanceInM(latitude: 41.4189, longitude: 2.0008))")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_3shops_3products_22222222_sortByPrice() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        self.set3Products3Shops()
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000 * 1000, barcode: "22222222",sortByPrice: true) { prices in
            XCTAssertEqual(prices.count, 1)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 1390.062 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 5)
            XCTAssertEqual(prices[0].shopLocation, "41p4289-2p0008")
            XCTAssertEqual(prices[0].barcode, "22222222")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_3shops_3products_33333333_sortByPrice() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        self.set3Products3Shops()
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000 * 1000, barcode: "33333333",sortByPrice: true) { prices in
            XCTAssertEqual(prices.count, 2)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 13897.2178 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 4)
            XCTAssertEqual(prices[0].shopLocation, "41p5189-2p0008")
            XCTAssertEqual(prices[0].barcode, "33333333")
            XCTAssertTrue(prices[0].price! <= prices[1].price!)
            
            XCTAssertTrue(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008) - 139.0096 <= 0.0001)
            XCTAssertEqual(prices[1].price!, 6)
            XCTAssertEqual(prices[1].shopLocation, "41p4199-2p0008")
            XCTAssertEqual(prices[1].barcode, "33333333")
            print("\(prices[1].distanceInM(latitude: 41.4189, longitude: 2.0008))")
           
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_firstIsCurrentShop() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + 0.0010, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.gapErrorDistanceDegrees + 0.0001 , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189 + Shop.gapErrorDistanceDegrees  , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: Shop.gapErrorDistanceM, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 1)
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 11.1186 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "41p4190-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertEqual(prices[0].barcode, "11111111")
           
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_firstIsNotCurrentShop() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + 0.1000, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + 0.0010 , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189 + Shop.gapErrorDistanceDegrees + 0.0001, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: Shop.gapErrorDistanceM, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 0)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_IsCurrentShop() {
        
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + 0.0010, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.gapErrorDistanceDegrees + 0.0001 , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189 + Shop.gapErrorDistanceDegrees  , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, barcode: "11111111") { price in
            
            XCTAssertTrue(price.distanceInM(latitude: 41.4189, longitude: 2.0008) - 11.1186 <= 0.0001)
            XCTAssertEqual(price.price!, 3)
            XCTAssertEqual(price.shopLocation, "41p4190-2p0008")
            XCTAssertEqual(price.barcode, "11111111")
            XCTAssertEqual(price.barcode, "11111111")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_IsNotCurrentShop() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + 0.1000, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + 0.0010 , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189 + Shop.gapErrorDistanceDegrees + 0.0001, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, barcode: "11111111") { price in
            XCTAssertEqual(price.barcode,"11111111")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            XCTAssertNil(price.shop?.name)
            XCTAssertEqual(price.product?.name,"product1")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_13m() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + Shop.m2Degree(m:1000), longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.m2Degree(m:100) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189   , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 13, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 1)
            XCTAssertEqual(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008), 0.0)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "41p4189-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertNil(prices[0].shop?.name)
            XCTAssertNil(prices[0].product?.name)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_50m() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + Shop.m2Degree(m:1000), longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.m2Degree(m:70) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189  + Shop.m2Degree(m:30) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 50, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 1)
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 33.3567 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "41p4192-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertNil(prices[0].shop?.name)
            XCTAssertNil(prices[0].product?.name)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_100m() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + Shop.m2Degree(m:1000), longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.m2Degree(m:110) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189  + Shop.m2Degree(m:93) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 100, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 1)
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 88.9516 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "41p4197-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertNil(prices[0].shop?.name)
            XCTAssertNil(prices[0].product?.name)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_1Km() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + Shop.m2Degree(m:1000), longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.m2Degree(m:1020) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189  + Shop.m2Degree(m:990) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        print("\(Shop.degree2m(degrees:Shop.m2Degree(m:800)))")
        
        print("\(41.4189  + Shop.m2Degree(m:800))")
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 1)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 989.5872 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "41p4278-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertNil(prices[0].shop?.name)
            XCTAssertNil(prices[0].product?.name)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_10Km() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + Shop.m2Degree(m:10200), longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.m2Degree(m:10100) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189  + Shop.m2Degree(m:9990) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        print("\(Shop.degree2m(degrees:Shop.m2Degree(m:800)))")
        
        print("\(41.4189  + Shop.m2Degree(m:800))")
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 10000, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 1)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) -  9973.7050 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "41p5086-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertNil(prices[0].shop?.name)
            XCTAssertNil(prices[0].product?.name)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_1000Km() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + Shop.m2Degree(m:2000020), longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + Shop.m2Degree(m:1000000 + 5000) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189  + Shop.m2Degree(m:999990) , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        print("\(Shop.degree2m(degrees:Shop.m2Degree(m:800)))")
        
        print("\(41.4189  + Shop.m2Degree(m:800))")
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(latitude: 41.4189, longitude: 2.0008, radious: 1000000, barcode: "11111111") { prices in
            XCTAssertEqual(prices.count, 1)
            
            XCTAssertTrue(prices[0].distanceInM(latitude: 41.4189, longitude: 2.0008) - 998815.9698 <= 0.0001)
            XCTAssertEqual(prices[0].price!, 3)
            XCTAssertEqual(prices[0].shopLocation, "50p4019-2p0008")
            XCTAssertEqual(prices[0].barcode, "11111111")
            XCTAssertNil(prices[0].shop?.name)
            XCTAssertNil(prices[0].product?.name)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK:- Private/Internal
    func set3Products3Shops() {
        let shop1 = Shop(name: "Shop1", latitude:  41.4189 + 0.1000, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop1)
        let shop2 = Shop(name: "Shop2", latitude:  41.4189 + 0.0100 , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop2)
        let shop3 = Shop(name: "Shop3", latitude:  41.4189 + 0.0010 , longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop3)
        
        let product1 = Product(name: "product1", barcode: "11111111")
        FirebaseManager.shared.create(product:product1)
        let product2 = Product(name: "product2", barcode: "22222222")
        FirebaseManager.shared.create(product:product2)
        let product3 = Product(name: "product3", barcode: "33333333")
        FirebaseManager.shared.create(product:product3)
        
        var price = Price(barcode: product1.getKey(), shop: shop1.getKey(), price: 1.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop2.getKey(), price: 2.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product1.getKey(), shop: shop3.getKey(), price: 3.0)
        FirebaseManager.shared.create(price: price)
        
        price = Price(barcode: product2.getKey(), shop: shop2.getKey(), price: 5.0)
        FirebaseManager.shared.create(price: price)
        
        price = Price(barcode: product3.getKey(), shop: shop1.getKey(), price: 4.0)
        FirebaseManager.shared.create(price: price)
        price = Price(barcode: product3.getKey(), shop: shop3.getKey(), price: 6.0)
        FirebaseManager.shared.create(price: price)
    }
    
    
}
