//
//  Aphid.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//  This is the aphid object


//..............Import Statements...........................................................................
import SpriteKit

class Aphid: GameObject {
    private var sceneSize: CGSize 

    init(sceneSize: CGSize) {
        let Image = SKTexture(imageNamed: "aphid")
        self.sceneSize = sceneSize
        super.init(name: "Aphid", image: Image)
        update(sceneSize: sceneSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomNumInRange() -> Int {
        // Generate a random integer between 1 and 3 (inclusive)
        let randomValue = Int.random(in: 1...3)
        return randomValue
    }


    override func update(sceneSize: CGSize) {
        // Implement custom update logic for the aphid
        let action1 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.5, y: sceneSize.height * 0.8), duration: 1)
        let action2 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.1, y: sceneSize.height * 0.5), duration: 2)
        let action3 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.3, y: sceneSize.height * 0.6), duration: 3)
        let action4 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.3, y: sceneSize.height * 0.4), duration: 4)
        let action5 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.9, y: sceneSize.height * 0.9), duration: 2)
        let action6 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.4, y: sceneSize.height * 0.7), duration: 5)
        let action7 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.9, y: sceneSize.height * 0.1), duration: 2)
        let action8 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.7, y: sceneSize.height * 0.9), duration: 3)
        let action9 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.35, y: sceneSize.height * 0.78), duration: 1)
        let action10 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.96, y: sceneSize.height * 0.15), duration: 2)
        let action11 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.12, y: sceneSize.height * 0.4), duration: 3)
        let action12 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.25, y: sceneSize.height * 0.6), duration: 2)
        let action13 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.42, y: sceneSize.height * 0.5), duration: 1)
        let action14 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.17, y: sceneSize.height * 0.9), duration: 3)
        let action15 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.75, y: sceneSize.height * 0.71), duration: 2)
        let action16 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.57, y: sceneSize.height * 0.1), duration: 2)
        let action17 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.68, y: sceneSize.height * 0.9), duration: 6)
        let action18 = SKAction.move(to: CGPoint(x: sceneSize.width * 0.54, y: sceneSize.height * 0.64), duration: 3)
        
        
        let sequence1 = SKAction.sequence([action1, action2, action3, action4, action5, action6])
        let sequence2 = SKAction.sequence([action7, action8, action9, action10, action11, action12])
        let sequence3 = SKAction.sequence([action13, action14, action15, action16, action17, action18])
        
        let randomNumber = randomNumInRange()
        
        //to randomise the movements of variuos aphids taht would be called
        switch randomNumber {
            case 1:
            self.run(SKAction.repeatForever(sequence1))
            case 2:
            self.run(SKAction.repeatForever(sequence2))
            case 3:
            self.run(SKAction.repeatForever(sequence3))
            default:
                break
        }
    }
    //............................................................. END OF CLASS ............................................................
}

