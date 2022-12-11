//
//  SceneFabric.swift
//  PizzaBit
//
//  Created by Mikhail Borisov on 11/12/22.
//

import SpriteKit

final class SceneFabric {
    static var shared = SceneFabric()
    
    private init() {}
    
    let miniChefScene = ChefScene()
}

