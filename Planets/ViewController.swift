//
//  ViewController.swift
//  Planets
//
//  Created by Gil Biren on 09/04/2019.
//  Copyright © 2019 Gil Biren. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    private lazy var sceneView: ARSCNView = {
       let scn = ARSCNView()
        return scn
    }()
    private let configuration = ARWorldTrackingConfiguration()
    private var planets: [Planet: SCNNode] = [:]
    
    override func loadView() {
        view = sceneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        setupPlanets()
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(userPinched))
        sceneView.addGestureRecognizer(pinch)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(userTap))
        tap.numberOfTapsRequired = 2
        sceneView.addGestureRecognizer(tap)
    }
    
    @objc func userPinched(_ sender: UIPinchGestureRecognizer) {
        let newScale = max(min(sender.scale/10, 1), 0.01)
        if abs(newScale - Planet.eartScaledRadius) > 0.05 {
            Planet.eartScaledRadius = newScale
            setupPlanets()
        }
    }
    
    @objc func userTap(_ sender: UITapGestureRecognizer) {
        Planet.roundTripFactor = Planet.roundTripFactor*2
        Planet.dayDurationFactor = Planet.dayDurationFactor*2
        setupPlanets()
    }
    
    private func setupPlanets() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeAllActions()
            node.removeFromParentNode()
        }
        let origin = SCNVector3(0, -1, -2)
        let sunNode = Planet.sun.node()
        planets[.sun] = sunNode
        sunNode.position = origin
        sunNode.runAction(Planet.sun.rotationAroundOrigin)
        sceneView.scene.rootNode.addChildNode(sunNode)

        let mercury = create(planet: .mercury, origin: origin)
        sceneView.scene.rootNode.addChildNode(mercury)
        
        let venus = create(planet: .venus, origin: origin)
        sceneView.scene.rootNode.addChildNode(venus)
        
        let earth = create(planet: .earth, origin: origin)
        sceneView.scene.rootNode.addChildNode(earth)
        
        let moon  = create(planet: .moon)
        planets[.earth]?.addChildNode(moon)
        
        let mars = create(planet: .mars, origin: origin)
        sceneView.scene.rootNode.addChildNode(mars)

    }
    
    private func create(planet: Planet, origin: SCNVector3 = .zero) -> SCNNode {
        let parentNode = SCNNode()
        parentNode.position = origin
        parentNode.runAction(planet.rotationAroundOrigin)
        let node = planet.node()
        node.position = SCNVector3(0, 0, -planet.distanceFromParent)
        node.runAction(planet.rotationAroundSelf)
        parentNode.addChildNode(node)
        planets[planet] = node
        return parentNode
    }

}
