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
    //@Binding var pizza: [Ingredient]
    @Binding var theGameScene : GameScene
    
    var scene: SKScene {
        let scene = SKScene(fileNamed: "FlowScene")!
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        return scene
    }
    
    
    
    var body: some View {
        // Flow where ingredients run
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    HomeMadeTimelapseView(isGameOver: $audioManager.isOver)
                        .frame(height: 20)
                        .frame(width: 300)
                        .padding(.trailing, 30)
                }
                
                SpriteView(scene: scene , options: .allowsTransparency)
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.trailing)
                    
            }
            StreamingIngredientGrid( theGameScene: $theGameScene)
                .environmentObject(audioManager)
                .offset(y:7)
        }
    }
}


// To be defined
struct StreamingIngredientGrid : View {
    
    @EnvironmentObject var audioManager : AudioManager
    @Binding var theGameScene : GameScene
    var gscene: SKScene {
        let theGameScene = theGameScene
        theGameScene.size = CGSize(width: 740, height: 100)
        theGameScene.scaleMode = .aspectFit
        theGameScene.backgroundColor = .clear

        return theGameScene
    }
    
    var body: some View {
        // Using the SpriteView, show the game scene in your SwiftUI view
        SpriteView(scene: theGameScene, isPaused: !audioManager.isPlaying, options: .allowsTransparency)
            .frame(width: 740, height: 100)
            .ignoresSafeArea()
    }
    
    
}


struct HomeMadeTimelapseView : View {
    @EnvironmentObject var audioManager : AudioManager
    @State var width : CGFloat = 0.2
    @Binding var isGameOver : Bool
    var body: some View {
        VStack(spacing : 20){
            ZStack(alignment: .leading){
                Rectangle().fill(.gray).frame(width: 380,height: 15)
                Rectangle().fill(.red).frame(width: self.width, height: 15)
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
                            if ((audioManager.player?.isPlaying) == true){
                                
                                let timelapseWidth = 355
                                
                                let value = audioManager.player!.currentTime / audioManager.player!.duration
                                
                                
                                width = CGFloat(timelapseWidth) * CGFloat(value)
                                
                                
                                
                            }else if ((audioManager.player?.isPlaying) == false){
                                
                                isGameOver = true
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
/*
 struct FlowView_Previews: PreviewProvider {
 static var previews: some View {
 FlowView( theGameScene: GameScene(music: "PERFECTIONIST", beat: 0.6667 * 2, bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: 600, height: 200)))
 .environmentObject(AudioManager())
 .previewInterfaceOrientation(.landscapeLeft)
 }
 }
 */
