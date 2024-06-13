//
//  Sunflower.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//  This is the sunflower object
//

//..............Import Statements...........................................................................
import SpriteKit

class Sunflower: GameObject {
    private var sceneSize: CGSize

    init(sceneSize: CGSize) {
        // Initialize player with a specific texture and name
        let Image = SKTexture(imageNamed: "sunflower")
        self.sceneSize = sceneSize
        super.init(name: "Sunflower", image: Image)

        update(sceneSize: sceneSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(sceneSize: CGSize) {}
    //............................................................. END OF CLASS ............................................................
}
