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
        ZStack {
            Image("bkg0")
                .resizable()
                .ignoresSafeArea()
            
                HStack {
                    SpriteView(scene : miniChefSprite , options: [.allowsTransparency])
                        .ignoresSafeArea()
                        .frame(width: 300, height: 300)
                        .onAppear{
                            miniChefSprite.size = CGSize(width: 300, height: 300)
                            miniChefSprite.backgroundColor = .clear
                            miniChefSprite.scaleMode = .fill
                            miniChefSprite.ingredientName = "MiniChef"
                        }
                    
                    VStack(alignment: .trailing){
                        Spacer()
                        NavigationLink {
                            PlaygroundView( musicLevel: "Pizza_Easy")
                        } label: {
                            Text("Easy")
                        }
                        NavigationLink {
                            PlaygroundView( musicLevel: "Pizza_Medium")
                        } label: {
                            Text("Medium")
                            
                        }
                        NavigationLink {
                            PlaygroundView( musicLevel: "Pizza_Easy")
                        } label: {
                            Text("Hard")
                        }
                        
                    }.font(.custom("Blocktopia", size: 90))
                    .foregroundColor(Color(uiColor: .label))
                    .shadow(color: .purple, radius: 0,x: -5)
                    .shadow(color: .green, radius: 0,x: 5)
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
    }
}
