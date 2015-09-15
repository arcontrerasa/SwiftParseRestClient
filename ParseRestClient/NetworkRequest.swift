//
//  NetworkRequest.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

protocol NetworkRequest {
    
    var parseConfig: ParseConfig { get }
    
    init(config: ParseConfig)
    
    func createRequest() -> NSURLRequest
    
}
