//
//  IngredientsModel.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 06/12/22.
//

import Foundation

struct Ingredient: Identifiable {
    var id = UUID()
    var type: Kind
    var scene: IngredientScene
    
    var imgName: String { "0" + type.rawValue }
    var sfx: String { type.rawValue }
    var haptic: String { type.rawValue }
    
    enum Kind: String, CaseIterable {
        case tomato
        case basil
        case oil
        case mozzarella
        
        var name: String { rawValue.capitalized }
        var timePerFrame: Double {
            switch self {
            case .tomato:
                return 0.08
            case .basil:
                return 0.04
            case .oil:
                return 0.21
            case .mozzarella:
                return 0.15
            }
        }
        
        var size: CGFloat {
            switch self {
            case .mozzarella, .tomato:
                return 32
            case .basil:
                return 64
            case .oil:
                return 128
            }
        }
    }
}

//var garniture = [tomatoSprite,oilSprite,basilSprite,mozzaSprite]
