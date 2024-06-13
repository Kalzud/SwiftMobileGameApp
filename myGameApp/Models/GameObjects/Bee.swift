//
//  Bee.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//  This is the bee object
//

//..............Import Statements...........................................................................
import SpriteKit

class Bee: GameObject {
    private var sceneSize: CGSize
    

    init(sceneSize: CGSize) {
        // Initialize player with a specific texture and name
        let Image = SKTexture(imageNamed: "bee")
        self.sceneSize = sceneSize
        super.init(name: "Bee", image: Image)

        update(sceneSize: sceneSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(sceneSize: CGSize) {
        // Implement custom update logic for the bee
        let action1 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.9, y: sceneSize.height * 0.1), duration: 2)
        let action2 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.1, y: sceneSize.height * 0.9), duration: 3)
        let action3 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.5, y: sceneSize.height * 0.6), duration: 2)
        let action4 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.3, y: sceneSize.height * 0.4), duration: 4)
        let action5 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.9, y: sceneSize.height * 0.9), duration: 2)
        let action6 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.4, y: sceneSize.height * 0.7), duration: 2)
        let sequence = SKAction.sequence([action1,action2, action3, action4, action5, action6])
        self.run(SKAction.repeatForever(sequence))
    }
    //............................................................. END OF CLASS ............................................................
}
