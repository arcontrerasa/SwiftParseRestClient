//
//  ParseGenericOperation.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

class ParseGenericOperation<T: ParseModelProtocol>: Operation {
    
    let operationWrapper: ParseOperationWrapper<T>
    
    init(operationWrapper: ParseOperationWrapper<T>) {
        self.operationWrapper = operationWrapper
    }
    
    override func main() {
        
        let request = operationWrapper.parseRequest.createRequest()
        
        operationWrapper.httpHelper.sendRequest(request, completion: {(data:NSData!, error:NSError!) in
            // Display error
            
            if let error = error {
                if error.code == -999 { return }
                
            } else if let resData = data {
                self.operationWrapper.getResponse().parseDictionary(resData)
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.operationWrapper.notifyCompletion()
                self.finish()
            }
        })
        
        
    }
    
}