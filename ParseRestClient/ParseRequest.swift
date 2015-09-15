//
//  ParseRequest.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

struct ParseRequest: NetworkRequest {
    
    let parseConfig: ParseConfig
    
    init(config: ParseConfig) {
        self.parseConfig = config
    }
    
    func createRequest() -> NSURLRequest {
        
        let url: NSURL = NSURL(string: self.parseConfig.urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(parseConfig.parseRestKey, forHTTPHeaderField: ParseConfig.RestApiKeyHeaderField)
        request.addValue(parseConfig.parseApplicationId, forHTTPHeaderField: ParseConfig.ApplicationIdHeaderField)
        if let token = getAuthToken() {
            request.addValue(token, forHTTPHeaderField: ParseConfig.TokenHeaderField)
            
        }
        
        return request
    }
    
    func createRequest(token:String) -> NSURLRequest {
        
        let url: NSURL = NSURL(string: self.parseConfig.urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(parseConfig.parseRestKey, forHTTPHeaderField: ParseConfig.RestApiKeyHeaderField)
        request.addValue(parseConfig.parseApplicationId, forHTTPHeaderField: ParseConfig.ApplicationIdHeaderField)
        print("createRequest \(token)")
        request.addValue(token, forHTTPHeaderField: ParseConfig.TokenHeaderField)
        
        
        return request
    }
    
    func createPutRequest(dict: [String:AnyObject]) -> NSURLRequest {
        
        let url: NSURL = NSURL(string: self.parseConfig.urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(parseConfig.parseRestKey, forHTTPHeaderField: ParseConfig.RestApiKeyHeaderField)
        request.addValue(parseConfig.parseApplicationId, forHTTPHeaderField: ParseConfig.ApplicationIdHeaderField)
        if let token = getAuthToken() {
            request.addValue(token, forHTTPHeaderField: ParseConfig.TokenHeaderField)
            
        }
        
        do {
            request.HTTPBody =  try NSJSONSerialization.dataWithJSONObject(dict, options: [])
        } catch let error as NSError  {
            print("put request error \(error)")
        }
        return request
    }
    
    func createPostRequest(data: NSData) -> NSURLRequest {
        
        let url: NSURL = NSURL(string: self.parseConfig.urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(parseConfig.parseRestKey, forHTTPHeaderField: ParseConfig.RestApiKeyHeaderField)
        request.addValue(parseConfig.parseApplicationId, forHTTPHeaderField: ParseConfig.ApplicationIdHeaderField)
        if let token = getAuthToken() {
             request.addValue(token, forHTTPHeaderField: ParseConfig.TokenHeaderField)
            
        }
        
        return request
        
    }
    
    func createPostRequest(dict: [String:AnyObject]) -> NSURLRequest {
        
        let url: NSURL = NSURL(string: self.parseConfig.urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(parseConfig.parseRestKey, forHTTPHeaderField: ParseConfig.RestApiKeyHeaderField)
        request.addValue(parseConfig.parseApplicationId, forHTTPHeaderField: ParseConfig.ApplicationIdHeaderField)
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(dict, options: [])
        } catch let error as NSError {
            print("put request error \(error)")
        }
        
        return request
    }
    
    func createFileUploadRequest(data: NSData, contentType: String) -> NSURLRequest {
        
        let url: NSURL = NSURL(string: self.parseConfig.urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "POST"
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.addValue(parseConfig.parseRestKey, forHTTPHeaderField: ParseConfig.RestApiKeyHeaderField)
        request.addValue(parseConfig.parseApplicationId, forHTTPHeaderField: ParseConfig.ApplicationIdHeaderField)
        request.HTTPBody = data
        return request
    }
    
    func getAuthToken() -> String? {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("authToken")
        {
            return name
        }
        
        return nil
    }
    
}