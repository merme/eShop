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

class UTProduct: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_name_nil() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var product = Product(name: nil, barcode: "1111")
        FirebaseManager.shared.create(product: product)
        
        FirebaseManager.shared.find(barcode: "1111") { product in
        
            XCTAssertNotNil(product)
            XCTAssertNil(product?.name)
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
   
   
    
}
