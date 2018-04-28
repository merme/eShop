//
//  FirebaseManager.swift
//
//
//  Created by 08APO0516 on 28/04/2018.
//

import Foundation
import Firebase

final class FirebaseManager {

    static let shared = FirebaseManager()
    
    let productsKeyReference = Database.database().reference(withPath:"products")

    private init() {
        //if NSClassFromString("XCTest") != nil {
        //    FirebaseApp.configure()
        //}
    }
    
    func reset() {
        self.productsKeyReference.ref.removeValue()
    }
    
    func create(product:Product) {
        
        let productItemRef = self.productsKeyReference.child(product.barcode)
        
        productItemRef.setValue(product.toAnyObject())
    }
    
    func products(onComplete:@escaping ([Product]) -> Void ) {
        productsKeyReference.observe(.value) { snapshot in
            let products:[Product] = snapshot.children.map {
                let jsonProduct = $0
                return Product(snapshot: jsonProduct as! DataSnapshot)!
            }
            onComplete(products)
        }
    }
    
    func find(barcode:String, onComplete:@escaping (Product?) -> Void ) {
        
        //print(productsKeyReference.child(barcode).description())
        productsKeyReference.child(barcode).queryOrdered(byChild: "barcode").observeSingleEvent(of: .value, with: { snapshot in
            onComplete(Product(snapshot: snapshot ))
        })
    }
}
