//
//  UIViewExtension.swift
//  eShop
//
//  Created by 08APO0516 on 17/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        
        self.layer.borderColor = self.backgroundColor?.cgColor
        self.layer.borderWidth = 3.0
        self.layer.shadowColor = UIColor.darkGray.cgColor//self.backgroundColor?.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale =  UIScreen.main.scale//[UIScreen mainScreen].scale;
        
    }
    
    func dropUpperShadow(scale: Bool = true) {
        
        self.layer.borderColor = self.backgroundColor?.cgColor
        self.layer.borderWidth = 3.0
        self.layer.shadowColor = UIColor.darkGray.cgColor//self.backgroundColor?.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale =  UIScreen.main.scale//[UIScreen mainScreen].scale;
        
    }
    
}
