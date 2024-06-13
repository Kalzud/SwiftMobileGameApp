//
//  DarkThemeOption.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This calss is the DarkTheme option class that controls what happens when user
//  clicks the DarkTheme

//..............Import Statements...........................................................................
import UIKit

class DarkThemeOption: SettingsOptionsObject {

    override init(text: String = "Dark Theme", image: UIImage = UIImage(named: "darktheme") ?? UIImage()) {
        super.init(text: text, image: image)
    }

    override func onObjectClicked() {
        gameDataManager.updateBackgroundColor(color: .black)
    }
    //............................................................. END OF CLASS ............................................................
}
