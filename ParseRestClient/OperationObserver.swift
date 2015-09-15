//
//  OperationObserver.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

protocol OperationObserver {
    
    /// Invoked immediately prior to the `Operation`'s `execute()` method.
    func operationDidStart(operation: Operation)
    
    /// Invoked when `Operation.produceOperation(_:)` is executed.
    func operation(operation: Operation, didProduceOperation newOperation: NSOperation)
    
    /**
    Invoked as an `Operation` finishes, along with any errors produced during
    execution (or readiness evaluation).
    */
    func operationDidFinish(operation: Operation, errors: [NSError])
    
}