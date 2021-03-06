//
//  UTFirebaseManager.swift
//  eShopTests
//
//  Created by 08APO0516 on 28/04/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
import Firebase
import RxSwift
@testable import eShop

class UTDataManager: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
         DataManager.shared.reset()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
    // MARK: - Product

    func test_product_find_productName() {
        DataManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var product = Product(name: "patatas 2Kg", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "pimientos", barcode: "2222")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "patatas 1Kg", barcode: "1111")
        FirebaseManager.shared.create(product:product)
        
        DataManager.shared.find(productName: "pata") { products in
            guard products.count == 2 else {  XCTFail(); return }
            
            XCTAssertEqual(products[0].name, "patatas 1Kg")
            XCTAssertEqual(products[1].name, "patatas 2Kg")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 2, handler: nil)
    }

    // MARK: - Shop
    func test_getShop_Found() {

        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4175, longitude: 1.9995)
        FirebaseManager.shared.create(shop: shop)
        
        DataManager.shared.getShop(shopLocation: "41p4175-1p9995") { shop in
            guard let _shop = shop else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }
            
            XCTAssertEqual(_shop.latitude, 41.4175)
            XCTAssertEqual(_shop.longitude, 1.9995)
            XCTAssertEqual(_shop.name, "Bon Preu Pallejà")
            
            asyncExpectation.fulfill()
            
        }
        
         self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_getShop_NotFound() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4175, longitude: 1.9995)
        FirebaseManager.shared.create(shop: shop)
        
        DataManager.shared.getShop(shopLocation: "41p4175-1p9994") { shop in
            guard shop == nil else {
                asyncExpectation.fulfill()
                return
            }
            
            XCTFail()
            asyncExpectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Price
    func test_price_find_FoundNearby() {
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4175, longitude: 1.9995)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        let disposeBag = DisposeBag()
        DataManager.shared.find(latitude: 41.4175, longitude: 1.9992, barcode: "12345678",sortByPrice:false).subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"12345678")
                XCTAssertEqual(price.shopLocation,"41p4175-1p9995")
                XCTAssertEqual(price.price, 10.0)
                
                asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func test_price_find_NotFoundNearby() {
        
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4175, longitude: 1.9995)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        let disposeBag = DisposeBag()
        DataManager.shared.find(latitude: 41.4175, longitude: 1.9900, barcode: "12345678",sortByPrice:false).subscribe { event in
            switch event {
            case .success(let price):
                
                XCTAssertEqual(price.barcode,"12345678")
                XCTAssertEqual(price.shopLocation,"41p4175-1p9900")
                XCTAssertNil(price.price)
                
                asyncExpectation.fulfill()
            case .error(let error):
                print("\(error)")
                XCTFail()
                asyncExpectation.fulfill()
            }
            }.disposed(by: disposeBag)
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
}
