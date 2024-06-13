//
//  GameplayScene.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  This class controls the game paly all its animations , and plays etc....
//

//..............Import Statements...........................................................................
import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    let fileManager = FileManager.shared // Access the shared FileManager instance
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance
    
    //.............. Game logic varaibles ...............................................................
    var heartGameObjects: [GameObject] = [] // list for heart objects to show players game life
    var gameIsOver: Bool = false // based on the field actions woud be allowed or disallowed during gameover
    var gameIsPaused: Bool = false // based on the field actions woud be allowed or disallowed during pause
    var currentLine: SKShapeNode? // the lines drawn by player would be assigned to this field
    var score: Int = 0
    var life: Int = 100

    //..................... Catgories for the game objects...................................................
    let aphidCategory: UInt32 = 0
    let beeCategory: UInt32 = 0x1 << 0
    let sunflowerCategory: UInt32 = 0x1 << 1
    let lineCategory: UInt32 = 0x1 << 2
    
    //...........Protocol for the gameOver node....................
    weak var gameSceneDelegate: GameSceneDelegate?
    

// MARK: - FUNCTIONS
//========================================================================================================================================
    
    override func didMove(to view: SKView) {// on the scene loaded
        backgroundColor = gameDataManager.backgroundColor // set the background color to the color in gameDataManager
        physicsWorld.contactDelegate = self // set up delegate to manage physics related aspects in scene

        if !gameIsPaused { // if the game is not paused
            setupSunflower()
            gameLogicForAphid()
            getScore()
            updateLife(change: 0)
        }
        //Set up a timer to get palyers score repeatedly
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.getScore()
        }
    }
    
