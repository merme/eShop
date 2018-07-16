//
//  StartScanningContentVC.swift
//  eShop
//
//  Created by 08APO0516 on 02/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxCocoa
import RxSwift

class StartScanningContentVC: BaseViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var distanceSelectorView:DistanceSelectorView!

    // MARK: - Callbacks
    var onScan: ((Int) -> Void) = { _ in }

    // MARK: - Private attributes
    var disposeBag = DisposeBag()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupContentViewController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private/Internal
    func setupContentViewController() {

        distanceSelectorView.dropShadow()

        lblTitle.numberOfLines = 2
        lblTitle.font = EShopFonts.StartScanning.TitleFont
        lblTitle.textColor = ColorsEShop.StartScanning.TitleFontColor
        lblTitle.text = R.string.localizable.start_scanning_tap_start_scan.key.localized
        lblTitle.textAlignment = .center

        btnScan.setImage(R.image.img_scancode(), for: .normal)
        btnScan.rx.tap.bind { [weak self] _ in
            guard let weakSelf = self else { return }
            weakSelf.onScan( weakSelf.distanceSelectorView.getRadiousInM() )
            }
            .disposed(by: disposeBag)
    }

}
