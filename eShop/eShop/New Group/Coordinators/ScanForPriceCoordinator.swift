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
    private func presentStartScanning() {
        DispatchQueue.main.async {

            let startScanningPVC =  StartScanningPVC.instantiate(fromAppStoryboard: .scanForPrice)
            
            self.scanForPriceNC.viewControllers = [startScanningPVC]

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            if let _window = appDelegate.window {
                _window.rootViewController = self.scanForPriceNC
            } else {
                print("Therse no ViewController set as initial in main.storyboard")
            }
        
        }
        
        
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
