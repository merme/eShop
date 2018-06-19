//
//  String.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    
    func formatDist() -> String {
        
        if self < 1000 {
            return "\(String(self)) m"
        } else if self >= 1000 && self < 10000 {
            let i:Double = Double(self) / 1000.0
            return "\(String(format: "%.1f", i)) Km"
        } else {
            return "\(String(self / 1000)) Km"
        }
    }
    
}

