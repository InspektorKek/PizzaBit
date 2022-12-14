//
//  LevelView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 10/12/22.
//

import SwiftUI
import SpriteKit

struct LevelView: View {
    var body: some View {
        
        NavigationView {
            HStack {
                SpriteView(scene : SceneFabric.shared.miniChefScene , options: [.allowsTransparency])
                    .frame(width: 300, height: 300)
                
                VStack(alignment: .trailing){
                    Spacer()
                    NavigationLink {
                        PlaygroundView( musicLevel: "Pizza_Easy", theGameScene: GameScene(music: "Pizza_Easy", beat: 0.6667 * 2, bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: 600, height: 200)))
                    } label: {
                        Text("Easy")
                    }
                    NavigationLink {
                        PlaygroundView( musicLevel: "Pizza_Medium", theGameScene: GameScene(music: "Pizza_Medium", beat: 0.6667 * 2, bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: 600, height: 200)))
                    } label: {
                        Text("Normal")
                        
                    }
                    NavigationLink {
                        PlaygroundView( musicLevel: "PERFECTIONIST", theGameScene: GameScene(music: "PERFECTIONIST", beat: 0.6667 * 2, bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: 600, height: 200)))
                    } label: {
                        Text("Hard")
                    }
                    
                }
                .font(.custom("Blocktopia", size: 90))
                .foregroundColor(Color(uiColor: .label))
                .shadow(color: .purple, radius: 0,x: -5)
                .shadow(color: .green, radius: 0,x: 5)
            }
            .background {
                Image("bkg0")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
