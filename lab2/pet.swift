//
//  pet.swift
//  lab2
//
//  Created by Brad Hodkinson on 9/19/18.
//  Copyright © 2018 Brad Hodkinson. All rights reserved.
//

import Foundation
//import for color
import UIKit
//import for vibration
import AudioToolbox
//import for audio
import AVFoundation

class Pet {
    
    //Data
    var happinessLevel:Int
    var foodLevel:Int
    var name:String
    var petType:PetType
    var imageName: String
    var color: UIColor
    var petAudioPlayer: AVAudioPlayer?

    //enum for types of pets
    enum PetType {
        case bird
        case bunny
        case cat
        case dog
        case fish
        case scooby
    }
    
    //Function to play with the pet
    func play() {
        //make sure the pet has high enough food level to ensure enough energy to be played with
        if(foodLevel > 0) {
            //make sure the happiness level does not exceed the max level
            if(happinessLevel < 10) {
                //increase the happiness of the pet, they love to be played with
                happinessLevel += 1
                
                //make a noise if the animal is played with
                petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "play", withExtension: "mp3")!)
                petAudioPlayer?.prepareToPlay()
                petAudioPlayer?.play()
            }
            //playing requires fuel, lower food level
            foodLevel -= 1
        } else {
            //vibrate the device if the player tries to play with the animal without a high enough food level
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    //function to feed the animal
    func feed() {
        if(foodLevel < 10){
            //increase the food level
            foodLevel += 1
            //make eating noise if the animal is fed
            petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "feed", withExtension: "mp3")!)
            petAudioPlayer?.prepareToPlay()
            petAudioPlayer?.play()
        }
    }
    
    //function to create a pet noise
    func makeNoise(){
        //depending on the pet, make a custom noise
        switch petType {
        case .bird:
            petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "bird", withExtension: "mp3")!)
        case .bunny:
            petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "bunny", withExtension: "mp3")!)
        case .cat:
            petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "cat", withExtension: "mp3")!)
        case .dog:
            petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "dog", withExtension: "mp3")!)
        case .fish:
            petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "fish", withExtension: "mp3")!)
        case .scooby:
            petAudioPlayer = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "scooby", withExtension: "mp3")!)
        }
        //prepare the audio player to play noise
        petAudioPlayer?.prepareToPlay()
        //make the pet noise
        petAudioPlayer?.play()
    }
    //function to stop the pet noise
    func stopNoise(){
        petAudioPlayer?.stop()
    }
    
    //Init
    init(name: String, petType: PetType, imageName: String, color: UIColor){
        self.name = name
        self.petType = petType
        self.imageName = imageName
        self.color = color
        foodLevel = 0
        happinessLevel = 0
    }
}
