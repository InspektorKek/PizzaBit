//
//  ChefScene.swift
//  PizzaBit
//
//  Created by Mikhail Borisov on 11/12/22.
//

import SpriteKit

class ChefScene: SKScene {
    private var ingredient = SKSpriteNode()
    private var ingredientFrames: [SKTexture] = []
    
    var textureName: String { "MiniChef" }
    
    override func didMove(to view: SKView) {
        animateIngredient()
    }
    
    override init() {
        super.init(size: CGSize(width: 512, height: 512))
        buildIngredient()
        backgroundColor = .clear
        scaleMode = .aspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildIngredient() {
        let ingredientAnimatedAtlas = SKTextureAtlas(named: textureName)
        var ingredientBufferFrames: [SKTexture] = []
        
        let numImages = ingredientAnimatedAtlas.textureNames.count
        for i in 1..<numImages+1 {
            let ingredientTextureName = "\(textureName)\(i)"
            ingredientBufferFrames.append(ingredientAnimatedAtlas.textureNamed(ingredientTextureName))
        }
        ingredientFrames = ingredientBufferFrames
        
        let firstFrameTexture = ingredientFrames[1]
        ingredient = SKSpriteNode(texture: firstFrameTexture)
        ingredient.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(ingredient)
    }
    
    func animateIngredient() {
        ingredient.run(SKAction.repeatForever(SKAction.animate(with: ingredientFrames, timePerFrame: 0.18)),
                           withKey: textureName)
    }
}

