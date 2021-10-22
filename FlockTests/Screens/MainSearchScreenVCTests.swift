//
//  MainSearchScreenVCTests.swift
//  FlockTests
//
//  Created by Wook Rhyu on 8/9/21.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import Flock

final class MainSearchScreenVCTests: XCTestCase {
    
    var sut: MainSearchScreenVC!
    
    func test_init() {
        
        sut = MainSearchScreenVC()
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    
}
