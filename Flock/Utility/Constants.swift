//
//  Constants.swift
//  Flock
//
//  Created by Wook Rhyu on 6/2/21.
//

import UIKit

enum Images{
    static let logo = UIImage(named: "main-logo")
    static let birds = UIImage(named: "flock")
    static let logoBird = UIImage(named: "birds")
}

enum Colors {
    static let darkGreyBlue = UIColor.init(red: 51/255, green: 66/255, blue: 87/255, alpha: 1)
    static let greyBlue = UIColor.init(red: 71/255, green: 96/255, blue: 144/255, alpha: 1)
    static let lightGreyBlue = UIColor.init(red: 84/255, green: 140/255, blue: 168/255, alpha: 1)
    static let background = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
}

enum SFSymbols {
    static let person = UIImage(systemName: "person.2.fill")
    static let back = UIImage(systemName: "arrow.backward")
}

struct Utility{
    
    func isValidEmail(email: String) -> Bool {
        
        if email.contains("@") {
            return true
        }
        return false
    }
    
}
