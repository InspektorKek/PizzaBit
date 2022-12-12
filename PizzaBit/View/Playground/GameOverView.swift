//
//  GameOverView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 12/12/22.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var audioManager : AudioManager
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(
                    .black
                        .opacity(0.5)
                )
                .ignoresSafeArea()
           
            HStack{
                ZStack {
                    Lozenge(rotationEffect: 45, frame: 100)
                    Button {
                        audioManager.player?.currentTime = 0.0
                        audioManager.playPause()
                        audioManager.isPlaying = true
                    } label: {
                        
                        VStack {
                            Label("Restart", systemImage: "arrow.counterclockwise")
                                .foregroundColor(Color("Dough"))
                                .shadow(color: Color(uiColor: .systemGreen),radius: 1,x: 0,y: 2)
                                .labelStyle(.iconOnly)
                                .font(.system(size: 35))
                                .bold()
                            Text("Restart")
                                .foregroundColor(Color(uiColor: .systemGreen))
                            
                                
                        }
                       
                    }
                }
                Spacer()
                ZStack{
                Lozenge(gradient: [Color("Dough")],cornerRadius: 900,rotationEffect: 0, frame: 370)
                    .foregroundColor(Color("Dough"))
                    .shadow(color: Color(uiColor: .systemPurple), radius:2,x:0.75, y: 0.25)
                    .shadow(color: Color(uiColor: .systemGreen), radius:2,x:-0.75, y: -0.25)
                    .shadow(color: Color(uiColor: .label), radius: 0,x:0.5, y: 0.5)
                    .shadow(color: Color(uiColor: .systemPurple), radius: 0,x:1, y: 1)
                
                VStack {
                    Text("Highscores")
                        .font(.custom("Blocktopia", size: 70))
                        .foregroundColor(Color("Dough"))
                        .shadow(color: Color(uiColor: .systemPurple), radius:0,x:0.75, y: 0.25)
                        .shadow(color: Color(uiColor: .systemGreen), radius:0,x:-0.75, y: -0.25)
                        .shadow(color: Color(uiColor: .label), radius: 0,x:0.5, y: 0.5)
                        .shadow(color: Color(uiColor: .label), radius: 0,x:-0.5, y: -0.5)
                        .shadow(color: Color(uiColor: .systemPurple), radius: 0,x:1, y: 1)
                        .frame(width: 370)
                        .padding(.top)
                    
                    Spacer()
                    
                    HStack{
                        
                        VStack {
                            Text("RANK")
                                .padding(.bottom,5)
                            ForEach(1..<11){ index  in
                                if(index >= 4){
                                    Text("\(index)TH")
                                }else{
                                    switch index {
                                    case 1 :
                                        Text("\(index)ST")
                                    case 2 :
                                        Text("\(index)ND")
                                    case 3 :
                                        Text("\(index)RD")
                                    default :
                                        Text("\(index)")
                                    }
                                }
                            }
                        }
                        Spacer()
                        VStack {
                            Text("Name")
                                .padding(.bottom,5)
                            ForEach(1..<11){ index  in
                                if(index >= 4){
                                    let name = ["A","R","T"].shuffled()
                                    Text(name.joined())
                                }else{
                                    let name = ["R","A","Y"].shuffled()
                                    Text(name.joined())
                                }
                            }
                        }
                        Spacer()
                        VStack {
                            Text("Score")
                                .padding(.bottom,5)
                            ForEach(1..<11){ index  in
                                switch index {
                                case 1 :
                                    Text("990")
                                case 2 :
                                    Text("901")
                                case 3 :
                                    Text("899")
                                case 9 :
                                    Text("568")
                                case 10 :
                                    Text("206")
                                default :
                                    Text("750")
                                }
                            }
                        }
                        
                    }.frame(width: 320)
                        .font(.custom("Blocktopia", size: 20))
                        .foregroundColor(Color(uiColor: .label))
                        .labelStyle(.iconOnly)
                        .font(.system(size: 35))
                        .bold()
                    
                    Spacer()
                }
            }
                Spacer()
                ZStack {
                    Lozenge(rotationEffect: 45, frame: 100)
                    
                    NavigationLink {
                            LevelView()
                        //close the view
                        //make the player current time at zero
                        // play the song
                    } label: {
                        
                        VStack {
                            Label("Level", systemImage: "play.fill")
                                .foregroundColor(Color("Dough"))
                                .shadow(color: Color(uiColor: .systemPurple),radius: 2,x: 1,y: 2)
                                .labelStyle(.iconOnly)
                                .font(.system(size: 35))
                                .bold()
                                
                            Text("Level")
                                .foregroundColor(Color(uiColor: .systemPurple))
                        }
                       
                    }
                }
            }.padding()
                    
            }
        .font(.custom("Blocktopia", size: 20))
        }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView(musicLevel: "Pizza_Medium")
    }
}
