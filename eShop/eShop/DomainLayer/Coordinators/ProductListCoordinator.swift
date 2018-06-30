//
//  ScanForPriceCoordinator.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import UIKit

class  ProductListCoordinator {

    static let shared =  ProductListCoordinator()

    // MARK: - Private attributes
    private var productListNC = ProductListNC.instantiate(fromAppStoryboard: .productList)
    private init() {} //This prevents others from using the default '()' initializer for this class.

    // MARK: - Pulic methods
    @discardableResult func start() -> UINavigationController {
        self.presentProductSearchList()
        return productListNC
    }

    // MARK: - Private/Internal
    private func presentProductSearchList()  {
        DispatchQueue.main.async {

            let productSearchListPVC =  ProductSearchListPVC.instantiate(fromAppStoryboard: .productList)
            /*
            startScanningPVC.onScan = { [weak self]  distanceInM in
                guard let weakSelf = self else { return }
                weakSelf.radiousInM = distanceInM
                weakSelf.presentBarcodeScanner()
            }*/
            
            self.productListNC.viewControllers = [productSearchListPVC]
        }
    }
    
}
