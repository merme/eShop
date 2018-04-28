//
//  AppDelegate.swift
//  eShop
//
//  Created by 08APO0516 on 28/04/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        
      //  if NSClassFromString("XCTest") == nil {
            FirebaseApp.configure()
      //  }
        
       
    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       /* let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        let product2 = Product(name: "berenjena", barcode: "2222222")
        FirebaseManager.shared.create(product:product2)
        
        FirebaseManager.shared.products { products in
            print("todo")
            
            FirebaseManager.shared.reset()
        }*/
    
        
        return true
    }

}
