//
//  UTShop.swift
//  eShopTests
//
//  Created by 08APO0516 on 28/04/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import XCTest
import Firebase
@testable import eShop

class UTPrice: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func test_distanceInM() {
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: nil)
        FirebaseManager.shared.create(price: price)
        
        XCTAssertEqual(price.distanceInM(latitude:  41.4189 + 0.0001, longitude: 2.0008), 13.901)
    }
    
    func test_price_nil() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        let price = Price(barcode: product.getKey(), shop: shop.getKey(), price: nil)
        FirebaseManager.shared.create(price: price)
        
        FirebaseManager.shared.find(product: product, shop: shop) { price in
            
           // guard let _price = price else {XCTFail(); return}
            
            XCTAssertEqual(price.barcode,"12345678")
            XCTAssertEqual(price.shopLocation,"41p4189-2p0008")
            XCTAssertNil(price.price)
            
            XCTAssertEqual(price.shop?.latitude, 41.4189)
            XCTAssertEqual(price.shop?.longitude, 2.0008)
            guard let _shopName = price.shop?.name else  {XCTFail(); return}
            XCTAssertEqual(_shopName, "Bon Preu Pallejà")
            
            XCTAssertEqual(price.product?.barcode, "12345678")
            guard let productName = price.product?.name else  {XCTFail(); return}
            XCTAssertEqual(productName, "patatas")
            
            asyncExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
   
   
    
}
