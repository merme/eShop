//
//  UTScanForPriceUC.swift
//  eShopTests
//
//  Created by 08APO0516 on 12/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
import RxSwift
@testable import eShop

class UTScanForPriceUC: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
        DataManager.shared.reset()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_PriceExists_ShopExists_ProductExists() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        
        let disposeBag = DisposeBag()
        ScanForPriceUC.shared.find(barcode: "12345678").subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"12345678")
                XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
                XCTAssertEqual(price.price, 10.0)
                
                XCTAssertEqual(price.shop?.latitude, 41.4189)
                XCTAssertEqual(price.shop?.longitude, 2.0008)
                guard let _shopName = price.shop?.name else  {XCTFail(); return}
                XCTAssertEqual(_shopName, "Bon Preu Pallejà")
                
                XCTAssertEqual(price.product?.barcode, "12345678")
                guard let _productName = price.product?.name else  {XCTFail(); return}
                XCTAssertEqual(_productName, "patatas")
                
                 asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        

    self.waitForExpectations(timeout: 10+1000, handler: nil)

    }
    
    func test_PriceExists_ShopExistsNearby_ProductExists() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189 - 0.0001, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        
        let disposeBag = DisposeBag()
        ScanForPriceUC.shared.find(barcode: "12345678").subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"12345678")
                XCTAssertEqual(price.shopLocation,"41p4188-2p0008")
                XCTAssertEqual(price.price, 10.0)
                
                XCTAssertEqual(price.shop?.latitude, 41.4188)
                XCTAssertEqual(price.shop?.longitude, 2.0008)
                guard let _shopName = price.shop?.name else  {XCTFail(); return}
                XCTAssertEqual(_shopName, "Bon Preu Pallejà")
                
                XCTAssertEqual(price.product?.barcode, "12345678")
                guard let _productName = price.product?.name else  {XCTFail(); return}
                XCTAssertEqual(_productName, "patatas")
                
                asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func test_PriceNotExists_ShopNotExists_ProductExists() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189 - 1.0100, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        
        let disposeBag = DisposeBag()
        ScanForPriceUC.shared.find(barcode: "12345678").subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"12345678")
                XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
                XCTAssertNil(price.price)
                
                XCTAssertEqual(price.shop?.latitude, 41.4189)
                XCTAssertEqual(price.shop?.longitude, 2.0008)
                XCTAssertNil( price.shop?.name)
                
                XCTAssertEqual(price.product?.barcode, "12345678")
                guard let _productName = price.product?.name else  {XCTFail(); return}
                XCTAssertEqual(_productName, "patatas")
                
                asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    
    func test_PriceNotExists_ShopExists_ProductNotExists() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        
        let disposeBag = DisposeBag()
        ScanForPriceUC.shared.find(barcode: "2222222").subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"2222222")
                XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
                XCTAssertNil(price.price)
                
                XCTAssertEqual(price.shop?.latitude, 41.4189)
                XCTAssertEqual(price.shop?.longitude, 2.0008)
                guard let _shopName = price.shop?.name else  {XCTFail(); return}
                XCTAssertEqual(_shopName, "Bon Preu Pallejà")
                
                XCTAssertEqual(price.product?.barcode, "2222222")
                XCTAssertNil(price.product?.name)
                
                asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_PriceNotExists_ShopExistsNearby_ProductNotExists() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008 + 0.0003)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        
        let disposeBag = DisposeBag()
        ScanForPriceUC.shared.find(barcode: "2222222").subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"2222222")
                XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
                XCTAssertNil(price.price)
                
                XCTAssertEqual(price.shop?.latitude, 41.4189)
                XCTAssertEqual(price.shop?.longitude, 2.0008)
                XCTAssertNil(price.shop?.name)
                
                XCTAssertEqual(price.product?.barcode, "2222222")
                XCTAssertNil(price.product?.name)
                
                asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_PriceNotExists_ShopNotExists_ProductNotExists() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008 + 0.0010)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        
        let disposeBag = DisposeBag()
        ScanForPriceUC.shared.find(barcode: "2222222").subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"2222222")
                XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
                XCTAssertNil(price.price)
                
                XCTAssertEqual(price.shop?.latitude, 41.4189)
                XCTAssertEqual(price.shop?.longitude, 2.0008)
                XCTAssertNil(price.shop?.name )
                
                XCTAssertEqual(price.product?.barcode, "2222222")
                XCTAssertNil(price.product?.name)
                
                asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_update() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        let shopModified = Shop(name: "Minipreu", latitude: shop.latitude, longitude: shop.longitude)
        let productModified = Product(name: "ensaladilla", barcode: "12345678")
        let priceModified = Price(product: productModified, shop: shopModified, price: 12.3)
        
        let disposeBag = DisposeBag()
        ScanForPriceUC.shared.update(price:priceModified).subscribe { event in
            switch event {
            case .completed:
                
                ScanForPriceUC.shared.find(barcode: "12345678").subscribe { event in
                    switch event {
                    case .success(let price):
                        
                        XCTAssertEqual(price.price,12.3)
                        
                        XCTAssertEqual(price.shop?.latitude, 41.4189)
                        XCTAssertEqual(price.shop?.longitude, 2.0008)
                        XCTAssertEqual(price.shop?.name , "Minipreu" )
                        
                        XCTAssertEqual(price.product?.barcode, "12345678")
                        XCTAssertEqual(price.product?.name, "ensaladilla" )
                        
                        asyncExpectation.fulfill()
                    case .error(let error):
                        print("\(error)")
                        XCTFail()
                        asyncExpectation.fulfill()
                    }
                }.disposed(by: disposeBag)
            
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
        }.disposed(by: disposeBag)
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
