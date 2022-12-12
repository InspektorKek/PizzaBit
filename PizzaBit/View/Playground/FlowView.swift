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
    @Binding var pizza: [Ingredient]
    
    var scene: SKScene {
        let scene = SKScene(fileNamed: "FlowScene")!
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        return scene
    }
    
    var body: some View {
        // Flow where ingredients run
        VStack(spacing: 0) {
            HStack {
                Spacer()
                HomeMadeTimelapseView()
                    .frame(height: 20)
                    .frame(width: 300)
                    .padding(.trailing, 30)
            }
            
            SpriteView(scene: scene)
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.trailing)
        }
    }
}


// To be defined
struct StreamingIngredientGrid : View {
    @Binding var pizza: [Ingredient]
    
    var body: some View {
        let rows : [GridItem] = [GridItem(spacing: 10.0, alignment: .center)]
        
        HStack {
            SpriteView(scene: SceneFabric.shared.miniChefScene, options: [.allowsTransparency])
                .frame(width: 90, height: 90)
                        
            LazyHGrid(rows: rows) {
                ForEach(pizza){ ing in
                    SpriteView(scene: ing.scene , options: [.allowsTransparency])
                        .frame(width: 64, height: 64)
                }
            }
            Spacer()
        }
    }
    
}


struct HomeMadeTimelapseView : View {
    @EnvironmentObject var audioManager : AudioManager
    @State var width : CGFloat = 0
    
    var body: some View {
        VStack(spacing : 20){
            ZStack(alignment: .leading){
                Rectangle().fill(.gray).frame(width: 380,height: 15)
                Rectangle().fill(.red).frame(width: self.width, height: 15)
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
                            if ((audioManager.player?.isPlaying) != nil){

                                let timelapseWidth = 360

                                let value = audioManager.player!.currentTime / audioManager.player!.duration
                                 print("current time : \(audioManager.player!.currentTime )\nduration: \(audioManager.player!.duration)")
                                
                                width = CGFloat(timelapseWidth) * CGFloat(value)
                                
                            }
                            
                        }
                        
                    }
    
        
            .padding(.horizontal, 16)
            Image("timelapse")
                .resizable()
                .frame(width: 385,height: 20)
        } .offset(y: 4)
        }
    }
}
/*
struct HomeMadeTimelapseView : View {
    @EnvironmentObject var audioManager : AudioManager
    @State var width : CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color(uiColor: .systemGray)).frame(height: 15)
                    Rectangle().fill(Color(uiColor: .systemRed)).frame(width: self.width, height: 15)
                        .onAppear{
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
                                if ((audioManager.player?.isPlaying) != nil){
                                    
                                    let timelapseWidth = proxy.size.width - 10
                                    
                                    let value = audioManager.player!.currentTime / audioManager.player!.duration
                                    
                                    
                                    width = CGFloat(timelapseWidth) * CGFloat(value)
                                    
                                    
                                }
                                
                            }
                            
                        }
                }
                .padding(.horizontal, 16)
                Image("timelapse")
                    .resizable()
                    .frame(height: 20)
            }
            .offset(y: 4)
        }
    }
}
*/
struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        FlowView(pizza: .constant(Ingredient.Kind.allCases.map { Ingredient(type: $0, scene: IngredientScene(ingredientKind: $0)) } + Ingredient.Kind.allCases.map { Ingredient(type: $0, scene: IngredientScene(ingredientKind: $0)) } + Ingredient.Kind.allCases.map { Ingredient(type: $0, scene: IngredientScene(ingredientKind: $0)) }))
            .environmentObject(AudioManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
