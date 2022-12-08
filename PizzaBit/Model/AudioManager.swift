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
   
}



