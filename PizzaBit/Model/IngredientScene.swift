//
//  IngredientScene.swift
//  PizzaBit
//
//  Created by Mikhail Borisov on 11/12/22.
//

import SpriteKit

class IngredientScene: SKScene {
    let ingredientKind: Ingredient.Kind
    
    var ingredientName: String { ingredientKind.name }
    private var ingredient = SKSpriteNode()
    
    private var ingredientFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        animateIngredient()
    }
    
    init(ingredientKind: Ingredient.Kind) {
        self.ingredientKind = ingredientKind
        super.init(size: CGSize(width: ingredientKind.size, height: ingredientKind.size))
        buildIngredient()
        backgroundColor = .clear
        scaleMode = .aspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildIngredient() {
        let ingredientAnimatedAtlas = SKTextureAtlas(named: ingredientName)
        var ingredientBufferFrames: [SKTexture] = []
        
        let numImages = ingredientAnimatedAtlas.textureNames.count
        for i in 1..<numImages+1 {
            let ingredientTextureName = "\(ingredientName)\(i)"
            ingredientBufferFrames.append(ingredientAnimatedAtlas.textureNamed(ingredientTextureName))
        }
        ingredientFrames = ingredientBufferFrames
        
        let firstFrameTexture = ingredientFrames[1]
        ingredient = SKSpriteNode(texture: firstFrameTexture)
        ingredient.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(ingredient)
    }
    
    func animateIngredient() {
        let animaton = SKAction.animate(with: ingredientFrames, timePerFrame: ingredientKind.timePerFrame)
        ingredient.run(SKAction.repeatForever(animaton), withKey: "\(ingredientKind.rawValue)key")
    }
}
