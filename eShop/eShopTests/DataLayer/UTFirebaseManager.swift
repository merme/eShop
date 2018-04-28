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
    
    func test_product_create() {

        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        product = Product(name: "berenjena", barcode: "2222")
        FirebaseManager.shared.create(product:product)
        FirebaseManager.shared.products { products in
            XCTAssertEqual(products.count,2)
            asyncExpectation.fulfill()
        }
       
        self.waitForExpectations(timeout: 10, handler: nil)
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
    
}
