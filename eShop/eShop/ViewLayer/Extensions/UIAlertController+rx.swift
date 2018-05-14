//
//  UIAlertController+rx.swift
//  eShop
//
//  Created by 08APO0516 on 08/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxSwift
import RxCocoa

import Foundation

extension UIAlertController {
    
    struct AlertAction {
        var title: String?
        var style: UIAlertActionStyle
        
        static func action(title: String?, style: UIAlertActionStyle = .default) -> AlertAction {
            return AlertAction(title: title, style: style)
        }
    }
    
    static func present(
        in viewController: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertControllerStyle,
        actions: [AlertAction])
        -> Single<Int>
    {
        return Single.create { single in
            
            let disposable = Disposables.create()
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                        single(.success(index))
                }
                alertController.addAction(action)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create {
                // Look out when disposable is called before on .success.
                alertController.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}
