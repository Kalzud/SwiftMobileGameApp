//
//  LightThemeOption.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This calss is the LightTheme option class that controls what happens when user
//  clicks the LightTheme

//..............Import Statements...........................................................................
import UIKit


class LightThemeOption: SettingsOptionsObject {

    override init(text: String = "Light Theme", image: UIImage = UIImage(named: "lighttheme") ?? UIImage()) {
        super.init(text: text, image: image)
    }

    override func onObjectClicked() {
        gameDataManager.updateBackgroundColor(color: .white)
    }
    //............................................................. END OF CLASS ............................................................
}

