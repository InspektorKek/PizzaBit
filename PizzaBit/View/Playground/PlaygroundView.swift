//
//  ContentView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 06/12/22.
//

import SwiftUI
import AVKit
import CoreHaptics
import SpriteKit

struct PlaygroundView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var audioManager = AudioManager()
    @State private var engine : CHHapticEngine?
    
    @State  var musicTrigger : Bool = false
    @State var ingredient : String = "an ingredient"
    
    @State var musicLevel : String
    
    var body: some View {
        
        ZStack{
            // Background Image
            HStack {
                Image(colorScheme == .light ? "bkg0" : "bkg0")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            
            FlowView()
                .environmentObject(audioManager)
            
            
            VStack {
                // MARK: Play Pause Soundtrack btn
                HStack{
                    PointsView()
                    Spacer()
                    Button {
                        audioManager.playPause()
                        musicTrigger.toggle()
                        
                    } label: {
                        
                        Image( musicTrigger ? "play" : "pause")
                            .resizable()
                            .frame(width: 32,height: 32)
                            .scaledToFill()
                    }.offset(x: -25,y: -25)
                    
                }.frame(width: 785)
                    .offset(y: -20)
                
                
                Spacer()
                
                // MARK: Ingredients btn
                HStack {
                    ForEach(pizza){ ing in
                        Button {
                            ingredient = ing.ingredientName
                            prepareHaptics()
                            playIngredientHapticsFile(ing.haptic)
                        } label: {
                            VStack {
                                LozengeBtn(pictoName: ing.imgName, rotationEffect: 45, frame: 75)
                                    .padding()
                                
                            }
                        }.padding(.bottom, ing.imgName == "0oil" || ing.imgName == "0basil" ?  0 : 30)
                        if(ing.imgName == "0oil"){
                            Spacer()
                                .frame(width: 360)
                        }
                    }
                }
            }
            .onAppear{
                audioManager.startPlayer(messageAudioName: musicLevel)
            }
            
        }
        .font(Font.custom("Blocktopia", size: 40))
        .navigationBarBackButtonHidden()
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


struct LozengeBtn : View {
    var pictoName : String = ""
    var cornerRadius : Double = 20
    var rotationEffect : Double
    var frame : Double
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(.clear)
                .background(RadialGradient(colors: [Color(uiColor: .systemBackground),Color(uiColor: .systemGray6),Color(uiColor: .systemGray2)], center: .center, startRadius: 0, endRadius: 80))
            
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
        PlaygroundView(musicLevel: "Pizza_Medium")
    }
}
