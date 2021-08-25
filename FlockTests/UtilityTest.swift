//
//  UtilityTest.swift
//  FlockTests
//
//  Created by Wook Rhyu on 8/9/21.
//

import Foundation
import XCTest

@testable import Flock


final class UtilityTest: XCTestCase {
    
    var sut: Utility!

    func test_isValidEmail(){
        
        sut = Utility()
        
        XCTAssert(sut.isValidEmail(email: "rhyu.wook@gmail.com"))
        XCTAssertFalse(sut.isValidEmail(email: "rhyu.wook@"))
        XCTAssertFalse(sut.isValidEmail(email: "         @"))
        
        
    }
    
    
}
