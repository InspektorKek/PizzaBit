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

            StreamingIngredientGrid(pizza: $pizza)
                .frame(maxWidth: .infinity)
                .frame(height: 120)
                .padding(.leading, 40)
                .background {
                    Image("flow")
                        .resizable()
                        .frame(height: 120)
                        .edgesIgnoringSafeArea(.trailing)
                }
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

struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        FlowView(pizza: .constant([]))
            .environmentObject(AudioManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
