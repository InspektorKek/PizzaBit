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
                        PlaygroundView( musicLevel: "Pizza_Easy")
                    } label: {
                        Text("Easy")
                    }
                    NavigationLink {
                        PlaygroundView( musicLevel: "Pizza_Medium")
                    } label: {
                        Text("Normal")
                        
                    }
                    NavigationLink {
                        PlaygroundView( musicLevel: "PERFECTIONIST")
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
