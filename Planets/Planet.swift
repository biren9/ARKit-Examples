//
//  Planet.swift
//
//  Created by Gil Biren on 09/04/2019.
//  Copyright © 2019 Gil Biren. All rights reserved.
//

import Foundation
import SceneKit

enum Planet: String {
    case sun
    case mercury
    case venus
    case earth
    case moon
    case mars
    
    static var eartScaledRadius: CGFloat = 0.2
    static var dayDurationFactor: TimeInterval = 3
    static var roundTripFactor: TimeInterval = 0.02
    private static let distanceFromParentScaleFactor: CGFloat = 0.5
    
    private var radius: CGFloat {
        switch self {
        case .sun:
            return Planet.eartScaledRadius * 2.5
        case .earth:
            return Planet.eartScaledRadius
        case .venus:
            return Planet.eartScaledRadius * 0.95
        case .moon:
            return Planet.eartScaledRadius * 0.26
        case .mercury:
            return Planet.eartScaledRadius * 0.38
        case .mars:
            return Planet.eartScaledRadius * 0.53
        }
    }
    
    private var roundTripTime: TimeInterval {
        switch self {
        case .sun:
            return 1
        case .earth:
            return 365 * Planet.roundTripFactor
        case .venus:
            return 224 * Planet.roundTripFactor
        case .moon:
            return 27 * Planet.roundTripFactor
        case .mercury:
            return 87.97 * Planet.roundTripFactor
        case .mars:
            return (365 * 1.88) * Planet.roundTripFactor
        }
    }
    
    private var dayDuration: TimeInterval {
        switch self {
        case .sun:
            return 25 * Planet.dayDurationFactor
        case .earth:
            return 1 * Planet.dayDurationFactor
        case .venus:
            return 243 * Planet.dayDurationFactor
        case .moon:
            return 27 * Planet.dayDurationFactor
        case .mercury:
            return 58 * Planet.dayDurationFactor
        case .mars:
            return 1.02 * Planet.dayDurationFactor
        }
    }
    
    var distanceFromParent: CGFloat {
        // 1 pro 50 Million KM
        switch self {
        case .sun:
            return 0 * Planet.distanceFromParentScaleFactor + radius
        case .earth:
            return 3 * Planet.distanceFromParentScaleFactor + radius
        case .venus:
            return 2.16 * Planet.distanceFromParentScaleFactor + radius
        case .moon:
            return 0.7 * Planet.distanceFromParentScaleFactor + radius
        case .mercury:
            return 1.16 * Planet.distanceFromParentScaleFactor + radius
        case .mars:
            return 4.54 * Planet.distanceFromParentScaleFactor + radius
        }
    }
    
    /* https://www.solarsystemscope.com/textures/ */
    private var textureDiffuse: UIImage {
        switch self {
        case .sun:
            return UIImage(named: "sunDiffuse")!
        case .earth:
            return UIImage(named: "earthDiffuse")!
        case .venus:
            return UIImage(named: "venusDiffuse")!
        case .moon:
            return UIImage(named: "moonDiffuse")!
        case .mercury:
            return UIImage(named: "mercuryDiffuse")!
        case .mars:
            return UIImage(named: "marsDiffuse")!
        }
    }
    
    private var textureEmission: UIImage? {
        switch self {
        case .earth:
            return UIImage(named: "earthEmission")!
        case .venus:
            return UIImage(named: "venusEmission")!
        default:
            return nil
        }
    }
    
    private var textureSpecular: UIImage? {
        switch self {
        case .earth:
            return UIImage(named: "earthSpecular")!
        default:
            return nil
        }
    }
    
    private var textureNormal: UIImage? {
        switch self {
        case .earth:
            return UIImage(named: "earthNormal")!
        default:
            return nil
        }
    }
    
    func node() -> SCNNode {
        let node = SCNNode()
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = textureDiffuse
        geometry.firstMaterial?.emission.contents = textureEmission
        geometry.firstMaterial?.specular.contents = textureSpecular
        geometry.firstMaterial?.normal.contents = textureNormal
        node.geometry = geometry
        node.name = rawValue
        
        return node
    }
    
    var rotationAroundOrigin: SCNAction {
        return SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 360.radians, z: 0, duration: roundTripTime))
    }
    
    var rotationAroundSelf: SCNAction {
        return SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 360.radians, z: 0, duration: dayDuration))
    }
}
