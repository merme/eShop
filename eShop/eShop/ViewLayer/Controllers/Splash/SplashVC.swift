//
//  SplashVC.swift
//  eShop
//
//  Created by 08APO0516 on 03/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    // MARK: - Callbacks
    var onAnimationDoneAction: (() -> Void) = { }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.onAnimationDoneAction()
        
       // StartUpAppSequencer.shared.start()
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
