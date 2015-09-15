//
//  HttpHelper.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

enum HTTPRequestAuthType {
    case HTTPBasicAuth
    case HTTPTokenAuth
}

enum HTTPRequestContentType {
    case HTTPJsonContent
    case HTTPMultipartContent
}

struct HTTPHelper {
    
    func sendRequest(request: NSURLRequest, completion:(NSData!, NSError!) -> Void) -> () {
        // Create a NSURLSession task
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data: NSData?,  response: NSURLResponse?, error: NSError?) in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(data, error)
                })
                
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                        completion(data, nil)
                    } else {
                        let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: nil)
                        completion(data, responseError)
                    }
                }
            })
        }
        
        // start the task
        task.resume()
    }
    
    func getErrorMessage(error: NSError) -> NSString {
        var errorMessage : NSString
        
        // return correct error message
        if error.domain == "HTTPHelperError" {
            let userInfo = error.userInfo as NSDictionary!
            errorMessage = userInfo.valueForKey("message") as! NSString
        } else {
            errorMessage = error.description
        }
        
        return errorMessage
    }
}