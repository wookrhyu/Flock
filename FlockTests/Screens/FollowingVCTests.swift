//
//  FollowingVCTests.swift
//  FlockTests
//
//  Created by Wook Rhyu on 9/10/21.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import Flock

final class FollowingVCTests: XCTestCase {
    
    var sut: FollowingVC!
    
    func test_init() {
        
        sut = FollowingVC(coder: <#NSCoder#>)
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    
}
