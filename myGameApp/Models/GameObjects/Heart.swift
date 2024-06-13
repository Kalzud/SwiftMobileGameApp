//
//  Heart.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//  This is the heart object
//

//..............Import Statements...........................................................................
import SpriteKit

class Heart: GameObject {
    private var sceneSize: CGSize

    init(sceneSize: CGSize) {
        // Initialize player with a specific texture and name
        let Image = SKTexture(imageNamed: "heart")
        self.sceneSize = sceneSize
        super.init(name: "Heart", image: Image)

        update(sceneSize: sceneSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(sceneSize: CGSize) {}
    //............................................................. END OF CLASS ............................................................
}