// MARK: -  Collision detections
    func didBegin(_ contact: SKPhysicsContact) {
        if !gameIsPaused {
            //================= Handle collision between the aphid object and the line drawn object ======================================
            if (contact.bodyA.categoryBitMask == aphidCategory && contact.bodyB.categoryBitMask == lineCategory) ||
               (contact.bodyA.categoryBitMask == lineCategory && contact.bodyB.categoryBitMask == aphidCategory) {
                gameAlert(text: "Aphid destroyed", colorName: "blue", width: 0.5, height: 0.71)
                print("Aphid collided with a line") //print statement for testingg
                updateScore(points: 3)
                gameDataManager.playGameInteractionSound(filename: "kill", timer: 2.0)
                // Get the nodes involved in the collision
                if let aphidNode = contact.bodyA.node as? Aphid ?? contact.bodyB.node as? Aphid,
                   let lineNode = contact.bodyA.node as? SKShapeNode ?? contact.bodyB.node as? SKShapeNode {
                    // Remove aphidNode and lineNode from the scene
                    aphidNode.removeFromParent()
                    lineNode.removeFromParent()
                }
            } else //================= Handle collision between the sunflower object and the bee object ===================================
            if (contact.bodyA.categoryBitMask == sunflowerCategory && contact.bodyB.categoryBitMask == beeCategory) ||
               (contact.bodyA.categoryBitMask == beeCategory && contact.bodyB.categoryBitMask == sunflowerCategory) {
                gameAlert(text: "Pollinated: extralife +10", colorName: "blue", width: 0.5, height: 0.74)
                print("bee collided with sunflower") //print statement for testing
                updateLife(change: 10)
                // Set up a timer to remove the bee object after it pollinates
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                    // Ensure self still exists before attempting to remove the node
                    guard self != nil else { return }
                    if let beeNode = contact.bodyA.node as? Bee ?? contact.bodyB.node as? Bee{ // check to see if its the bee node
                          // Remove beeNode from parent
                          beeNode.removeFromParent()
                      }
                }
            }else
            if (contact.bodyA.categoryBitMask == beeCategory && contact.bodyB.categoryBitMask == lineCategory) ||
                (contact.bodyA.categoryBitMask == lineCategory && contact.bodyB.categoryBitMask == beeCategory)  {
                gameAlert(text: "Bee fled your lines", width: 0.5, height: 0.66)
                print("bee collided with lines") //print statement for testing
                updateScore(points: -1)
                if let beeNode = contact.bodyA.node as? Bee ?? contact.bodyB.node as? Bee,
                   let lineNode = contact.bodyA.node as? SKShapeNode ?? contact.bodyB.node as? SKShapeNode{
                      // Remove beeNode and lineNode from the scene
                      beeNode.removeFromParent()
                      lineNode.removeFromParent()
                  }
            }else
            if (contact.bodyA.categoryBitMask == aphidCategory && contact.bodyB.categoryBitMask == sunflowerCategory) ||
                (contact.bodyA.categoryBitMask == sunflowerCategory && contact.bodyB.categoryBitMask == aphidCategory)  {
                gameAlert(text: "Aphids!!! Ouch", colorName: "red", width: 0.5, height: 0.64)
                print("aphid ate plant") //print statement for testing
                updateLife(change: -1)
            }
        }
    }


    // MARK: - Physiscs interactions
    
    // Called when the user begins touching the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameIsPaused {
            // If the game is not paused, handle touch events to draw lines
            guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            setupCurrentLine(at: location) // Setup a new line at the touch location
        } else {
            // If the game is paused, handle touch events for UI interaction (e.g., tapping exit button)
            for touch in touches {
                let location = touch.location(in: self)
                let touchedNode = self.atPoint(location)
                if let nodeName = touchedNode.name, nodeName == "exitButton" {
                    // If the touched node is the exit button, notify the game scene delegate to exit
                    gameSceneDelegate?.didTapExitToGameEnd()
                    print("exit")
                }
            }
        }
    }
    //.....................................................................................................................
    // Called when the user moves their finger while touching the screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameIsPaused {
            // If the game is not paused, handle touch events to draw lines
            guard let touch = touches.first, let line = currentLine else { return }
            let location = touch.location(in: self)
            
            // Update the path of the current line to follow the user's finger movement
            if let path = line.path {
                let mutablePath = CGMutablePath()
                mutablePath.addPath(path)
                mutablePath.addLine(to: location)
                line.path = mutablePath
                
                // Play game interaction sound when drawing lines
                gameDataManager.playGameInteractionSound(filename: "linedrawn", timer: 2.0)
            }
        }
    }
    //.....................................................................................................................
    // Called when the user stops touching the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameIsPaused {
            // If the game is not paused, finalize the current drawn line
            if let currentLine = currentLine {
                // Create a physics body for the line and configure its properties
                currentLine.physicsBody = SKPhysicsBody(edgeChainFrom: currentLine.path!)
                currentLine.physicsBody?.categoryBitMask = lineCategory
                currentLine.physicsBody?.contactTestBitMask = aphidCategory | beeCategory
                currentLine.physicsBody?.isDynamic = false // Lines are static (non-moving)
            }
            // Clear the reference to the current line (line drawing is completed)
            currentLine = nil
        }
    }
    //.....................................................................................................................
    // Helper method to set up a new line node at a given location
    func setupCurrentLine(at location: CGPoint) {
        if !gameIsPaused {
            // If the game is not paused, create a new shape node for drawing lines
            let newLine = SKShapeNode()
            newLine.strokeColor = .red
            newLine.lineWidth = 5

            // Create a UIBezierPath starting at the specified location
            let path = UIBezierPath()
            path.move(to: location)
            newLine.path = path.cgPath

            // Add the new line node to the scene and set it as the current line
            addChild(newLine)
            currentLine = newLine
        }
    }
    
    // MARK: - Gameobject set up methods
    func setupAphid() {
        if !gameIsPaused {
            let randomNumber = randomDecimalInRange()
            print("Random number: \(randomNumber)") // print statement for testing
            
            let aphid = Aphid(sceneSize: self.size)
            aphid.position = CGPoint(x: size.width * randomNumber, y: size.height * randomNumber)
            aphid.size = CGSize(width: 60, height: 60)
            aphid.physicsBody = SKPhysicsBody(rectangleOf: aphid.size)
            aphid.physicsBody?.categoryBitMask = aphidCategory
            aphid.physicsBody?.contactTestBitMask = lineCategory | sunflowerCategory
            aphid.physicsBody?.isDynamic = true
            addChild(aphid)
        }
    }
    //=============================================================================
    func setupBee() {
        if !gameIsPaused {
            let randomNumber = randomDecimalInRange()
            print("Random number: \(randomNumber)") // print statement for testing
            
            let bee = Bee(sceneSize: self.size)
            bee.position = CGPoint(x: size.width * randomNumber, y: size.height * randomNumber)
            bee.size = CGSize(width: 70, height: 70)
            bee.physicsBody = SKPhysicsBody(rectangleOf: bee.size)
            bee.physicsBody?.categoryBitMask = beeCategory
            bee.physicsBody?.contactTestBitMask = sunflowerCategory | lineCategory
            bee.physicsBody?.isDynamic = true
            addChild(bee)
 
            gameDataManager.playGameInteractionSound(filename: "bees", timer: 4.0)
        }
    }
    //=============================================================================
    func setupSunflower() {
        if !gameIsPaused {
            let sunflower1 = Sunflower(sceneSize: self.size)
            let sunflower2 = Sunflower(sceneSize: self.size)
            let sunflower3 = Sunflower(sceneSize: self.size)
            let sunflower4 = Sunflower(sceneSize: self.size)
            let sunflower5 = Sunflower(sceneSize: self.size)


            sunflower1.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
            sunflower2.position = CGPoint(x: size.width * 0.7, y: size.height * 0.5)
            sunflower3.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
            sunflower4.position = CGPoint(x: size.width * 0.6, y: size.height * 0.4)
            sunflower5.position = CGPoint(x: size.width * 0.4, y: size.height * 0.4)

            var sunflowerGameObjects: [GameObject] = []

            sunflowerGameObjects.append(sunflower1)
            sunflowerGameObjects.append(sunflower2)
            sunflowerGameObjects.append(sunflower3)
            sunflowerGameObjects.append(sunflower4)
            sunflowerGameObjects.append(sunflower5)

            for sunflower in sunflowerGameObjects{
                sunflower.size = CGSize(width: 100, height: 100)
                sunflower.physicsBody = SKPhysicsBody(rectangleOf: sunflower.size)
                sunflower.physicsBody?.categoryBitMask = sunflowerCategory
                sunflower.physicsBody?.contactTestBitMask = beeCategory | aphidCategory
                sunflower.physicsBody?.isDynamic = false
                addChild(sunflower)
            }
        }
    }
    //=============================================================================
    func setupWaterCan() {
        if !gameIsPaused {
            let watercan = Watercan(sceneSize: self.size)
            watercan.position = CGPoint(x: size.width * 0.2, y: size.height * 0.1)
            watercan.size = CGSize(width: 80, height: 80)
            
            // Set up physics properties
            watercan.physicsBody = SKPhysicsBody(rectangleOf: watercan.size)
            watercan.physicsBody?.isDynamic = false

            // Add watercan node to the scene
            addChild(watercan)
            
            // Set up a timer to remove the watercan node after 5 seconds
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
                // Ensure self still exists before attempting to remove the node
                guard self != nil else { return }
                // Remove the watercan node from the scene
                watercan.removeFromParent()
            }
            
            print("watered") //print statement for tetsting
            updateLife(change: 5)
            gameAlert(text: "Yummy!!!: Extra life +5", colorName: "blue", width: 0.5, height: 0.68)
            gameDataManager.playGameInteractionSound(filename: "water", timer: 2.0)
        }
    }
    //=============================================================================
    func setupFertilizer() {
        if !gameIsPaused {
            let fertilizer = Fertilizer(sceneSize: self.size)
            fertilizer.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
            fertilizer.size = CGSize(width: 70, height: 70)
            
            // Set up physics properties
            fertilizer.physicsBody = SKPhysicsBody(rectangleOf: fertilizer.size)
            fertilizer.physicsBody?.isDynamic = false

            // Add watercan node to the scene
            addChild(fertilizer)
            
            // Set up a timer to remove the fertilizer node after 5 seconds
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
                // Ensure self still exists before attempting to remove the node
                guard self != nil else { return }
                // Remove the fertilizer node from the scene
                fertilizer.removeFromParent()
            }
            
            print("food")
            updateLife(change: 8)
            gameAlert(text: "Yummy!!!: Extra life +8", colorName: "blue", width: 0.5, height: 0.68)
            gameDataManager.playGameInteractionSound(filename: "food", timer: 2.0)
        }

    }
    
    // MARK: - Gameplay logic functions
    
    func randomDecimalInRange() -> Double {
        // Generate a random decimal number between 0.1 and 0.9
        let randomValue = Double.random(in: 0.1..<0.9)
        return randomValue
    }
    //..................................................................................................................
    func gameAlert(text: String, colorName: String = "orange", width: CGFloat, height: CGFloat) {
        // Create a new SKLabelNode
        let gameAlert = SKLabelNode(fontNamed: "Helvetica")

        // Set the text and properties of the label based on the provided parameters
        gameAlert.text = text
        gameAlert.position = CGPoint(x: size.width * width, y: size.height * height)

        switch colorName.lowercased() {
               case "red":
                   gameAlert.fontColor = .red
               case "blue":
                   gameAlert.fontColor = .blue
               case "green":
                   gameAlert.fontColor = .green
               default:
                   gameAlert.fontColor = .orange // Default to orange if colorName is not recognized
           }

        // Add the label to the scene
        addChild(gameAlert)

        // Set up a timer to remove the gamealert node after 1.5 seconds
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [weak self] _ in
            // Ensure self still exists
            guard self != nil else { return }
            // Remove the alert
            gameAlert.removeFromParent()
        }
    }
    //..................................................................................................................
    func gameLogicForAphid(){
        if !gameIsPaused {
            // add aphids every 5 seconds
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
                // Ensure self still
                guard self != nil else { return }
                for _ in 1...3 {
                    self?.setupAphid()
                    }
            }
        }
    }
    //..................................................................................................................
    func getScore(){
        if !gameIsOver {
            // Create a new SKLabelNode
            let scoreText = SKLabelNode(fontNamed: "Helvetica")
            
            // Set the text and properties of the label based on the provided parameters
            scoreText.text = "SCORE: \(score)"
            scoreText.position = CGPoint(x: size.width * 0.22, y: size.height * 0.8)
            scoreText.fontColor = .orange // Default to orange if colorName is not recognized
            scoreText.fontSize = 25
            // Add the label to the scene
            addChild(scoreText)
            
            
            // Set up a timer to remove score text
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                // Ensure self still exists before attempting to remove the node
                guard self != nil else { return }
                
                // Remove the score text from the scene
                scoreText.removeFromParent()
            }
        }
    }
    //..................................................................................................................
    func updateScore(points: Int){
        score += points
        // Create a new SKLabelNode
        let pointsShow = SKLabelNode(fontNamed: "Helvetica")
        // Set the text and properties of the label based on provided parameters
        pointsShow.text = "\(points)"
        pointsShow.position = CGPoint(x: size.width * 0.1, y: size.height * 0.4)
        pointsShow.fontColor = .orange
        pointsShow.fontSize = 25

        //set action animation for the text
        let action = SKAction.move(to: CGPoint(x: size.width * 0.1, y: size.height * 0.8), duration: 6)
        pointsShow.run(action)
        // Add score animation to scene
        addChild(pointsShow)
        
        gameDataManager.playGameInteractionSound(filename: "score", timer: 1.5)

        // Set up a timer to remove the score animation
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            // Ensure self still exists
            
            guard self != nil else { return }
            pointsShow.removeFromParent()//remove score animation from the scene
        }
    }
    //..................................................................................................................
    func updateLife(change: Int) {
        let newLife = life + change
        life = max(0, min(100, newLife)) // Clamp newLife between 0 and 100
        print(life)
        
        if life <= 40{
            gameAlert(text: "Life is critically LOW", colorName: "red", width: 0.5, height: 0.76)
        }

        if life <= 0 {
            print("GAME OVER")
            gameOver()
        }

        // Determine number of hearts needed based on the life value
        let heartsNeeded = (life + 20) / 20 // Calculate number of hearts needed (1-5)

        // Update heartGameObjects based on the number of hearts needed
        updateHeartsDisplay(heartsNeeded: heartsNeeded)
    }
    //..................................................................................................................
    func updateHeartsDisplay(heartsNeeded: Int) {
        // Ensure heartGameObjects array contains at most 5 hearts
        let maxHeartsAllowed = 5
        let heartsToDisplay = min(heartsNeeded, maxHeartsAllowed) // Limit to maximum of 5 hearts
        
        // Add hearts if needed
        while heartGameObjects.count < heartsToDisplay {
            let newHeart = Heart(sceneSize: self.size)
            let heartIndex = heartGameObjects.count
            let heartXPosition = size.width * CGFloat(heartIndex + 1) * 0.1 // Calculate x position for the new heart
            newHeart.position = CGPoint(x: heartXPosition, y: size.height * 0.85)
            newHeart.size = CGSize(width: 30, height: 30)
            addChild(newHeart)
            heartGameObjects.append(newHeart)
        }
        
        // Remove excess hearts if more than 5 are displayed
        while heartGameObjects.count > heartsToDisplay {
            if let lastHeart = heartGameObjects.popLast() {
                lastHeart.removeFromParent()
            }
        }
    }
    //..................................................................................................................
    func gameOver() {
        gameIsOver = true
        gameIsPaused = true // Pause game updates
        
        print("game done")
        gameDataManager.currentPlayerScore = score
        fileManager.writeToFile("\(gameDataManager.currentPlayerName),\(gameDataManager.currentPlayerScore)\n")
        
        // Display game over screen
        let gameOverNode = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.5), size: self.size)
        gameOverNode.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(gameOverNode)
        
        // Game over message
        let gameOverLabel = SKLabelNode(fontNamed: "Helvetica")
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.fontSize = 36
        gameOverLabel.fontColor = .white
        gameOverLabel.position = CGPoint(x: 0, y: gameOverNode.size.height * 0.3) // Position relative to gameOverNode
        gameOverNode.addChild(gameOverLabel)
        
        // Score message
        let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.text = "SCORE: \(score)"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: 0, y: gameOverNode.size.height * 0.1) // Position relative to gameOverNode
        gameOverNode.addChild(scoreLabel)
        
        // Exit button
        let exitButton = SKLabelNode(fontNamed: "Helvetica")
        exitButton.text = "Exit"
        exitButton.fontSize = 36
        exitButton.fontColor = .white
        exitButton.position = CGPoint(x: 0, y: -gameOverNode.size.height * 0.3) // Position relative to gameOverNode
        exitButton.name = "exitButton"
        gameOverNode.addChild(exitButton)
    }
    //..................................................................................................................
    // Method to toggle game pause state
       func togglePause() {
           gameIsPaused = !gameIsPaused
       }
    //............................................................. END OF CLASS ............................................................
}












