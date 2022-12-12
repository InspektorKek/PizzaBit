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
                        Text("Pause")
                            .font(.custom("Blocktopia", size: 70))
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
                                        .foregroundColor(Color("Dough"))
                                        .shadow(color: Color(uiColor: .systemGreen),radius: 2,x: -1,y: 2)
                                        .labelStyle(.iconOnly)
                                        .font(.system(size: 35))
                                        .bold()
                                    Text("Continue")
                                        .foregroundColor(Color(uiColor: .systemGreen))
                                }
                               
                            }
                            Spacer()
                            Button {
                                audioManager.player?.currentTime = 0.0
                                audioManager.playPause()
                                audioManager.isPlaying = true
                            } label: {
                                
                                HStack {
                                    Label("Restart", systemImage: "arrow.counterclockwise")
                                        .foregroundColor(Color("Dough"))
                                        .shadow(color: Color(uiColor: .systemGray),radius: 1,x: 0,y: 2)
                                        .labelStyle(.iconOnly)
                                        .font(.system(size: 35))
                                        .bold()
                                    Text("Restart")
                                        .foregroundColor(Color(uiColor: .systemGray))
                                    
                                        
                                }
                               
                            }
                            Spacer()
                            NavigationLink {
                                    LevelView()
                                //close the view
                                //make the player current time at zero
                                // play the song
                            } label: {
                                
                                HStack {
                                    Label("Abandon", systemImage: "stop.fill")
                                        .foregroundColor(Color("Dough"))
                                        .shadow(color: Color(uiColor: .systemPurple),radius: 2,x: 1,y: 2)
                                        .labelStyle(.iconOnly)
                                        .font(.system(size: 35))
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

struct GamePauseView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView(musicLevel: "Pizza_Medium")
    }
}
