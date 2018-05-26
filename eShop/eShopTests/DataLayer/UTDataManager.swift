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
        DataManager.shared.find(latitude: 41.4175, longitude: 1.9992, barcode: "12345678").subscribe { event in
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
        DataManager.shared.find(latitude: 41.4175, longitude: 1.9900, barcode: "12345678").subscribe { event in
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
    
    
    
    
    
    /*
 
 
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
 */
    
   
    
}
