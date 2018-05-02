//
//  PresentMainAppOperation.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation
import UIKit

class PresentMainAppOperation: ConcurrentOperation {

    override init() {
        super.init()
    }

    override func main() {
        DispatchQueue.main.async {

            ScanForPriceCoordinator.shared.start()

            self.state = .Finished
        }
    }
}
