//
//  DistanceSelectorView.swift
//  eShop
//
//  Created by 08APO0516 on 27/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxCocoa
import RxSwift

class DistanceSelectorView: UIView {

    // MARK :- IBOUTLET
    @IBOutlet weak var sldDistance: UISlider!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    // MARK: - Callbacks
    var onDistanceChanged: (Int) -> Void = { _ in }

    // MARK :- Private attributes
    private static let defaultValue:Double = 10000.0
    private var disposeBag = DisposeBag()

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()

        self._setupView()
        self._refreshView()
    }

    // MARK :- Public
    func getRadiousInM() -> Int {

        return Int(pow(10,self.sldDistance.value))
    }

    // MARK :- Private/Internal
    private func _setupView() {

        lblTitle.numberOfLines = 1
        lblTitle.font = EShopFonts.DistanceSelector.TitleFont
        lblTitle.textColor = ColorsEShop.DistanceSelector.TitleFontColor
        lblTitle.text = R.string.localizable.distance_selecgtor_title.key.localized

        lblDistance.numberOfLines = 1
        lblDistance.font = EShopFonts.DistanceSelector.DistanceFont
        lblDistance.textColor = ColorsEShop.DistanceSelector.DistanceFontColor
        lblDistance.textAlignment = .right

        sldDistance.minimumValue = 1
        sldDistance.maximumValue = 7.301
        sldDistance.tintColor = ColorsEShop.DistanceSelector.DistanceFontColor
        sldDistance.value = Float(log10(DistanceSelectorView.defaultValue))
        sldDistance.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] _ in

            guard let weakSelf = self else { return }
            let _distanceInM =  Int(pow(10,weakSelf.sldDistance.value))
            weakSelf.lblDistance.text = _distanceInM.formatDist()
            weakSelf.onDistanceChanged(_distanceInM)
        }).disposed(by: disposeBag)

        self.lblDistance.text = Int(pow(10,self.sldDistance.value)).formatDist()
    }

    func _refreshView() {

    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */

    class ApiController {

        struct Weather {
            let cityName: String
            let temperature: Int
            let humidity: Int
            let icon: String

            static let empty = Weather(
                cityName: "Unknown",
                temperature: -1000,
                humidity: 0,
                icon: ""
            )
        }
    }

}
