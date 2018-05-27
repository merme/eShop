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
        sldDistance.minimumValue = 1
        sldDistance.maximumValue = 7.301
        sldDistance.value = Float(log10(DistanceSelectorView.defaultValue))
        sldDistance.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] _ in
            
            guard let weakSelf = self else { return }
            
            weakSelf.lblDistance.text = weakSelf.formatDist(value: Int(pow(10,weakSelf.sldDistance.value)))
        }).disposed(by: disposeBag)
        
        lblDistance.text = self.formatDist(value: Int(DistanceSelectorView.defaultValue))
        
    }
    
    private func formatDist(value:Int) -> String {
    
        if value < 1000 {
            return "\(String(value)) m"
        } else if value >= 1000 && value < 10000 {
            let i:Double = Double(value) / 1000.0
             return "\(String(format: "%.1f", i)) Km"
        } else {
            return "\(String(value / 1000)) Km"
        }
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

}
