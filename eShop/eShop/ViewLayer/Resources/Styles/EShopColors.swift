//
//  EShopColors.swift
//  eShop
//
//  Created by 08APO0516 on 29/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import UIKit.UIColor

// MARK: - App Colors
struct ColorsEShop {

    struct Interface {
        static let ColorPink            = #colorLiteral(red: 0.8470588235, green: 0.3607843137, blue: 0.4470588235, alpha: 1)//D85C72
        static let ColorYellow          = #colorLiteral(red: 0.9333333333, green: 0.862745098, blue: 0, alpha: 1)//EEDC00
        static let ColorYellowCobalt    = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.4823529412, alpha: 1)//FFD37B
        static let ColorLightBlue       = #colorLiteral(red: 0.3882352941, green: 0.8156862745, blue: 0.8745098039, alpha: 1)//63D0DF
        static let ColorBlue            = #colorLiteral(red: 0.2862745098, green: 0.5647058824, blue: 0.8862745098, alpha: 1)//4990E2
        static let ColorDarkBlue        = #colorLiteral(red: 0.231372549, green: 0.3490196078, blue: 0.5960784314, alpha: 1)//3B5998
        static let colorGold            = #colorLiteral(red: 0.862745098, green: 0.7725490196, blue: 0.3333333333, alpha: 1)//DCC555
        static let ColorBrown           = #colorLiteral(red: 0.8392156863, green: 0.7294117647, blue: 0.5490196078, alpha: 1)//D6BA8C
        static let ColorLightBrown      = #colorLiteral(red: 0.8720434308, green: 0.7751034498, blue: 0.617057085, alpha: 0.7021071743)//d5b98b
        static let ColorLightClearBrown = #colorLiteral(red: 0.8720434308, green: 0.7751034498, blue: 0.617057085, alpha: 0.3)//D6BA8C #colorLiteral(red: 0.8720434308, green: 0.7751034498, blue: 0.617057085, alpha: 0.3)
        static let ColorGrey            = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)//999999
        static let ColorLightGrey       = #colorLiteral(red: 0.8470588235, green: 0.8196078431, blue: 0.7921568627, alpha: 1)//D8D1CA
        static let ColorWhite           = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)//FFFFFF
        static let ColorWhiteAlpha05    = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)//FFFFFF
        static let ColorBlack           = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)//000000
        static let ColorClear           = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)//000000
        static let ColorRed             = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)//FF0000
        static let ColorGreen           = #colorLiteral(red: 0.3921568627, green: 0.7294117647, blue: 0.01568627451, alpha: 1)//64BA04
    }

    // MARK: - NavigationBar
    struct NavigationBar {
        static let TitleFontColor  = Interface.ColorDarkBlue
        static let BackgroundColor = Interface.ColorWhite
    }

    struct DistanceSelector {
        static let TitleFontColor = Interface.ColorDarkBlue
        static let DistanceFontColor = Interface.ColorDarkBlue
    }

    struct StartScanning {
        static let TitleFontColor = Interface.ColorDarkBlue
    }

    // MARK: - ShopPrice
    struct ShopPrice {
        static let PricesFoundBackground = ColorsEShop.Interface.ColorWhite
        static let FontColor = ColorsEShop.Interface.ColorDarkBlue
    }

    struct ProductPrices {
        static let PriceFontColor = ColorsEShop.Interface.ColorDarkBlue
        static let DistanceFontColor = ColorsEShop.Interface.ColorDarkBlue
        static let ShopFontColor = ColorsEShop.Interface.ColorDarkBlue
        static let NormalFontColor = ColorsEShop.Interface.ColorDarkBlue
        static let SelectedFontColor = ColorsEShop.Interface.ColorWhite
        static let DistanceSelectorColor = ColorsEShop.Interface.ColorWhite
    }
}

extension UIColor {
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
