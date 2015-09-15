//
//  NetworkResponse.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

enum NetworkResponseState {
    case NotSearchedYet
    case Loading
    case NoResults
    case Results
}

protocol NetworkResponseProtocol {
    
    var networkResponseState: NetworkResponseState { get }
    func parseJSON(data: NSData) -> [String: AnyObject]?
    
}

class NetworkResponse: NetworkResponseProtocol {
    
    var networkResponseState: NetworkResponseState = .Loading
    
    func parseJSON(data: NSData) -> [String: AnyObject]? {
        
        do {
            // Try parsing some valid JSON
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject]
            return json
        }
        catch let error as NSError {
            // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
            print("A JSON parsing error occurred, here are the details:\n \(error)")
        }
        
        return nil
    }
    
    func parseJSONArray(data: NSData) -> [[String: AnyObject]]? {
        
        do {
            // Try parsing some valid JSON
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue: 0)) as? [[String: AnyObject]]
            return json
        }
        catch let error as NSError {
            // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
            print("A JSON parsing error occurred, here are the details:\n \(error)")
        }
        
        return nil
    }
    
}