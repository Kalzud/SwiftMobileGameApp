//
//  SoundOffOption.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This calss is the SoundOff option class that controls what happens when user
//  clicks the SoundOff

//..............Import Statements...........................................................................
import UIKit

class SoundOffOption: SettingsOptionsObject {

    override init(text: String = "Sound Off", image: UIImage = UIImage(named: "soundoff") ?? UIImage()) {
        super.init(text: text, image: image)
    }

    override func onObjectClicked() {
        gameDataManager.stopSound()
    }
    //............................................................. END OF CLASS ............................................................
}
