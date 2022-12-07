//
//  IngredientsModel.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 06/12/22.
//

import Foundation

struct Ingredient : Identifiable{
    var id = UUID()
    var ingredientName : String
    var imgName : String
    var sfx : String
    var haptic : String
    
}


var tomato = Ingredient(ingredientName: "TOMATO",imgName: "tomato0", sfx: "tomato", haptic: "tomato")
var basil = Ingredient(ingredientName: "BASIL", imgName: "basil0", sfx: "basil", haptic: "basil")
var oliveOil  = Ingredient(ingredientName:"OLIVE OIL",imgName: "oil0", sfx: "oil", haptic: "oil")
var mozza  = Ingredient(ingredientName:"MOZZARELLA",imgName: "mozza0", sfx: "mozza", haptic: "mozza")

var pizza = [tomato,oliveOil,basil,mozza]
