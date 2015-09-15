//
//  JsonModel.swift
//  Pods
//
//  Created by Armando Contreras on 9/15/15.
//
//

import Foundation

typealias JSONParameters = [String: AnyObject]

protocol JsonModel {
    func fromDictionary(dictionary: [String: AnyObject])
}