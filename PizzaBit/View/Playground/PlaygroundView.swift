//
//  PlaygroundView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 06/12/22.
//

import SwiftUI
import AVKit
import CoreHaptics
import SpriteKit
/*
 class TheGameState : ObservableObject {
    @Published var gameScore : Int
    @Published var highScore : Int
    @Published var needUpdate : Bool
    @Published var scoreToDisplay : String
    
    init(){
        gameScore = 0
        highScore = 0
        needUpdate = false
        scoreToDisplay = "000"
    }
}
*/
struct PlaygroundView: View {
 //   @StateObject var gameState = TheGameState()
    @StateObject var audioManager = AudioManager()
    @State private var engine : CHHapticEngine?
    
    @State var ingredient : String = "an ingredient"
    
    @State var musicLevel : String
    @State var theGameScene : GameScene
    
    @State var pizza: [Ingredient] = Ingredient.Kind.allCases.map { Ingredient(type: $0, scene: IngredientScene(ingredientKind: $0)) }
    
    @State var visualFeedback : String = " Kick\n⬇︎ "
    @State var scaleMedium = false
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Play Pause Soundtrack btn
            HStack {
                    PointsView(theGameScene: $theGameScene)
                    .environmentObject(audioManager)
                Spacer()
                Button {
                    audioManager.playPause()
                    audioManager.isPlaying = false
                } label: {
                    Image(audioManager.isPlaying ? "pause" : "play")
                        .resizable()
                        .frame(width: 32,height: 32)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            FlowView(theGameScene: $theGameScene)
                .environmentObject(audioManager)
                .padding(.leading)
                .overlay(
                    Text(visualFeedback)
                    .font(Font.custom("PixelatedPusab", size: 15))
                    .multilineTextAlignment(.center)
                    .onChange(of: audioManager.score) { _ in
                      
                        visualFeedback = [ "You rock\n⬇︎", "Amazing\n⬇︎","Perfect\n⬇︎","You got this \n⬇︎", "On Fire\n⬇︎"].shuffled()[0]
                        
                    }
                        .onChange(of: audioManager.missed) { _ in
                          
                            visualFeedback = [ "Missed\n⬇︎", "Oops\n⬇︎","Try Again\n⬇︎"].shuffled()[0]
                            
                        }
                    .offset(x: -230, y:-25)
                )
            
            // MARK: Ingredients btn
            HStack {
                ForEach(pizza){ ing in
                    Button {
                        
                        ingredient = ing.type.name
                        prepareHaptics()
                        playIngredientHapticsFile(ing.haptic)
                        
                        audioManager.score =  theGameScene.defineSuccess(buttonPressed: ing.type.name).pts
                        audioManager.combo = theGameScene.defineSuccess(buttonPressed: ing.type.name).cmb
                        audioManager.missed = 100 - theGameScene.defineSuccess(buttonPressed: ing.type.name).liv
                      
                    } label: {
                        Lozenge(pictoName: ing.imgName, rotationEffect: 45, frame: 75)
                            .padding(.horizontal)
                        
                    }.padding(.bottom, ing.type == .oil || ing.type == .basil ?  0 : 30)
                    
                    if ing.type == .basil {
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .background {
            Image("bkg0")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .onAppear(){
            withAnimation(.linear(duration: 10).delay(0.5).repeatForever(autoreverses: true)){}
            audioManager.startPlayer(messageAudioName: musicLevel)
            
        }
        .overlay{
            if audioManager.isPlaying == false {
                    GamePauseView(musicLevel: $musicLevel).environmentObject(audioManager)
                
            } else if (audioManager.isPlaying == true && audioManager.isOver == true ){
                GameOverView(isGameOver: $audioManager.isOver)
                    .environmentObject(audioManager)
            }
            
            
            
        }
    }
    
    // MARK: Haptic Toolbox
    func prepareHaptics( ){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            engine = try CHHapticEngine()
            try engine?.start()
        }catch let error{
            print("\(error)")
        }
    }
    
    func playIngredientHapticsFile(_ theIngredientName : String){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        do{
            let pattern = createPatternFromAHAP(theIngredientName)
            let player = try engine?.makePlayer(with: pattern!)
            try player?.start(atTime: 0)
        }catch let error{
            print("\(error)")
        }
    }
    
    func createPatternFromAHAP(_ filename: String) -> CHHapticPattern? {
        // Get the URL for the pattern in the app bundle.
        let patternURL = Bundle.main.url(forResource: filename, withExtension: "ahap")!
        
        do {
            // Read JSON data from the URL.
            let patternJSONData = try Data(contentsOf: patternURL, options: [])
            
            // Create a dictionary from the JSON data.
            let dict = try JSONSerialization.jsonObject(with: patternJSONData, options: [])
            
            if let patternDict = dict as? [CHHapticPattern.Key: Any] {
                // Create a pattern from the dictionary.
                return try CHHapticPattern(dictionary: patternDict)
            }
        } catch let error {
            print("Error creating haptic pattern: \(error)")
        }
        return nil
    }
    
    
}


struct Lozenge : View {
    var gradient : [Color] = [Color(uiColor: .systemBackground),Color(uiColor: .systemGray6),Color(uiColor: .systemGray2)]
    var pictoName : String = ""
    var cornerRadius : Double = 20
    var rotationEffect : Double
    var frame : Double
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(.clear)
                .background(RadialGradient(colors: gradient, center: .center, startRadius: 0, endRadius: 80))
            
                .clipShape( RoundedRectangle(cornerRadius: 20))
                .frame(width: frame,height: frame)
                .rotationEffect(Angle(degrees: rotationEffect))
                .opacity(0.7)
                .overlay {
                    Image(pictoName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64)
                        .shadow(color: Color(uiColor: .systemGray), radius: 0,x: 0,y: 3)
                }
            
        }
        .shadow(color: Color(uiColor: .systemGray6), radius: 0,x: 0,y: 6)
        .shadow(color: Color(uiColor: .systemGray3), radius: 1,x: 0,y: 1)
        .shadow(color: Color(uiColor: .label), radius: 1,x: 0,y: 1)
        
        
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView(musicLevel: "Pizza_Medium", theGameScene: SceneFabric.shared.theGameSceneNormal)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
