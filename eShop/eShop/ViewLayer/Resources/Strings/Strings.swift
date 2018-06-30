//
//  String.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation
import UIKit

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
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(paramTo: Int) -> String {
        let toIndex = index(from: paramTo)
        return String(self[..<toIndex])
    }
    
    func substring(with paramR: Range<Int>) -> String {
        let startIndex = index(from: paramR.lowerBound)
        let endIndex = index(from: paramR.upperBound)
        let range = startIndex..<endIndex
        return String(self[range])
    }
    
    func base64Decoded() -> String? {
        
        let remainder = self.count % 4
        var padded = self
        if remainder > 0 {
            padded = self.padding(toLength: self.count + 4 - remainder,
                                  withPad: "=",
                                  startingAt: 0)
        }
        
        if let decodedData = NSData(base64Encoded: padded, options:NSData.Base64DecodingOptions(rawValue: 0)),
            let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue) {
            return decodedString as String
        }
        
        return nil
    }
    
    func toDictionary() -> [String:AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}

