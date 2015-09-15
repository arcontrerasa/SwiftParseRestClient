//
//  ParseOperationWrapper.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

class ParseOperationWrapper< T: ParseModelProtocol> {
    
    let parseRequest: ParseRequest
    let httpHelper = HTTPHelper()
    var response: ParseGenericResponse<T>
    var completionHandler: [T]? -> Void
    
    init(response: ParseGenericResponse<T>, request: ParseRequest, completionHandler: [T]?-> Void) {
        self.response = response
        self.parseRequest = request
        self.completionHandler = completionHandler
    }
    
    func getRequest() -> ParseRequest {
        return parseRequest
    }
    
    func getHttpHelper() -> HTTPHelper {
        return httpHelper
    }
    
    func getResponse() -> ParseGenericResponse<T> {
        return response
    }
    
    
    func notifyCompletion(){
        return self.completionHandler(getResponse().getData())
    }
    
}