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
    
    func test_shop_find_10m() {
        
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
    
}
