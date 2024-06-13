//
//  SettingsOptionsObject.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//  This is the parent calss for settings options 
//

//..............Import Statements...........................................................................
import UIKit

class SettingsOptionsObject: SettingsObjectClickListener{
    private var text: String
    private var image: UIImage
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance

    init(text: String, image: UIImage) {
        self.text = text
        self.image = image
    }

    func getText() -> String {
        return text
    }
    
    func getImage() -> UIImage{
        return image
    }

    func onObjectClicked(){}
    //............................................................. END OF CLASS ............................................................
}

