//
//  ParseConfig.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

struct ParseConfig {
    
    let parseRestKey: String
    let parseApplicationId: String
    let urlString: String
    
    init(parseRestKey: String, parseApplicationId: String, urlString: String) {
        self.parseRestKey = parseRestKey
        self.parseApplicationId = parseApplicationId
        self.urlString = urlString
    }
    
    static let RestApiKeyHeaderField = "X-Parse-REST-API-Key"
    static let ApplicationIdHeaderField = "X-Parse-Application-Id"

    static let TokenHeaderField = "X-Parse-Session-Token";
    static let ParseApiUrl = "https://api.parse.com/"

}