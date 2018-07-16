//
//  ShopPriceTVC.swift
//  eShop
//
//  Created by 08APO0516 on 15/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import RxCocoa
import RxSwift
import CoreLocation

class ProductPricesTVC: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDistanceM: UILabel!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var imgPrice: UIImageView!
    @IBOutlet weak var imgDistance: UIImageView!

    //@IBOutlet weak var lblValue: UILabel!

    // MARK: - Callbacks
    var onEditingEnd: ((ShopPriceContentField, String? ) -> Void) = { _ ,_  in }

    // MARK: - Public attribures
    var price:Price? {
        didSet {
            self._refreshView()
        }
    }

    var location:CLLocation? {
        didSet {
            self._refreshView()
        }
    }

    // MARK: - Private attributes

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Private / Intrnal
    private func setupView() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none

        imgPrice.image = R.image.img_price()

        imgDistance.image = R.image.img_distance()

        lblPrice.numberOfLines = 1
        lblPrice.font = EShopFonts.ProductPrices.PriceFont
        lblPrice.textColor = ColorsEShop.ProductPrices.PriceFontColor

        lblDistanceM.numberOfLines = 1
        lblDistanceM.font = EShopFonts.ProductPrices.DistanceFont
        lblDistanceM.textColor = ColorsEShop.ProductPrices.DistanceFontColor

        lblShopName.numberOfLines = 1
        lblShopName.font = EShopFonts.ProductPrices.ShopFont
        lblShopName.textColor = ColorsEShop.ProductPrices.ShopFontColor

    }

    private func _refreshView() {
        guard let _price = price        else { return }

        _price.getShop(shopLocation: _price.shopLocation) { [weak self] shop in
            guard let weakSelf = self else { return}
            weakSelf.lblShopName.text = shop?.name ?? "???"
        }

        lblPrice.text = String(_price.price ?? 0)
        if let _location = self.location {
            let distanceM = _price.distanceInM(latitude: _location.coordinate.latitude,
                                               longitude: _location.coordinate.longitude)
            lblDistanceM.text = Int(distanceM).formatDist()
        }
    }

}
