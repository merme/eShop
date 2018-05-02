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

class UTShop: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_init_key() {
        let shop = Shop(key:"41p4189-2p0008")
        XCTAssertEqual(shop.latitude, 41.4189)
        XCTAssertEqual(shop.longitude, 2.0008)
    }
    
    
    
    func test_name_nil() {
        FirebaseManager.shared.reset()
        
        let asyncExpectation = expectation(description: "\(#function)")
        
        var shop = Shop(name: nil, latitude:  41.4189, longitude: 2.0008)
        FirebaseManager.shared.create(shop: shop)
        
        
        FirebaseManager.shared.find(latitude: 41.4191, longitude: 1.9999, radious: 1000 ) { shops in
            guard shops.count == 1 else { XCTFail(); return }
            XCTAssertNil(shops[0].name)
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_getKey() {
        var shop = Shop(name: "", latitude: 123.1234, longitude: 321.4321)
        XCTAssertEqual(shop.getKey(),"123p1234-321p4321")
        
        shop = Shop(name: "", latitude: 123.12345, longitude: 321.54321)
        XCTAssertEqual(shop.getKey(),"123p1235-321p5432")
        
        shop = Shop(name: "", latitude: 123.123, longitude: 321.321)
        XCTAssertEqual(shop.getKey(),"123p1230-321p3210")
    }
    
    func test_isPointInRadious() {
        
        var shop = Shop(name: "", latitude: -1, longitude: 1)
        XCTAssertTrue(shop.isPointInRadious(latitude: 0, longitude: 0, radiousM: 200000)) //200KM, 1 degree 111Km

        shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10),false)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 100),false)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 1000),true)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10000),true)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 100000),true)
        
        //@36.4285544,-5.1307777,21z
        shop = Shop(name: "Carrefour Estepona", latitude:  36.4285, longitude: -5.1307)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10),false)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 100),false)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 1000),false)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10000),false)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 100000),false)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 1000000),true)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10000000),true)
        
        //@49.2901279,-123.1325061,21z
        shop = Shop(name: "Whole Foods Market Vancouver", latitude:  49.2901, longitude: -123.1325)
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10),false) //10m
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 100),false) //100m
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 1000),false) //1 Km
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10000),false) //10 Km
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 100000),false) //100 Km
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 1000000),false) //1.000 Km
        XCTAssertEqual(shop.isPointInRadious(latitude: 41.4213, longitude: 1.9998, radiousM: 10000000),true) //10.0000 Km
    }
    
    func test_distanceInM() {
        
        let shop = Shop(name: "Bon Preu Pallejà", latitude:  41.4189, longitude: 2.0008)
        
        XCTAssertEqual(shop.distanceInM( latitude:  41.4189, longitude: 2.0008), 0)
        
        XCTAssertEqual(shop.distanceInM( latitude:  41.4189 - 0.0001, longitude: 2.0008), 13.901)
        XCTAssertEqual(abs(shop.distanceInM( latitude:  41.4189 - 0.0010, longitude: 2.0008) - 139.0099) <= 0.0002 , true)
        XCTAssertEqual(abs(shop.distanceInM( latitude:  41.4189 - 0.0010, longitude: 2.0008 + 0.0010) - 139.0099) <= 0.0002, true)
        XCTAssertEqual(abs(shop.distanceInM( latitude:  41.4189 - 0.0100, longitude: 2.0008) - 1390.0994) <= 0.0003, true)
        XCTAssertEqual(abs(shop.distanceInM( latitude:  41.4189 - 0.0100, longitude: 2.0008 + 0.0100) - 1390.0994) <= 0.0003, true)
    }
   
    
}
