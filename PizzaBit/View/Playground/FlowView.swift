//
//  FlowView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 09/12/22.
//

import SwiftUI
import SpriteKit

struct FlowView: View {
    @EnvironmentObject var audioManager : AudioManager
    var body: some View {
        // Flow where ingredients run
        ZStack {
            
            HStack {
                Spacer()
                Image("flow")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                    .frame(width: 990,height: 0)
            }.offset(y: 8)
            
            ZStack {
                
                HStack {
                    ZStack {
                        
                        HomeMadeTimelapseView()
                            .environmentObject(audioManager)
                            .frame(width: 380,height: 20)
                    }
                    .offset(x: 90,y: -103)
                }
                
                Image("timelapse")
                    .resizable()
                    .padding(.bottom,40)
                
            }
            
            StreamingIngredientGrid()
                .padding(.bottom,32)
            
        }
    }
    
    
}


// To be defined
struct StreamingIngredientGrid : View {
    var body: some View {
        let rows : [GridItem] = [GridItem(spacing: 10.0, alignment: .center)]
        
        HStack {
            
            //MARK: Replace with the Chef Sprite
            SpriteView(scene : oliveOil.scene , options: [.allowsTransparency])
                .ignoresSafeArea()
                .frame(width: 70, height: 100)
                .onAppear{
                    oliveOil.scene.size = CGSize(width: 128, height: 128)
                    oliveOil.scene.backgroundColor = .clear
                    oliveOil.scene.scaleMode = .fill
                    oliveOil.scene.ingredientName = oliveOil.ingredientName
                }
            
            LazyHGrid(rows: rows) {
                
                ForEach(0..<3){ _ in
                    ForEach(pizza.shuffled()){ ing in
                        ForEach(0..<1){ _ in
                            let square = ing.ingredientName == "Oil" ? 128 :  ing.ingredientName == "Basil" ? 64 : 32
                            
                            SpriteView(scene : ing.scene , options: [.allowsTransparency])
                                .ignoresSafeArea()
                                .frame(width: 64, height: 64)
                                .onAppear{
                                    ing.scene.size = CGSize(width: square, height: square)
                                    ing.scene.backgroundColor = .clear
                                    ing.scene.scaleMode = .fill
                                    ing.scene.ingredientName = ing.ingredientName
                                }
                        }
                    }
                }
            }
        }.padding(.trailing,-200)
        
    }
    
}


struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        FlowView()
            .environmentObject(AudioManager())
    }
}
