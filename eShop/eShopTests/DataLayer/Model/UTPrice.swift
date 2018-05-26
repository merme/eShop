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
        
        XCTAssertTrue(price.distanceInM(latitude:  41.4189 + 0.0001, longitude: 2.0008) - 11.1186 <= 0.0001)
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
    
    func test_initialize() {
        let price = Price(barcode: "123456789", shop: "Minipreu", price: 12.34)
        
        XCTAssertNil(price.shop)
        XCTAssertNil(price.product)
    }
    
    
    func test_equatable() {
        
        var product1 = Product(name: "asdfg", barcode: "1234")
        var product2 = Product(name: "asdfg", barcode: "1234")
        var shop1 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        var shop2 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        var price1 = Price(product: product1, shop: shop1, price: 10.5)
        var price2 = Price(product: product2, shop: shop2, price: 10.5)
        XCTAssertEqual(price1, price2)
        
        product1 = Product(name: "asdfgX", barcode: "1234")
        product2 = Product(name: "asdfg", barcode: "1234")
        shop1 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        shop2 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        price1 = Price(product: product1, shop: shop1, price: 10.5)
        price2 = Price(product: product2, shop: shop2, price: 10.5)
        XCTAssertNotEqual(price1, price2)
        
        
        product1 = Product(name: "asdfg", barcode: "124")
        product2 = Product(name: "asdfg", barcode: "1234")
        shop1 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        shop2 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        price1 = Price(product: product1, shop: shop1, price: 10.5)
        price2 = Price(product: product2, shop: shop2, price: 10.5)
        XCTAssertNotEqual(price1, price2)
        
        
        product1 = Product(name: "asdfg", barcode: "1234")
        product2 = Product(name: "asdfg", barcode: "1234")
        shop1 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        shop2 = Shop(name: "poiuX", latitude: 1.234, longitude: 2.343)
        price1 = Price(product: product1, shop: shop1, price: 10.5)
        price2 = Price(product: product2, shop: shop2, price: 10.5)
        XCTAssertNotEqual(price1, price2)
        
        
        product1 = Product(name: "asdfg", barcode: "1234")
        product2 = Product(name: "asdfg", barcode: "1234")
        shop1 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        shop2 = Shop(name: "poiu", latitude: 1.235, longitude: 2.343)
        price1 = Price(product: product1, shop: shop1, price: 10.5)
        price2 = Price(product: product2, shop: shop2, price: 10.5)
        XCTAssertNotEqual(price1, price2)
        
        
        product1 = Product(name: "asdfg", barcode: "1234")
        product2 = Product(name: "asdfg", barcode: "1234")
        shop1 = Shop(name: "poiu", latitude: 1.234, longitude: 2.34)
        shop2 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        price1 = Price(product: product1, shop: shop1, price: 10.5)
        price2 = Price(product: product2, shop: shop2, price: 10.5)
        XCTAssertNotEqual(price1, price2)
        
        
        product1 = Product(name: "asdfgX", barcode: "1234")
        product2 = Product(name: "asdfg", barcode: "1234")
        shop1 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        shop2 = Shop(name: "poiu", latitude: 1.234, longitude: 2.343)
        price1 = Price(product: product1, shop: shop1, price: 10.4)
        price2 = Price(product: product2, shop: shop2, price: 10.5)
        XCTAssertNotEqual(price1, price2)

    }
   
    
}
