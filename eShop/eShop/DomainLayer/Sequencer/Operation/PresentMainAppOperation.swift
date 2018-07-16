//
//  PresentMainAppOperation.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation
import UIKit

class PresentMainAppOperation: ConcurrentOperation {

    override init() {
        super.init()
    }

    override func main() {
        DispatchQueue.main.async {
            let mainTabBarController = MainTabBarController.instantiate(fromAppStoryboard: .Main)
            mainTabBarController.viewControllers = [ScanForPriceCoordinator.shared.start(),
                                                    ProductListCoordinator.shared.start()]
            mainTabBarController.modalTransitionStyle = .crossDissolve

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController?.present(mainTabBarController, animated: true, completion: nil)

            self.state = .Finished
        }
    }
}
