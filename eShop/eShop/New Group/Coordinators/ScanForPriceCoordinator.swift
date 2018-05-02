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
    func start() {
self.presentStartScanning()
    }

    // MARK: - Private/Internal
    private func presentStartScanning()  {
        DispatchQueue.main.async {

            let startScanningPVC =  StartScanningPVC.instantiate(fromAppStoryboard: .scanForPrice)
            startScanningPVC.onScan3 = { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.presentBarcodeScanner()
            }
            
            self.scanForPriceNC.viewControllers = [startScanningPVC]
            
            if let topController = UIApplication.topViewController() {
                topController.present(self.scanForPriceNC, animated: true, completion: nil )
            } 
        }
    }
    
    private func presentBarcodeScanner() {
        
        let barcodeScannerPVC =  BarcodeScannerPVC.instantiate(fromAppStoryboard: .scanForPrice)
        
        scanForPriceNC.pushViewController(barcodeScannerPVC, animated: true)
    }

    /*
     private func dismissBuyView(refresh: Bool) {
     buyNC.dismiss(animated: true, completion: {
     self.completion(refresh)
     })
     }

     private func backToRoot() {
     buyNC.popViewController(animated: true)
     }
     */
}
