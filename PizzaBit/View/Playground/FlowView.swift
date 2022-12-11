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
            SpriteView(scene : miniChefSprite , options: [.allowsTransparency])
               // .ignoresSafeArea()
                .frame(width: 90, height: 100)
                .onAppear{
                    miniChefSprite.size = CGSize(width: 500, height: 500)
                    miniChefSprite.backgroundColor = .clear
                    miniChefSprite.scaleMode = .fill
                    miniChefSprite.ingredientName = "MiniChef"
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



struct HomeMadeTimelapseView : View {
    @EnvironmentObject var audioManager : AudioManager
    @State var width : CGFloat = 0
    
    var body: some View {
        VStack(spacing : 20){
            ZStack(alignment: .leading){
                Capsule().fill(Color(uiColor: .systemGray)).frame(height: 15)
                Capsule().fill(Color(uiColor: .systemRed)).frame(width: self.width, height: 15)
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
                            if ((audioManager.player?.isPlaying) != nil){

                                let timelapseWidth = 380 - 10

                                let value = audioManager.player!.currentTime / audioManager.player!.duration
                                
                                
                                width = CGFloat(timelapseWidth) * CGFloat(value)
                                
                            }
                            
                        }
                        
                    }
            }
        }
    }
}




struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        FlowView()
            .environmentObject(AudioManager())
    }
}
