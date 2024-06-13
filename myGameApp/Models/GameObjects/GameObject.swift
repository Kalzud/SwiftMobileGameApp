//
//  GameObject.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This is the game objects parent class
//

//..............Import Statements...........................................................................
import SpriteKit


class GameObject: SKSpriteNode {
    // Custom properties specific to game objects
    internal var gameObjectName: String // Name of the game object
    internal var gameObjectImage: SKTexture // Texture representing the game object

    // Custom initializer to set initial properties
    init(name: String, image: SKTexture) {
        self.gameObjectName = name
        self.gameObjectImage = image
        super.init(texture: image, color: .clear, size: image.size()) // Initialize with the provided texture
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Custom methods for game objects
    func update(sceneSize: CGSize) {
        // Implement custom update logic for game object
    }
    //............................................................. END OF CLASS ............................................................
}
