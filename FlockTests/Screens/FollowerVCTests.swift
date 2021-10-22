//
//  FollowerVCTests.swift
//  FlockTests
//
//  Created by Wook Rhyu on 9/10/21.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import Flock

final class FollowerVCTests: XCTestCase {
    
    var sut: FollowerVC!
    
    func test_init() {
        
        sut = FollowerVC()
        
        assertSnapshot(matching: sut, as: .image)
    }
}
