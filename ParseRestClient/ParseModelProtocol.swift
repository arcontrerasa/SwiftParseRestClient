//
//  ParseModelProtocol.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

protocol ParseModelProtocol:JsonModel {
    init(dictionary: [String: AnyObject])
    func fromDictionary(dictionary: [String: AnyObject])
}
