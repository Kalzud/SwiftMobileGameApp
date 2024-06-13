//
//  InstructionsScene.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
// 
//

//..............Import Statements...........................................................................
import SpriteKit

class InstructionsScene: SKScene {
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance
    private var instructions: [SKLabelNode] = []
    
    
    override func didMove(to view: SKView) {
        configureInstructions()
        backgroundColor = gameDataManager.backgroundColor
    }
    
    
    
    // MARK: - Configureinstructions
    func configureInstructions(){
        // .......Create and configure instructions................................................................
        let instructionLinel = SKLabelNode(fontNamed: "Helvetica")
        instructionLinel.text = "Tap available resources"
        instructionLinel.position = CGPoint(x: size.width * -20, y: size.height * 0.8)
        instructionLinel.fontColor = .orange
        
        let instructionLine2 = SKLabelNode(fontNamed: "Helvetica")
        instructionLine2.text = "to keep plant life"
        instructionLine2.position = CGPoint(x: size.width * -20, y: size.height * 0.75)
        instructionLine2.fontColor = .orange
        
        let instructionLine3 = SKLabelNode(fontNamed: "Helvetica")
        instructionLine3.text = "Lines shouldn't touch"
        instructionLine3.position = CGPoint(x: size.width * -20, y: size.height * 0.65)
        instructionLine3.fontColor = .orange
        
        let instructionLine4 = SKLabelNode(fontNamed: "Helvetica")
        instructionLine4.text = "HELPERS (Bees)"
        instructionLine4.position = CGPoint(x: size.width * -20, y: size.height * 0.6)
        instructionLine4.fontColor = .green
        
        let instructionLine5 = SKLabelNode(fontNamed: "Helvetica")
        instructionLine5.text = "Draw lines to kill"
        instructionLine5.position = CGPoint(x: size.width * -20, y: size.height * 0.45)
        instructionLine5.fontColor = .orange
        
        let instructionLine6 = SKLabelNode(fontNamed: "Helvetica")
        instructionLine6.text = "PESTS (Aphids)"
        instructionLine6.position = CGPoint(x: size.width * -20, y: size.height * 0.4)
        instructionLine6.fontColor = .red
        
        
        // ......Add instructions to instruction list.........................................................
        instructions.append(instructionLinel)
        instructions.append(instructionLine2)
        instructions.append(instructionLine3)
        instructions.append(instructionLine4)
        instructions.append(instructionLine5)
        instructions.append(instructionLine6)
        
        //.. Add instructions in list to scene and set font .....................................................
        for instruction in instructions{
            instruction.fontSize = 24
            addChild(instruction)
        }
        
        
        // Animate instructions ................................................................................
        let action1 = SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height * 0.8), duration: 0.5)
        let action2 = SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height * 0.75), duration: 0.5)
        let action3 = SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height * 0.65), duration: 1)
        let action4 = SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height * 0.6), duration: 1)
        let action5 = SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height * 0.5), duration: 1.5)
        let action6 = SKAction.move(to: CGPoint(x: size.width * 0.5, y: size.height * 0.45), duration: 1.5)

        
        // run animation instructions ........................................................................
        instructionLinel.run(action1)
        instructionLine2.run(action2)
        instructionLine3.run(action3)
        instructionLine4.run(action4)
        instructionLine5.run(action5)
        instructionLine6.run(action6)
    }
    
    func setUpbackgroundagain(){
        backgroundColor = gameDataManager.backgroundColor
//        configureInstructions()
    }
   
    // MARK: -end of class
}

