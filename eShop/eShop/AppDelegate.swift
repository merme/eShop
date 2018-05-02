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
        print("init")
        
        #if DEBUG
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-DEBUG", ofType: "plist") ?? ""
        guard let fileopts = FirebaseOptions(contentsOfFile: filePath)
            else { assert(false, "Couldn't load config file"); return }
        FirebaseApp.configure(options: fileopts)
        #else
        if NSClassFromString("XCTest") == nil {
            let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") ?? ""
            guard let fileopts = FirebaseOptions(contentsOfFile: filePath)
                else { assert(false, "Couldn't load config file"); return }
            FirebaseApp.configure(options: fileopts)
        }
        #endif
        

        


    }

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /*
        // Override point for customization after application launch.
         let product = Product(name: "patatas2", barcode: "12345678")
         FirebaseManager.shared.create(product:product)
         let product2 = Product(name: "berenjena2", barcode: "2222222")
         FirebaseManager.shared.create(product:product2)

        
         FirebaseManager.shared.products { products in
         print("\(products)")

         //FirebaseManager.shared.reset()
         }
 */


        return true
    }

}
