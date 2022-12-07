//
//  ContentView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 06/12/22.
//

import SwiftUI
import AVKit
import CoreHaptics

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var audioManager = AudioManager()
    @State private var engine : CHHapticEngine?
    
    @State  var musicTrigger : Bool = false
    @State var ingredient : String = "an ingredient"
    var body: some View {
        
        ZStack{
            Image(colorScheme == .dark ? "bkg0" : "bkg0")
                .resizable()
                .ignoresSafeArea()
            VStack {
                
                // MARK: Play Pause Soundtrack btn
                HStack{
                    Spacer()
                    Button {
                        audioManager.playPause()
                        musicTrigger.toggle()
                        
                    } label: {
                        Image(systemName: musicTrigger ? "play.circle.fill" : "pause.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color(uiColor: .label))
                    }.padding()
                    
                }
                Spacer()
                
                Text("feel")
                    .font(.caption2)
                    .italic()
                Text(ingredient)
                    .font(.system(size: 50))
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                Text("in your hands")
                    .font(.callout)
                    .bold()
                
                Spacer()
                HStack {
                    ForEach(pizza){ ing in
                        Button {
                            ingredient = ing.ingredientName
                            prepareHaptics()
                            playIngredientHapticsFile(ing.haptic)
                        } label: {
                            VStack {
                                ZStack{
                                    Circle()
                                        .foregroundColor(.clear)
                                        .background(RadialGradient(colors: [Color(uiColor: .systemBackground),Color(uiColor: .systemGray6),Color(uiColor: .systemGray2)], center: .center, startRadius: 0, endRadius: 80))
                                        .overlay {
                                            Image(ing.imgName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 64)
                                                .shadow(color: Color(uiColor: .systemGray), radius: 0,x: 0,y: 3)
                                        }
                                        .clipShape(Circle())
                                        .frame(width: 100)
                                    
                                }   .shadow(color: Color(uiColor: .systemGray6), radius: 0,x: 0,y: 6)
                                    .shadow(color: Color(uiColor: .systemGray3), radius: 1,x: 0,y: 1)
                                
                            }.padding()
                                .padding(.trailing, ing.imgName == "oil0" ? 280 : 0)
                        }
                    }
                }
            }
            .onAppear{
                audioManager.startPlayer(messageAudioName: "Pizza_Easy")
            }
            
        }
        .fontDesign(.monospaced)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
