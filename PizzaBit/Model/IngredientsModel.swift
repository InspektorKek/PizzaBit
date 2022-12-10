//
//  IngredientsModel.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 06/12/22.
//

import Foundation
import SpriteKit

struct Ingredient : Identifiable{
    var id = UUID()
    var ingredientName : String
    var imgName : String
    var sfx : String
    var haptic : String
    var scene : IngredientScene
    
}


var tomato = Ingredient(ingredientName: "Tomato",imgName: "0tomato", sfx: "tomato", haptic: "tomato", scene: tomatoSprite)
var basil = Ingredient(ingredientName: "Basil", imgName: "0basil", sfx: "basil", haptic: "basil", scene: basilSprite)
var oliveOil  = Ingredient(ingredientName:"Oil",imgName: "0oil", sfx: "oil", haptic: "oil", scene: oilSprite)
var mozza  = Ingredient(ingredientName:"Mozzarella",imgName: "0mozza", sfx: "mozza", haptic: "mozza", scene: mozzaSprite)

var pizza = [tomato,oliveOil,basil,mozza]


class IngredientScene: SKScene {
    var ingredientName : String = ""
    
    private var ingredient = SKSpriteNode()
    
    private var ingredientFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        buildIngredient()
        animateIngredient()
    }
    
    
     func buildIngredient() {
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
        if(ingredientName == "tomato"){
            ingredient.run(SKAction.repeatForever(SKAction.animate(with: ingredientFrames, timePerFrame: 0.24)),
                     withKey:"tomatoKey")
        }else if(ingredientName == "oil"){
            ingredient.run(SKAction.repeatForever(SKAction.animate(with: ingredientFrames, timePerFrame: 0.21)),
                     withKey:"oilKey")
        }else if(ingredientName == "basil"){
            ingredient.run(SKAction.repeatForever(SKAction.animate(with: ingredientFrames, timePerFrame: 0.08)),
                         withKey:"basilKey")
        }else if(ingredientName == "mozzarella"){
            ingredient.run(SKAction.repeatForever(SKAction.animate(with: ingredientFrames, timePerFrame: 0.22)),
                         withKey:"mozzaKey")
        } else{
            ingredient.run(SKAction.repeatForever(SKAction.animate(with: ingredientFrames, timePerFrame: 1.2)),
                           withKey:"miniChef")
        }
       
    }
    
    func copyIngredientScene() -> IngredientScene {
        let ingredient = IngredientScene()
        ingredient.ingredientName = ingredientName
        return ingredient
    }
}

//  Setting Ingredients
var ingredientScene = IngredientScene()
var tomatoSprite = ingredientScene.copyIngredientScene()
var oilSprite = ingredientScene.copyIngredientScene()
var basilSprite = ingredientScene.copyIngredientScene()
var mozzaSprite = ingredientScene.copyIngredientScene()

// Setiing MiniChef
var miniChefSprite = ingredientScene.copyIngredientScene()

//var garniture = [tomatoSprite,oilSprite,basilSprite,mozzaSprite]
