//
//  BarcodeScannerVC.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit
import BarcodeScanner
import RxSwift

class BarcodeScannerPVC: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var containerVC: UIView!
    
    // MARK: - Callbacks
    var onShopPrice: ((Price) -> Void) = { _ in }
    
    
    // MARK: - Private attributes
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let barcodeScannerViewController = BarcodeScannerViewController()
        barcodeScannerViewController.codeDelegate = self
        barcodeScannerViewController.errorDelegate = self
        barcodeScannerViewController.dismissalDelegate = self
        
        addChildViewController(barcodeScannerViewController)
        barcodeScannerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        containerVC.addSubview(barcodeScannerViewController.view)
        NSLayoutConstraint.activate([
            barcodeScannerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            barcodeScannerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            barcodeScannerViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            barcodeScannerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0)
            ])
        
        barcodeScannerViewController.didMove(toParentViewController: self)
        
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
// MARK: - BarcodeScannerCodeDelegate

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        
        ScanForPriceUC.shared
            .find(barcode: code,sortByPrice:false)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
            guard let weakSelf = self else { return }
            switch event {
            case .success(let price):
                weakSelf.onShopPrice(price)
            case .error(let error):
                print("\(error)")
                controller.resetWithError()
            }
            }.disposed(by: disposeBag)
        
    }

// MARK: - BarcodeScannerErrorDelegate

    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }

// MARK: - BarcodeScannerDismissalDelegate

    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
