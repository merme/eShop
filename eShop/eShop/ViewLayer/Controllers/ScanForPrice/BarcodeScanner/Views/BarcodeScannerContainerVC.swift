//
//  BarcodeScannerContainerVC.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit
import BarcodeScanner

class BarcodeScannerContainerVC: BarcodeScannerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.messageViewController.regularTintColor = ColorsEShop.NavigationBar.TitleFontColor
        self.messageViewController.messages.scanningText = "_scannig text"
        self.messageViewController.messages.processingText = "_processing text"

        self.headerViewController.titleLabel.font = EShopFonts.NavigationBar.TitleFont
        self.headerViewController.titleLabel.highlightedTextColor = ColorsEShop.NavigationBar.TitleFontColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}