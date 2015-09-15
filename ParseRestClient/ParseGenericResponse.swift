//
//  ParseGenericResponse.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

class ParseGenericResponse<T: ParseModelProtocol> {
    
    var response = [T]()
    
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
    
    func getJsonModel(dictionary: [String: AnyObject]) -> T? {
        let parseModel = T(dictionary: dictionary)
        return parseModel
    }
    
    func parseDictionary(data: NSData) {
        
        if let dictionary = self.parseJSON(data) {
            
            let parseArray = dictionary["results"] as! [JSONParameters]?
            
            if let parseList = parseArray {
                for item in parseList {
                    let parsedItem = self.getJsonModel(item)
                    if let result = parsedItem {
                        self.response.append(result)
                    }
                }
            }
            
        } else {
            print("Expected a dictionary")
        }
        
        
    }
    
    func getData() -> [T] {
        return response
    }
    
}