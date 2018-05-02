//
//  StartScanningPVC.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class StartScanningPVC: UIViewController {
    
    // MARK: - Private/Internal
    private var startScanningContentVC:StartScanningContentVC?
    
    // MARK: - Callbacks
    var onScan3: (() -> Void) = { }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier ==  R.segue.startScanningPVC.startScanningContentSegue.identifier) {
            startScanningContentVC = segue.destination as? StartScanningContentVC
            
            startScanningContentVC?.onScan = { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.onScan3()
            }
        }
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
