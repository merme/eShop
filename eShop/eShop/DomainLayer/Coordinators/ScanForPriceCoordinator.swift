//
//  ScanForPriceCoordinator.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import UIKit

class  ScanForPriceCoordinator {

    static let shared =  ScanForPriceCoordinator()

    // MARK: - Private attributes
    private var scanForPriceNC = ScanForPriceNC.instantiate(fromAppStoryboard: .scanForPrice)
    private var radiousInM:Int = 10000
    private init() {} //This prevents others from using the default '()' initializer for this class.

    // MARK: - Pulic methods
    @discardableResult func start() -> UINavigationController {
        
        scanForPriceNC.tabBarItem =  UITabBarItem(title: R.string.localizable.start_scanning_title.key.localized,
                                                  image: R.image.tab_scancode(),
                                                  selectedImage: R.image.tab_scancode())
        
        self.presentStartScanning()
        
        return scanForPriceNC
    }

    // MARK: - Private/Internal
    private func presentStartScanning()  {
        DispatchQueue.main.async {

            let startScanningPVC =  StartScanningPVC.instantiate(fromAppStoryboard: .scanForPrice)
            startScanningPVC.onScan = { [weak self]  distanceInM in
                guard let weakSelf = self else { return }
                weakSelf.radiousInM = distanceInM
                weakSelf.presentBarcodeScanner()
            }
            
            self.scanForPriceNC.viewControllers = [startScanningPVC]
        }
    }
    
    private func presentBarcodeScanner() {
        
        let barcodeScannerPVC =  BarcodeScannerPVC.instantiate(fromAppStoryboard: .scanForPrice)
        barcodeScannerPVC.hidesBottomBarWhenPushed = true
        barcodeScannerPVC.onShopPrice = { [weak self] price in
            guard let weakSelf = self else { return }
            weakSelf.presentShopPrice(price: price)
        }
        
        scanForPriceNC.pushViewController(barcodeScannerPVC, animated: true)
    }

    private func presentShopPrice(price: Price) {
        let shopPricePVC =  ShopPricePVC.instantiate(fromAppStoryboard: .scanForPrice)
        shopPricePVC.price = price
        shopPricePVC.onPriceUpdated = { [weak self] updatedPrice in
            guard let weakSelf = self,
                let _product = updatedPrice.product else { return }
           weakSelf.presentProductPrices(product:_product,radiousInM:weakSelf.radiousInM)
        }
        shopPricePVC.onClose = { [weak self]  in
            guard let weakSelf = self else { return }
           
            weakSelf.scanForPriceNC.popToRootViewController(animated: false)
        }
        
        scanForPriceNC.pushViewController(shopPricePVC, animated: true)
    }
    
    private func presentProductPrices(product: Product, radiousInM: Int) {
        
        let productPricesPVC = ProductPricesPVC.instantiate(fromAppStoryboard: .scanForPrice)
        productPricesPVC.product = product
        productPricesPVC.radiousInM = radiousInM
        productPricesPVC.onDone = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.scanForPriceNC.popToRootViewController(animated: false)
        }
        
        
         scanForPriceNC.pushViewController(productPricesPVC, animated: true)
        
        /*
        self.scanForPriceNC.viewControllers = [productProductPrices]
        
        if let topController = UIApplication.topViewController() {
            topController.present(self.scanForPriceNC, animated: true, completion: nil )
        }*/
        
    }
    
    
    
}
