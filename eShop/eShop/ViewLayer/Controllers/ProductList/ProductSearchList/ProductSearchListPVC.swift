//
//  ProductSearchListPVC.swift
//  eShop
//
//  Created by 08APO0516 on 19/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class ProductSearchListPVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupPresenterViewController()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK :-  Private/Internal
    func setupPresenterViewController() {
        self.title = R.string.localizable.product_search_title.key.localized
    }

}
