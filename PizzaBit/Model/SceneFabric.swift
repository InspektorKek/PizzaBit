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
    var theGameSceneEasy = GameScene(music: "Pizza_Easy", beat: [0.6667 * 2], bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: 600, height: 200))
    var theGameSceneNormal = GameScene(music: "Pizza_Medium", beat: [0.5 * 2], bar: 2, level_multiplier: 2,size: CGSize(width: 600, height: 200))
    var theGameSceneHard = GameScene(music: "PERFECTIONIST", beat: [0.4], bar: 1.6, level_multiplier: 3,size: CGSize(width: 600, height: 200))
}

