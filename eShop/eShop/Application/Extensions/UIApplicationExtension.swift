//
//  UIApplicationExtension.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

extension UIApplication {

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func present(viewController: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {

        if var topController = UIApplication.shared.delegate?.window??.rootViewController {

            while ((topController.presentedViewController) != nil) {
                if let _presentendViewController = topController.presentedViewController {
                    topController = _presentendViewController
                }
            }

            topController.present(viewController, animated: animated, completion:completion)
        }
    }

    func fvc_open(_ paramUrl: URL, completion: ((Bool) -> Void)? = nil) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(paramUrl) {
                completion?($0)
            }
        } else {
            let result = UIApplication.shared.openURL(paramUrl)
            completion?(result)
        }
    }
}
