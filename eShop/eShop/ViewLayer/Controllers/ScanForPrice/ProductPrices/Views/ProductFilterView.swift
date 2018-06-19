//
//  ProductFilterView.swift
//  eShop
//
//  Created by 08APO0516 on 07/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum SortingType: Int {
    case price
    case distance
    
    static let items:[String] = [SortingType.price.text(), SortingType.distance.text()]
    
    func text() -> String {
        switch self {
        case .price: return R.string.localizable.product_prices_price.key.localized
        case .distance: return R.string.localizable.product_prices_distance.key.localized
        }
    }
}

class ProductFilterView: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var distanceSelectorView: DistanceSelectorView!
    @IBOutlet weak var segSortDistancePrice: UISegmentedControl!
    
    // MARK: - Callbacks
    var onSortBy: (SortingType) -> Void = { _ in }
    var onDistanceChanged: (Int) -> Void = { _ in }
    
    // MARK: - Private attributes
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self._setupView()
        self._refreshView()
    }
    
    
    
    // MARK :- Private/Internal
    private func _setupView() {
      
        self.backgroundColor = ColorsEShop.ProductPrices.DistanceSelectorColor
        
       // self.distanceSelectorView.backgroundColor = UIColor.clear
        
        self.segSortDistancePrice.removeAllSegments()
        self.segSortDistancePrice.insertSegment(withTitle: SortingType.price.text(), at: SortingType.price.rawValue, animated: false)
        self.segSortDistancePrice.insertSegment(withTitle: SortingType.distance.text(), at: SortingType.distance.rawValue, animated: false)
        
        let font: [AnyHashable : Any] = [NSAttributedStringKey.font : EShopFonts.ProductPrices.SelectorFont,
                                         NSAttributedStringKey.foregroundColor : ColorsEShop.ProductPrices.NormalFontColor]
        let fontSelected: [AnyHashable : Any] = [NSAttributedStringKey.font : EShopFonts.ProductPrices.SelectorFont,
                                         NSAttributedStringKey.foregroundColor : ColorsEShop.ProductPrices.SelectedFontColor]
        segSortDistancePrice.setTitleTextAttributes(font, for: .normal)
        segSortDistancePrice.setTitleTextAttributes(fontSelected, for: .selected)
        segSortDistancePrice.selectedSegmentIndex = 0
        segSortDistancePrice.tintColor = ColorsEShop.ProductPrices.NormalFontColor
        
        segSortDistancePrice.rx.selectedSegmentIndex.bind { [weak self] index in
            guard let weakSelf  = self  else { return }
            weakSelf.onSortBy(SortingType(rawValue: index)!)
        }.disposed(by: disposeBag)
        
    }
    
    private func _refreshView() {
        
        
    }

}
