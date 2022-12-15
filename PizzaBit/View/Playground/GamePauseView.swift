//
//  GamePauseView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 12/12/22.
//

import SwiftUI

struct GamePauseView: View {
    @EnvironmentObject var audioManager : AudioManager
    @Binding var musicLevel : String
    var body: some View {
            ZStack{
                Rectangle()
                    .foregroundColor(
                        .black
                        .opacity(0.5)
                    )
                        .ignoresSafeArea()
                
                    Lozenge(gradient: [Color("Dough")],cornerRadius: 900,rotationEffect: 45, frame: 260)
                        .foregroundColor(Color("Dough"))
                        .shadow(color: Color(uiColor: .systemPurple), radius:2,x:0.75, y: 0.25)
                        .shadow(color: Color(uiColor: .systemGreen), radius:2,x:-0.75, y: -0.25)
                        .shadow(color: Color(uiColor: .label), radius: 0,x:0.5, y: 0.5)
                        .shadow(color: Color(uiColor: .systemPurple), radius: 0,x:1, y: 1)
                        
                    VStack {
                        Spacer()
                        Text("PAUSE")
                            .font(.custom("PixelatedPusab", size: 50))
                            .foregroundColor(Color("Dough"))
                                .shadow(color: Color(uiColor: .systemPurple), radius:0,x:0.75, y: 0.25)
                                .shadow(color: Color(uiColor: .systemGreen), radius:0,x:-0.75, y: -0.25)
                                .shadow(color: Color(uiColor: .label), radius: 0,x:0.5, y: 0.5)
                                .shadow(color: Color(uiColor: .label), radius: 0,x:-0.5, y: -0.5)
                                .shadow(color: Color(uiColor: .systemPurple), radius: 0,x:1, y: 1)
                                .frame(width: 230)
                    
                        VStack{
                            
                            Button {
                                audioManager.playPause()
                                audioManager.isPlaying = true
                            } label: {
                                
                                HStack {
                                  
                                    Label("Continue", systemImage: "play.fill")
                                        .foregroundColor(Color(uiColor: .systemGreen))                                        .labelStyle(.iconOnly)
                                        .font(.system(size: 25))
                                        .bold()
                                    Text("Continue")
                                        .foregroundColor(Color(uiColor: .systemGreen))
                                }
                               
                            }
                            Spacer()
                            Button {
                                audioManager.player?.currentTime = 0.0
                                audioManager.player?.play()
                                audioManager.isPlaying = true
                                audioManager.isOver = false
                            } label: {
                                
                                HStack {
                                    Label("Restart", systemImage: "arrow.counterclockwise")
                                        .foregroundColor(Color(uiColor: .systemGray))
                                        .labelStyle(.iconOnly)
                                        .font(.system(size: 25))
                                        .bold()
                                    Text("Restart")
                                        .foregroundColor(Color(uiColor: .systemGray))
                                    
                                        
                                }
                               
                            }
                            Spacer()
                            NavigationLink {
                                LevelView()
                                    .onAppear{
                                        audioManager.stopIt()
                                    }
                                //close the view
                                //make the player current time at zero
                                // play the song
                            } label: {
                                
                                HStack {
                                    Label("Abandon", systemImage: "stop.fill")
                                        .foregroundColor(Color(uiColor: .systemPurple))
                                        .labelStyle(.iconOnly)
                                        .font(.system(size: 25))
                                        .bold()
                                        
                                    Text("Abandon")
                                        .foregroundColor(Color(uiColor: .systemPurple))
                                }
                               
                            }
                            
                        

                        }.frame(width: 200)
                        .font(.custom("Blocktopia", size: 25))
                    }.frame(height: 100)
                
                    
            }
        }
}
/*

struct GamePauseView_Previews: PreviewProvider {
    static var previews: some View {
      // GamePauseView(musicLevel: <#T##Binding<String>#>)
        PlaygroundView(musicLevel: "Pizza_Medium", theGameSpriteView: GameScene(music: "Pizza_Medium", beat: 0.6667 * 2, bar: 2.6667 * 2, level_multiplier: 1,size: CGSize(width: 600, height: 200)))
    }
}
*/
