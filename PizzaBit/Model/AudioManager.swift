//
//  AudioManager.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 06/12/22.
//

import Foundation
import AVKit


final class AudioManager : ObservableObject {

   
   var player : AVAudioPlayer?
   @Published private(set) var isPlaying : Bool = false{
       didSet {
           print("is Playing ", isPlaying )
       }
   }
   
   func startPlayer(messageAudioName : String){
       guard let sourceFileURL = Bundle.main.url(forResource: messageAudioName, withExtension: "mp3")  else {
           print("Audio file not found: \(messageAudioName)")
           return
       }
       
       do{
           
           // So the sound keeps playing in background and keeps playing in silent mode
           try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord,
                                   mode: .default)
           
           try AVAudioSession.sharedInstance().setActive(true)
           player = try AVAudioPlayer(contentsOf: sourceFileURL)
           player?.prepareToPlay()
           player?.play()
           isPlaying = true
       }catch{
           print("Fail to play", error)
       }
       
   }
   
 
   func playPause()  {
       guard let player = player else {
           print("Issue with audio not found")
           return
       }
       
       if player.isPlaying {
           player.pause()
           isPlaying = false
       }else{
           player.play()
           isPlaying = true
       }
   }
    
    @Published public var ingredientName : String = ""
    func getXposition()->CGFloat {
         var xPosition : CGFloat = 5.0
        guard let currentTime = player?.currentTime else {return 0.0 }
        
        guard let theEnd = player?.duration else {return 0.0 }
        
        switch(currentTime){
        case( 0 ..< (theEnd*10/100)) :
            xPosition = 15.0
        case( (theEnd*10/100) ..< (theEnd*20/100)) :
            xPosition = 30.0
        case( (theEnd*20/100) ..< (theEnd*30/100)) :
            xPosition = 45.0
        case( (theEnd*30/100) ..< (theEnd*40/100)) :
            xPosition = 60.0
        case( (theEnd*40/100) ..< (theEnd*50/100)) :
            xPosition = 75.0
        case( (theEnd*50/100) ..< (theEnd*60/100)) :
            xPosition = 90.0
        case( (theEnd*60/100) ..< (theEnd*70/100)) :
            xPosition = 105.0
        case( (theEnd*70/100) ..< (theEnd*80/100)) :
            xPosition = 120.0
        case( (theEnd*80/100) ..< (theEnd*90/100)) :
            xPosition = 135.0
        case( (theEnd*90/100) ..< (theEnd)) :
            xPosition = 140.0
        case( (theEnd)) :
            xPosition = 150.0
        default :
            xPosition = 75.0
        }
         return xPosition
     }
   
}




