//
//  Operation.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

import UIKit

class Operation: NSOperation {
    
    // use the KVO mechanism to indicate that changes to "state" affect other properties as well
    class func keyPathsForValuesAffectingIsReady() -> Set<NSObject> {
        return ["state"]
    }
    
    class func keyPathsForValuesAffectingIsExecuting() -> Set<NSObject> {
        return ["state"]
    }
    
    class func keyPathsForValuesAffectingIsFinished() -> Set<NSObject> {
        return ["state"]
    }
    
    class func keyPathsForValuesAffectingIsCancelled() -> Set<NSObject> {
        return ["state"]
    }
    
    // MARK: State Management
    
    private enum State: Int, Comparable {
        /// The initial state of an `Operation`.
        case Initialized
        
        /// The `Operation` is ready to begin evaluating conditions.
        case Pending
        
        /// The `Operation` is evaluating conditions.
        case EvaluatingConditions
        
        /**
        The `Operation`'s conditions have all been satisfied, and it is ready
        to execute.
        */
        case Ready
        
        /// The `Operation` is executing.
        case Executing
        
        /**
        Execution of the `Operation` has finished, but it has not yet notified
        the queue of this.
        */
        case Finishing
        
        /// The `Operation` has finished executing.
        case Finished
        
        /// The `Operation` has been cancelled.
        case Cancelled
    }
    
    func execute() {
        print("\(self.dynamicType) must override `execute()`.")
        
        finish()
    }
    
    /**
    Indicates that the Operation can now begin to evaluate readiness conditions,
    if appropriate.
    */
    func willEnqueue() {
        state = .Pending
    }
    
    /// Private storage for the `state` property that will be KVO observed.
    private var _state = State.Initialized
    
    private var state: State {
        get {
            return _state
        }
        
        set(newState) {
            // Manually fire the KVO notifications for state change, since this is "private".
            
            willChangeValueForKey("state")
            
            switch (_state, newState) {
            case (.Cancelled, _):
                break // cannot leave the cancelled state
            case (.Finished, _):
                break // cannot leave the finished state
            default:
                assert(_state != newState, "Performing invalid cyclic state transition.")
                _state = newState
            }
            
            didChangeValueForKey("state")
        }
    }
    
    private var _internalErrors = [NSError]()
    
    override func cancel() {
        cancelWithError()
    }
    
    func cancelWithError(error: NSError? = nil) {
        if let error = error {
            _internalErrors.append(error)
        }
        
        state = .Cancelled
    }
    
    private(set) var observers = [OperationObserver]()
    
    func addObserver(observer: OperationObserver) {
        assert(state < .Executing, "Cannot modify observers after execution has begun.")
        
        observers.append(observer)
    }

    private var hasFinishedAlready = false
    final func finish(errors: [NSError] = []) {
        if !hasFinishedAlready {
            hasFinishedAlready = true
            state = .Finishing
            
            state = .Finished
        }
    }
    
}

// Simple operator functions to simplify the assertions used above.
private func <(lhs: Operation.State, rhs: Operation.State) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

private func ==(lhs: Operation.State, rhs: Operation.State) -> Bool {
    return lhs.rawValue == rhs.rawValue
}