//
//  PlanetsTests.swift
//  PlanetsTests
//
//  Created by Gil Biren on 25/04/2019.
//  Copyright © 2019 Rayan Slim. All rights reserved.
//

import XCTest
@testable import Planets

class PlanetsTests: XCTestCase {

    func testExample() {
        let sun = Planet.sun
        XCTAssert(sun.distanceFromParent == 0.5, "NOPE")
    }

}
