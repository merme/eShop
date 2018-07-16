//
//  BaseViewController.swift
//  eShop
//
//  Created by 08APO0516 on 27/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        _setupNavigationControllerAndStatusBar()

        // _setupBackgroundImage()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK :- Private/Internal
    fileprivate func _setupBackgroundImage() {
        let imvBackground:UIImageView = UIImageView(frame:self.view.frame)
        imvBackground.image = R.image.background()
        //self.view.insertSubview(imvBackground, belowSubview: self.view)
        self.view.insertSubview(imvBackground, at: 0)

        NSLayoutConstraint(item: imvBackground,
                           attribute: NSLayoutAttribute.top,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: self.view,
                           attribute: NSLayoutAttribute.top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: imvBackground,
                           attribute: NSLayoutAttribute.bottom,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: self.view,
                           attribute: NSLayoutAttribute.bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: imvBackground,
                           attribute: NSLayoutAttribute.left,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: self.view,
                           attribute: NSLayoutAttribute.left,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: imvBackground,
                           attribute: NSLayoutAttribute.right,
                           relatedBy: NSLayoutRelation.equal,
                           toItem: self.view,
                           attribute: NSLayoutAttribute.right,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }

    fileprivate func _setupNavigationControllerAndStatusBar() {
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()

        if let _navigationbar = self.navigationController?.navigationBar {

            _navigationbar.barTintColor = ColorsEShop.NavigationBar.BackgroundColor
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedStringKey.font: EShopFonts.NavigationBar.TitleFont,
                NSAttributedStringKey.foregroundColor: ColorsEShop.NavigationBar.TitleFontColor
            ]
        }
    }

}
