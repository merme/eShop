//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 6 files.
  struct file {
    /// Resource file `GoogleService-Info-DEBUG.plist`.
    static let googleServiceInfoDEBUGPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info-DEBUG", pathExtension: "plist")
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    /// Resource file `SanFranciscoDisplay-Bold.otf`.
    static let sanFranciscoDisplayBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SanFranciscoDisplay-Bold", pathExtension: "otf")
    /// Resource file `SanFranciscoDisplay-Regular.otf`.
    static let sanFranciscoDisplayRegularOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SanFranciscoDisplay-Regular", pathExtension: "otf")
    /// Resource file `SanFranciscoDisplay-Thin.otf`.
    static let sanFranciscoDisplayThinOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SanFranciscoDisplay-Thin", pathExtension: "otf")
    /// Resource file `SanFranciscoDisplay-Ultralight.otf`.
    static let sanFranciscoDisplayUltralightOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "SanFranciscoDisplay-Ultralight", pathExtension: "otf")
    
    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "GoogleService-Info-DEBUG", withExtension: "plist")`
    static func googleServiceInfoDEBUGPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoDEBUGPlist
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "SanFranciscoDisplay-Bold", withExtension: "otf")`
    static func sanFranciscoDisplayBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sanFranciscoDisplayBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "SanFranciscoDisplay-Regular", withExtension: "otf")`
    static func sanFranciscoDisplayRegularOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sanFranciscoDisplayRegularOtf
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "SanFranciscoDisplay-Thin", withExtension: "otf")`
    static func sanFranciscoDisplayThinOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sanFranciscoDisplayThinOtf
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "SanFranciscoDisplay-Ultralight", withExtension: "otf")`
    static func sanFranciscoDisplayUltralightOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.sanFranciscoDisplayUltralightOtf
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 4 fonts.
  struct font: Rswift.Validatable {
    /// Font `SanFranciscoDisplay-Bold`.
    static let sanFranciscoDisplayBold = Rswift.FontResource(fontName: "SanFranciscoDisplay-Bold")
    /// Font `SanFranciscoDisplay-Regular`.
    static let sanFranciscoDisplayRegular = Rswift.FontResource(fontName: "SanFranciscoDisplay-Regular")
    /// Font `SanFranciscoDisplay-Thin`.
    static let sanFranciscoDisplayThin = Rswift.FontResource(fontName: "SanFranciscoDisplay-Thin")
    /// Font `SanFranciscoDisplay-Ultralight`.
    static let sanFranciscoDisplayUltralight = Rswift.FontResource(fontName: "SanFranciscoDisplay-Ultralight")
    
    /// `UIFont(name: "SanFranciscoDisplay-Bold", size: ...)`
    static func sanFranciscoDisplayBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sanFranciscoDisplayBold, size: size)
    }
    
    /// `UIFont(name: "SanFranciscoDisplay-Regular", size: ...)`
    static func sanFranciscoDisplayRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sanFranciscoDisplayRegular, size: size)
    }
    
    /// `UIFont(name: "SanFranciscoDisplay-Thin", size: ...)`
    static func sanFranciscoDisplayThin(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sanFranciscoDisplayThin, size: size)
    }
    
    /// `UIFont(name: "SanFranciscoDisplay-Ultralight", size: ...)`
    static func sanFranciscoDisplayUltralight(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: sanFranciscoDisplayUltralight, size: size)
    }
    
    static func validate() throws {
      if R.font.sanFranciscoDisplayUltralight(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SanFranciscoDisplay-Ultralight' could not be loaded, is 'SanFranciscoDisplay-Ultralight.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sanFranciscoDisplayRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SanFranciscoDisplay-Regular' could not be loaded, is 'SanFranciscoDisplay-Regular.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sanFranciscoDisplayThin(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SanFranciscoDisplay-Thin' could not be loaded, is 'SanFranciscoDisplay-Thin.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.sanFranciscoDisplayBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'SanFranciscoDisplay-Bold' could not be loaded, is 'SanFranciscoDisplay-Bold.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 9 images.
  struct image {
    /// Image `background`.
    static let background = Rswift.ImageResource(bundle: R.hostingBundle, name: "background")
    /// Image `img_close`.
    static let img_close = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_close")
    /// Image `img_continue`.
    static let img_continue = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_continue")
    /// Image `img_distance`.
    static let img_distance = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_distance")
    /// Image `img_edit`.
    static let img_edit = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_edit")
    /// Image `img_price`.
    static let img_price = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_price")
    /// Image `img_scancode`.
    static let img_scancode = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_scancode")
    /// Image `img_shop`.
    static let img_shop = Rswift.ImageResource(bundle: R.hostingBundle, name: "img_shop")
    /// Image `tab_scancode`.
    static let tab_scancode = Rswift.ImageResource(bundle: R.hostingBundle, name: "tab_scancode")
    
    /// `UIImage(named: "background", bundle: ..., traitCollection: ...)`
    static func background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.background, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "img_close", bundle: ..., traitCollection: ...)`
    static func img_close(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_close, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "img_continue", bundle: ..., traitCollection: ...)`
    static func img_continue(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_continue, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "img_distance", bundle: ..., traitCollection: ...)`
    static func img_distance(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_distance, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "img_edit", bundle: ..., traitCollection: ...)`
    static func img_edit(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_edit, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "img_price", bundle: ..., traitCollection: ...)`
    static func img_price(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_price, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "img_scancode", bundle: ..., traitCollection: ...)`
    static func img_scancode(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_scancode, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "img_shop", bundle: ..., traitCollection: ...)`
    static func img_shop(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.img_shop, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "tab_scancode", bundle: ..., traitCollection: ...)`
    static func tab_scancode(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tab_scancode, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `ProductPricesTVC`.
    static let productPricesTVC: Rswift.ReuseIdentifier<ProductPricesTVC> = Rswift.ReuseIdentifier(identifier: "ProductPricesTVC")
    /// Reuse identifier `ProductSearchListCell`.
    static let productSearchListCell: Rswift.ReuseIdentifier<ProductSearchListCell> = Rswift.ReuseIdentifier(identifier: "ProductSearchListCell")
    /// Reuse identifier `ShopPriceTVC`.
    static let shopPriceTVC: Rswift.ReuseIdentifier<ShopPriceTVC> = Rswift.ReuseIdentifier(identifier: "ShopPriceTVC")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 4 view controllers.
  struct segue {
    /// This struct is generated for `ProductPricesPVC`, and contains static references to 1 segues.
    struct productPricesPVC {
      /// Segue identifier `ProductPricesSegue`.
      static let productPricesSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, ProductPricesPVC, ProductPricesContentVC> = Rswift.StoryboardSegueIdentifier(identifier: "ProductPricesSegue")
      
      /// Optionally returns a typed version of segue `ProductPricesSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func productPricesSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, ProductPricesPVC, ProductPricesContentVC>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.productPricesPVC.productPricesSegue, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `ProductSearchListPVC`, and contains static references to 1 segues.
    struct productSearchListPVC {
      /// Segue identifier `ProductSearchListContentSegue`.
      static let productSearchListContentSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, ProductSearchListPVC, ProductSearchListContentVC> = Rswift.StoryboardSegueIdentifier(identifier: "ProductSearchListContentSegue")
      
      /// Optionally returns a typed version of segue `ProductSearchListContentSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func productSearchListContentSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, ProductSearchListPVC, ProductSearchListContentVC>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.productSearchListPVC.productSearchListContentSegue, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `ShopPricePVC`, and contains static references to 1 segues.
    struct shopPricePVC {
      /// Segue identifier `ShopPriceSegue`.
      static let shopPriceSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, ShopPricePVC, ShopPriceContentVC> = Rswift.StoryboardSegueIdentifier(identifier: "ShopPriceSegue")
      
      /// Optionally returns a typed version of segue `ShopPriceSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func shopPriceSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, ShopPricePVC, ShopPriceContentVC>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.shopPricePVC.shopPriceSegue, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `StartScanningPVC`, and contains static references to 1 segues.
    struct startScanningPVC {
      /// Segue identifier `StartScanningContentSegue`.
      static let startScanningContentSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, StartScanningPVC, StartScanningContentVC> = Rswift.StoryboardSegueIdentifier(identifier: "StartScanningContentSegue")
      
      /// Optionally returns a typed version of segue `StartScanningContentSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func startScanningContentSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, StartScanningPVC, StartScanningContentVC>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.startScanningPVC.startScanningContentSegue, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    /// Storyboard `productList`.
    static let productList = _R.storyboard.productList()
    /// Storyboard `scanForPrice`.
    static let scanForPrice = _R.storyboard.scanForPrice()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    /// `UIStoryboard(name: "productList", bundle: ...)`
    static func productList(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.productList)
    }
    
    /// `UIStoryboard(name: "scanForPrice", bundle: ...)`
    static func scanForPrice(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.scanForPrice)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.launchScreen` struct is generated, and contains static references to 0 localization keys.
    struct launchScreen {
      fileprivate init() {}
    }
    
    /// This `R.string.localizable` struct is generated, and contains static references to 11 localization keys.
    struct localizable {
      /// en translation: %d prices found
      /// 
      /// Locales: en, es
      static let shop_price_prices_found = Rswift.StringResource(key: "shop_price_prices_found", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Distance
      /// 
      /// Locales: en, es
      static let product_prices_distance = Rswift.StringResource(key: "product_prices_distance", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Price
      /// 
      /// Locales: en, es
      static let product_prices_price = Rswift.StringResource(key: "product_prices_price", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Price?
      /// 
      /// Locales: en, es
      static let start_scanning_price_placeholder = Rswift.StringResource(key: "start_scanning_price_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Product search
      /// 
      /// Locales: en, es
      static let product_search_title = Rswift.StringResource(key: "product_search_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Product?
      /// 
      /// Locales: en, es
      static let start_scanning_product_placeholder = Rswift.StringResource(key: "start_scanning_product_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Scanning radious
      /// 
      /// Locales: en, es
      static let distance_selecgtor_title = Rswift.StringResource(key: "distance_selecgtor_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Shop price
      /// 
      /// Locales: en, es
      static let shop_price_title = Rswift.StringResource(key: "shop_price_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Shop?
      /// 
      /// Locales: en, es
      static let start_scanning_shop_placeholder = Rswift.StringResource(key: "start_scanning_shop_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Start scanning
      /// 
      /// Locales: en, es
      static let start_scanning_title = Rswift.StringResource(key: "start_scanning_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      /// en translation: Tap for start scanning a product barcode
      /// 
      /// Locales: en, es
      static let start_scanning_tap_start_scan = Rswift.StringResource(key: "start_scanning_tap_start_scan", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "es"], comment: nil)
      
      /// en translation: %d prices found
      /// 
      /// Locales: en, es
      static func shop_price_prices_found(_ value1: Int) -> String {
        return String(format: NSLocalizedString("shop_price_prices_found", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// en translation: Distance
      /// 
      /// Locales: en, es
      static func product_prices_distance(_: Void = ()) -> String {
        return NSLocalizedString("product_prices_distance", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Price
      /// 
      /// Locales: en, es
      static func product_prices_price(_: Void = ()) -> String {
        return NSLocalizedString("product_prices_price", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Price?
      /// 
      /// Locales: en, es
      static func start_scanning_price_placeholder(_: Void = ()) -> String {
        return NSLocalizedString("start_scanning_price_placeholder", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Product search
      /// 
      /// Locales: en, es
      static func product_search_title(_: Void = ()) -> String {
        return NSLocalizedString("product_search_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Product?
      /// 
      /// Locales: en, es
      static func start_scanning_product_placeholder(_: Void = ()) -> String {
        return NSLocalizedString("start_scanning_product_placeholder", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Scanning radious
      /// 
      /// Locales: en, es
      static func distance_selecgtor_title(_: Void = ()) -> String {
        return NSLocalizedString("distance_selecgtor_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Shop price
      /// 
      /// Locales: en, es
      static func shop_price_title(_: Void = ()) -> String {
        return NSLocalizedString("shop_price_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Shop?
      /// 
      /// Locales: en, es
      static func start_scanning_shop_placeholder(_: Void = ()) -> String {
        return NSLocalizedString("start_scanning_shop_placeholder", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Start scanning
      /// 
      /// Locales: en, es
      static func start_scanning_title(_: Void = ()) -> String {
        return NSLocalizedString("start_scanning_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// en translation: Tap for start scanning a product barcode
      /// 
      /// Locales: en, es
      static func start_scanning_tap_start_scan(_: Void = ()) -> String {
        return NSLocalizedString("start_scanning_tap_start_scan", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try scanForPrice.validate()
      try productList.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = SplashVC
      
      let bundle = R.hostingBundle
      let mainTabBarController = StoryboardViewControllerResource<MainTabBarController>(identifier: "MainTabBarController")
      let name = "Main"
      let splashVC = StoryboardViewControllerResource<SplashVC>(identifier: "SplashVC")
      
      func mainTabBarController(_: Void = ()) -> MainTabBarController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainTabBarController)
      }
      
      func splashVC(_: Void = ()) -> SplashVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: splashVC)
      }
      
      static func validate() throws {
        if _R.storyboard.main().mainTabBarController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainTabBarController' could not be loaded from storyboard 'Main' as 'MainTabBarController'.") }
        if _R.storyboard.main().splashVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'splashVC' could not be loaded from storyboard 'Main' as 'SplashVC'.") }
      }
      
      fileprivate init() {}
    }
    
    struct productList: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "productList"
      let productListNC = StoryboardViewControllerResource<ProductListNC>(identifier: "ProductListNC")
      let productSearchListPVC = StoryboardViewControllerResource<ProductSearchListPVC>(identifier: "ProductSearchListPVC")
      
      func productListNC(_: Void = ()) -> ProductListNC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: productListNC)
      }
      
      func productSearchListPVC(_: Void = ()) -> ProductSearchListPVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: productSearchListPVC)
      }
      
      static func validate() throws {
        if _R.storyboard.productList().productSearchListPVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'productSearchListPVC' could not be loaded from storyboard 'productList' as 'ProductSearchListPVC'.") }
        if _R.storyboard.productList().productListNC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'productListNC' could not be loaded from storyboard 'productList' as 'ProductListNC'.") }
      }
      
      fileprivate init() {}
    }
    
    struct scanForPrice: Rswift.StoryboardResourceType, Rswift.Validatable {
      let barcodeScannerPVC = StoryboardViewControllerResource<BarcodeScannerPVC>(identifier: "BarcodeScannerPVC")
      let bundle = R.hostingBundle
      let name = "scanForPrice"
      let productPricesPVC = StoryboardViewControllerResource<ProductPricesPVC>(identifier: "ProductPricesPVC")
      let scanForPriceNC = StoryboardViewControllerResource<ScanForPriceNC>(identifier: "ScanForPriceNC")
      let shopPricePVC = StoryboardViewControllerResource<ShopPricePVC>(identifier: "ShopPricePVC")
      let startScanningPVC = StoryboardViewControllerResource<StartScanningPVC>(identifier: "StartScanningPVC")
      
      func barcodeScannerPVC(_: Void = ()) -> BarcodeScannerPVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: barcodeScannerPVC)
      }
      
      func productPricesPVC(_: Void = ()) -> ProductPricesPVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: productPricesPVC)
      }
      
      func scanForPriceNC(_: Void = ()) -> ScanForPriceNC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: scanForPriceNC)
      }
      
      func shopPricePVC(_: Void = ()) -> ShopPricePVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: shopPricePVC)
      }
      
      func startScanningPVC(_: Void = ()) -> StartScanningPVC? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: startScanningPVC)
      }
      
      static func validate() throws {
        if _R.storyboard.scanForPrice().shopPricePVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'shopPricePVC' could not be loaded from storyboard 'scanForPrice' as 'ShopPricePVC'.") }
        if _R.storyboard.scanForPrice().productPricesPVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'productPricesPVC' could not be loaded from storyboard 'scanForPrice' as 'ProductPricesPVC'.") }
        if _R.storyboard.scanForPrice().scanForPriceNC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'scanForPriceNC' could not be loaded from storyboard 'scanForPrice' as 'ScanForPriceNC'.") }
        if _R.storyboard.scanForPrice().startScanningPVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'startScanningPVC' could not be loaded from storyboard 'scanForPrice' as 'StartScanningPVC'.") }
        if _R.storyboard.scanForPrice().barcodeScannerPVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'barcodeScannerPVC' could not be loaded from storyboard 'scanForPrice' as 'BarcodeScannerPVC'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
