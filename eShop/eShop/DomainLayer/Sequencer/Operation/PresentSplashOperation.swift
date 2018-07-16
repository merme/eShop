//
//  PresentMainAppOperation.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation
import UIKit

class PresentSplashOperation: ConcurrentOperation {

    override init() {
        super.init()
    }

    override func main() {
        DispatchQueue.main.async {
            let appDelegate  = UIApplication.shared.delegate as! AppDelegate
            let splashViewController = SplashVC.instantiate(fromAppStoryboard: .Main)
            splashViewController.modalTransitionStyle = .crossDissolve
            splashViewController.onAnimationDoneAction = { [weak self] in

                guard let weakSelf = self else { return }

                weakSelf.state = .Finished
            }

            appDelegate.window!.rootViewController = splashViewController
            // ?.present(splashViewController, animated: true, completion: nil)//
        }

    }
}
