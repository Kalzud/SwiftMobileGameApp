//
//  SoundOnOption.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This calss is the SoundOn option class that controls what happens when user
//  clicks the SoundOn

//..............Import Statements...........................................................................
import UIKit

class SoundOnOption: SettingsOptionsObject {

    override init(text: String = "Sound On", image: UIImage = UIImage(named: "soundon") ?? UIImage()) {
        super.init(text: text, image: image)
    }
    override func onObjectClicked() {
        gameDataManager.playSound()
    }
    //............................................................. END OF CLASS ............................................................
}
