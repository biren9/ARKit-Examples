//
//  ARExtensions.swift
//
//  Created by Gil Biren on 09/04/2019.
//  Copyright © 2019 Gil Biren. All rights reserved.
//

import Foundation
import ARKit

extension SCNVector3 {
    static func + (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    
    static var zero: SCNVector3 { return SCNVector3(0, 0, 0) }
}

extension CGFloat {
    var radians: CGFloat {
        return self * .pi / 180
    }
}

extension Int {
    var radians: CGFloat {
        return CGFloat(self).radians
    }
}
