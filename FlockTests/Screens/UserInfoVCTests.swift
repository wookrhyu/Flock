//
//  UserInfoVCTests.swift
//  FlockTests
//
//  Created by Wook Rhyu on 9/10/21.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import Flock

final class UserInfoVCTests: XCTestCase {
    
    var sut: UserInfoVC!
    
    func test_init() {
        
        sut = UserInfoVC()
        
        assertSnapshot(matching: sut, as: .image)
    }
}
