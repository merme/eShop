//
//  LocaleManager.swift
//  eShop
//
//  Created by 08APO0516 on 27/05/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit

class LocaleManager: NSObject {
    
    static let sharedInstance = LocaleManager()
    
    var availableLocales:[String] = ["en", "es"]
    var lprojBasePath = "en"
    
    var bundle:Bundle!
    
    // MARK: - Private attributes
    let defaultIOSLanguage = "en"
    
    override fileprivate init() {
    }
    
    func reset() {
        lprojBasePath = "en"
        self.set()
    }
    
    func getSelectedLocale() -> String {
        
        let lang = Locale.preferredLanguages//returns array of preferred languages
        let languageComponents: [String : String] = Locale.components(fromIdentifier: lang[0])
        if let countryCode = languageComponents["kCFLocaleCountryCodeKey"],
            let languageCode: String = languageComponents["kCFLocaleLanguageCodeKey"] {
            let langCountryCode =  "\(languageCode)-\(countryCode)"
            return  (availableLocales.contains(langCountryCode)) ? langCountryCode : defaultIOSLanguage//"en"
        } else if let languageCode: String = languageComponents["kCFLocaleLanguageCodeKey"] {
            return  (availableLocales.contains(languageCode)) ? languageCode : defaultIOSLanguage//"en"
        }
        return defaultIOSLanguage//"en"
    }
    
    func getCurrentBundle() -> Bundle? {
        
        if let bundle = Bundle.main.path(forResource: lprojBasePath, ofType: "lproj") {
            return Bundle(path: bundle)!
        } else if let bundle = Bundle.main.path(forResource: "en", ofType: "lproj") {
            return Bundle(path: bundle)!
        }
        return nil
    }
    
    func getDeviceCountry() -> String? {
        if let _deviceCountryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            return _deviceCountryCode//self._deviceCountryToLocale(deviceCountry: _countryCode)
        }
        
        return nil
    }
    /*
    func existsMarketForDeviceLocale() -> Bool {
        guard let _deviceCountryCode = self.getDeviceCountry(),
            let _country = Country(deviceCountry: _deviceCountryCode) else {
                return false
        }
        
        return availableLocales.contains(_country.iOSLanguageCode())//self._deviceCountryToLocale(deviceCountry: _countryCode))
    }
    */
    @discardableResult func set(_ iOSLanguageCode:String? = nil) -> Bool {
        
        var _iOSLanguageCode = defaultIOSLanguage
        if iOSLanguageCode != nil {
            _iOSLanguageCode = iOSLanguageCode!
        }
        
        UserDefaults.standard.set([_iOSLanguageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        self.lprojBasePath =  getSelectedLocale()
        
        //print("\( getSelectedLocale())")
        self.bundle = getCurrentBundle()
        
        let index = _iOSLanguageCode.index(_iOSLanguageCode.endIndex, offsetBy: -2)
        let country = String(_iOSLanguageCode[index...])
        
        return self.bundle != nil && self.lprojBasePath == _iOSLanguageCode
    }
}

/*
 extension String {
 var localized: String {
 
 if let _bundle = LocaleManager.sharedInstance.getCurrentBundle() {
 return NSLocalizedString(self,
 tableName: nil,
 bundle: _bundle,
 value: "",
 comment: "")
 } else {
 return ""
 }
 
 }
 }*/

