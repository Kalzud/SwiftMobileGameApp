//
//  Fertilizer.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//  This is the fertilizer object
//

//..............Import Statements...........................................................................
import SpriteKit

class Fertilizer: GameObject {
    private var sceneSize: CGSize

    init(sceneSize: CGSize) {
        // Initialize player with a specific texture and name
        let Image = SKTexture(imageNamed: "fertilizer")
        self.sceneSize = sceneSize
        super.init(name: "Fertilizer", image: Image)
        update(sceneSize: sceneSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(sceneSize: CGSize) {
        // Implement custom update logic for the fertilizer
        let action1 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.5, y: sceneSize.height * 0.5), duration: 2)
        self.run(action1)
    }
    //............................................................. END OF CLASS ............................................................
}
