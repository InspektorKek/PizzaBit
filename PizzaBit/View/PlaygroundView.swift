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
    var body: some View {
        
        ZStack{
            // Background Image
            HStack {
                Image(colorScheme == .light ? "bkg0" : "bkg0")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            
            // Flow where ingredients run
            ZStack {
                
                HStack {
                    Spacer()
                    Image("flow")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .frame(width: 990,height: 0)
                }.offset(y: 8)
                
                ZStack {
                    
                    HStack {
                        ZStack {
                            
                            HomeMadeTimelapseView()
                                .environmentObject(audioManager)
                                .frame(width: 380,height: 20)
                        }
                        .offset(x: 90,y: -103)
                    }
                    
                    Image("timelapse")
                        .resizable()
                        .padding(.bottom,40)
                    
                }
                
                 SpriteView(scene : oliveOil.scene , options: [.allowsTransparency])
                    .ignoresSafeArea()
                    .frame(width: 64, height: 64)
                    
                    
                    .onAppear{
                        oliveOil.scene.size = CGSize(width: 128, height: 128)
                        oliveOil.scene.backgroundColor = .clear
                        oliveOil.scene.scaleMode = .fill
                        oliveOil.scene.ingredientName = oliveOil.ingredientName
                    }
                
                
            }
            
            
            
            
            
            VStack {
                // MARK: Play Pause Soundtrack btn
                HStack{
                    Spacer()
                    Button {
                        audioManager.playPause()
                        musicTrigger.toggle()
                        
                    } label: {
                        
                        Image( musicTrigger ? "play" : "pause")
                            .resizable()
                            .frame(width: 32,height: 32)
                            .scaledToFill()
                    }
                    
                }
                .offset(x: -125,y: 0)
                
                Spacer()
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



struct HomeMadeTimelapseView : View {
    @EnvironmentObject var audioManager : AudioManager
    @State var width : CGFloat = 0
    
    var body: some View {
        VStack(spacing : 20){
            ZStack(alignment: .leading){
                Capsule().fill(.gray).frame(height: 15)
                Capsule().fill(.red).frame(width: self.width, height: 15)
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
                            if ((audioManager.player?.isPlaying) != nil){

                                let timelapseWidth = 380 - 10

                                let value = audioManager.player!.currentTime / audioManager.player!.duration
                                
                                
                                width = CGFloat(timelapseWidth) * CGFloat(value)
                                
                            //    audioManager.player?.currentTime = Double(percent) * audioManager.player!.duration
                            }
                            
                        }
                        
                    }
                
                
                /*
                 .gesture(AnyGesture()
                 .onChanged({ (value) in
                 let x = value.location.x
                 
                 self.width = x
                 }).onEnded({ (value) in
                 let x = value.location.x
                 
                 let screen = UIScreen.main.bounds.width - 30
                 
                 let percent = x / screen
                 
                 audioManager.player?.currentTime = Double(percent) * audioManager.player!.duration
                 }))
                 */
            }
        }
    }
}





struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
