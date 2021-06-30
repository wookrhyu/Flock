//
//  FError.swift
//  Flock
//
//  Created by Wook Rhyu on 6/15/21.
//

import Foundation

enum FError: String, Error {
    
    case invalidHandle = "This is an invalid handle. Please try again"
    case networkError  = "There was a problem getting the data. Please try again"
}
