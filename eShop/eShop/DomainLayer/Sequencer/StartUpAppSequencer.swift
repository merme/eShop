//
//  StartUpAppSequencer.swift
//  iMug
//
//  Copyright © 2017 Nestlé S.A. All rights reserved.
//

import Foundation
import UIKit

class  StartUpAppSequencer {

    static let shared =  StartUpAppSequencer()

    fileprivate let operationQueue = OperationQueue()

    private init() {} //This prevents others from using the default '()' initializer for this class.

    func start() {

        let presentMainAppOperation = PresentMainAppOperation()

        let operations = [presentMainAppOperation]

        // Add operation dependencies
        //presentMainAppOperation.addDependency(fetchFirstMachineOperation)

        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
}
