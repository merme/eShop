//
//  eShopFonts.swift
//  eShop
//
//  Created by 08APO0516 on 27/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import Foundation
import UIKit

struct EShopFonts {

    struct NavigationBar {
        static let TitleFont = TextStyle.h18Bold.font
    }

    struct DistanceSelector {
        static let TitleFont = TextStyle.h18Bold.font
        static let DistanceFont = TextStyle.h18Bold.font
    }

    struct StartScanning {
        static let TitleFont      = TextStyle.h24Bold.font
    }

    struct ProductPrices {
        static let DistanceFont      = TextStyle.h40Bold.font
        static let ShopFont         = TextStyle.h40Bold.font
        static let PriceFont        = TextStyle.h40Bold.font
        static let SelectorFont        = TextStyle.h20Bold.font
    }

    struct ShopPrice {
        static let ProductFont      = TextStyle.h40Bold.font
        static let ShopFont         = TextStyle.h40Bold.font
        static let PriceFont        = TextStyle.h75Bold.font
        static let PricesFoundFont  = TextStyle.h36Bold.font
    }

    struct Home {

        static let MachineSelectorFont      = TextStyle.h15Regular.font
        static let MissingAlarmFont         = TextStyle.h15Regular.font
        static let MissingFavouriteFont     = TextStyle.h15Bold.font
        static let GoToRecipesFont          = TextStyle.h14Regular.font
        static let hhmmFont                 = TextStyle.h24Bold.font
        static let AlarmNameFont            = TextStyle.h15Regular.font
        static let MachineNameFont          = TextStyle.h15Regular.font
    }

}

enum TextStyle {
    case dynamic(style: UIFontTextStyle)
    case customBold (size: CGFloat)
    case customRegular (size: CGFloat)
    case customThin (size: CGFloat)
    case customUltralight (size: CGFloat)
}

enum TextStyleSize:Int {
    case h120 = 120
    case h75 = 75
    case h40 = 40
    case h36 = 36
    case h28 = 28
    case h24 = 24
    case h22 = 22
    case h20 = 20
    case h18 = 18
    case h17 = 17
    case h16 = 16
    case h15 = 15
    case h14 = 14
    case h10 = 10
    case h6  = 6
}

extension TextStyle {

    static let body = TextStyle.dynamic(style: .body)
    //static let headline = TextStyle.customBold(size: 20, weight: UIFontWeightBold, height: 24, dropShadow: true)

    static let h120Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h120.rawValue))
    static let h75Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h36Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h24Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h24.rawValue))
    static let h20Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h17Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h15Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h10Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h10.rawValue))

    static let h120Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h75Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h36Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h20Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h17Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h16Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h16.rawValue))
    static let h15Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h10Regular = TextStyle.customRegular(size: CGFloat(TextStyleSize.h10.rawValue))
    static let h6Regular  = TextStyle.customRegular(size: CGFloat(TextStyleSize.h6.rawValue))

    static let h120Thin = TextStyle.customRegular(size: CGFloat(TextStyleSize.h120.rawValue))
    static let h75Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h28Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h28.rawValue))
    static let h36Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h20Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h17Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h15Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h10Thin = TextStyle.customThin(size: CGFloat(TextStyleSize.h10.rawValue))

    static let h120Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h120.rawValue))
    static let h75Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h36Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h28Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h28.rawValue))
    static let h24Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h24.rawValue))
    static let h22Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h22.rawValue))
    static let h20Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h16Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h16.rawValue))
    static let h17Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h15Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h10Ultralight = TextStyle.customUltralight(size: CGFloat(TextStyleSize.h10.rawValue))

    var font :UIFont {

        let font:UIFont?
        switch self {
        case let .dynamic(style):
            font = UIFont.preferredFont(forTextStyle: style)
        case let .customBold(size):
            font = UIFont(name: "SanFranciscoDisplay-Bold", size: size)!
        case let .customRegular(size):
            font = UIFont(name: "SanFranciscoDisplay-Regular", size: size)!
        case let .customThin(size):
            font = UIFont(name: "SanFranciscoDisplay-Thin", size: size)!
        case let .customUltralight(size):
            font = UIFont(name: "anFranciscoDisplay-Ultralight", size: size)!
        }
        guard font != nil else {
            return UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        }

        return font!

    }

}
