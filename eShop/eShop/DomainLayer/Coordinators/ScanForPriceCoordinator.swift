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

    private init() {} //This prevents others from using the default '()' initializer for this class.

    // MARK: - Pulic methods
    @discardableResult func start() -> UINavigationController {
        self.presentStartScanning()
        return scanForPriceNC
        
        /*
        DataManager.shared.reset()
        LocationManager.shared.requestOrRememberLocationAuthorization()
        var shop = Shop(name: "Bon Preu Pallejà",latitude: LocationManager.DefaultPosition.latitude + Shop.m2Degree(m: 3000), longitude: LocationManager.DefaultPosition.longitude)
        FirebaseManager.shared.create(shop: shop)
        
        let product = Product(name: "patatas", barcode: "12345678")
        FirebaseManager.shared.create(product:product)
        
        var price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 10.0)
        FirebaseManager.shared.create(price: price)
        
        
         shop = Shop(name: "Minipreu", latitude:  LocationManager.DefaultPosition.latitude + Shop.m2Degree(m: 6000), longitude: LocationManager.DefaultPosition.longitude)
        FirebaseManager.shared.create(shop: shop)
        
        
        price = Price(barcode: product.getKey(), shop: shop.getKey(), price: 15.0)
        FirebaseManager.shared.create(price: price)
        
        
        
        
        */
        /*
        let price = Price(product: Product(name: "patatas", barcode: "12345678"),
                          shop: Shop(name: "Minipreu", latitude: 1.2343, longitude: 1.3243),
                          price: 12.34)
        
        self.presentShopPrice(price: price)
 */
    }

    // MARK: - Private/Internal
    private func presentStartScanning()  {
        DispatchQueue.main.async {

            let startScanningPVC =  StartScanningPVC.instantiate(fromAppStoryboard: .scanForPrice)
            startScanningPVC.onScan = { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.presentBarcodeScanner()
            }
            
            self.scanForPriceNC.viewControllers = [startScanningPVC]
            /*
            if let topController = UIApplication.topViewController() {
                topController.present(self.scanForPriceNC, animated: true, completion: nil )
            }*/
        }
    }
    
    private func presentBarcodeScanner() {
        
        let barcodeScannerPVC =  BarcodeScannerPVC.instantiate(fromAppStoryboard: .scanForPrice)
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
           weakSelf.presentProductPrices(product:_product,radiousInM:10000)
        }
        
        scanForPriceNC.pushViewController(shopPricePVC, animated: true)
        /*
        self.scanForPriceNC.viewControllers = [shopPricePVC]
        
        if let topController = UIApplication.topViewController() {
            topController.present(self.scanForPriceNC, animated: true, completion: nil )
        }*/
    }
    
    private func presentProductPrices(product: Product, radiousInM: Double) {
        
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
