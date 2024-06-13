//
//  GameplayPageViewController.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This is the gamwe play controller it uses the gameplat scene and controls
//  the gestures and game pause setetings and action buttons
//


//..............Import Statements...........................................................................
import UIKit
import SpriteKit


class GameplayPageViewController: UIViewController, GameSceneDelegate{
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance    
    var scene : GameplayScene? // game scene for this game play controller
    
    //.................................. Interface attachments .....................................
    @IBAction func pauseAction(_ sender: Any) {
    // Check if the game is not over before showing the pause menu
        if !scene!.gameIsOver {
            showPauseMenu()
        }
    }
    @IBOutlet weak var bee: UIImageView!
    @IBOutlet weak var fertilizer: UIImageView!
    @IBOutlet weak var watercan: UIImageView!
    
    override func viewDidLoad() { //on load view
        super.viewDidLoad()
        view.backgroundColor = gameDataManager.backgroundColor // set up background color
        gameDataManager.setupBackgroundAudio(filename: "gameplayBackgroundMusic", volume: 1) // set up background music
        navigationItem.hidesBackButton = true // restrict navigation by hiding back button
        
        //..........Game play Scene setup.....................
        scene = GameplayScene(size: view.bounds.size)//set size to that of the current view
        scene?.gameSceneDelegate = self // Set the delegate
        let skView = view as! SKView // cast view of this contoller to type skView
        scene?.scaleMode = .resizeFill // scale scene content to fit dimensions of view
        skView.presentScene(scene) // add scene to view

        gameGestureSetup() // setup tap gestures for images
    }
    
    override func viewWillAppear(_ animated: Bool) { // on view showing
        super.viewWillAppear(animated)
        view.backgroundColor = gameDataManager.backgroundColor //set up the abckground color
    }
//..................................................................................................................................
    
    // MARK: - Gesture setups and functions
    func gameGestureSetup(){
        let watercanGesture = UITapGestureRecognizer(target: self,action: #selector(self.func1(_sender:)))
        watercan.isUserInteractionEnabled = true
        watercan.addGestureRecognizer(watercanGesture)
        
        let fertilizerGesture = UITapGestureRecognizer(target: self,action: #selector(self.func2(_sender:)))
        fertilizer.isUserInteractionEnabled = true
        fertilizer.addGestureRecognizer(fertilizerGesture)
        
        let beeGesture = UITapGestureRecognizer(target: self,action: #selector(self.func3(_sender:)))
        bee.isUserInteractionEnabled = true
        bee.addGestureRecognizer(beeGesture)
    }
    
    @objc func func1(_sender: UITapGestureRecognizer){
        scene?.setupWaterCan()
        print("Water the flowers")//print statement for testing purposes
    }
    
    @objc func func2(_sender: UITapGestureRecognizer){
        scene?.setupFertilizer()
        print("Feed the flowers")//print statement for testing purposes
    }
    
    @objc func func3(_sender: UITapGestureRecognizer){
        scene?.setupBee()
        print("Bring bees")//print statement for testing purposes
    }
    
    // MARK: - GameSceneDelegate Methods
    func didTapExitToGameEnd() {
        //go to game end view controller on exit
        if let gameEndViewController = storyboard?.instantiateViewController(withIdentifier: "GameendPageViewController") as? GameendPageViewController {
            navigationController?.pushViewController(gameEndViewController, animated: true)
            gameDataManager.setupBackgroundAudio(filename: "backgroundMusic", volume: 1) //change background music back to normal on exit
        }
    }
    
    // MARK: - GAME PAUSED
    func showPauseMenu() {
        
        scene?.gameIsPaused = true // pause the game
        
        //craete and initialise an alert controller
        let alertController = UIAlertController(title: "Paused", message: nil, preferredStyle: .actionSheet)
        
        let quitAction = UIAlertAction(title: "Quit", style: .destructive) { _ in
            self.quit()// Handle quit action
        }
        
        let soundActionTitle = gameDataManager.isSoundOn ? "Turn Off Sound" : "Turn On Sound"
        let toggleSoundAction = UIAlertAction(title: soundActionTitle, style: .default) { _ in
            self.toggleGameSound() // Handle toggle sound action
        }
        
        let lightBackgroundColorAction = UIAlertAction(title: "Light Theme", style: .default) { _ in
            self.makeBackgroundLight() //handle light background action
        }
        
        let darkBackgroundColorAction = UIAlertAction(title: "Dark Theme", style: .default) { _ in
            self.makeBackgroundDark() //handle dark background action
        }
            
        let resumeAction = UIAlertAction(title: "Resume", style: .cancel) { _ in
            self.resume() // handle resume action
        }
        
        //............... Add actions to alert controller.......................................
        alertController.addAction(quitAction)
        alertController.addAction(toggleSoundAction)
        alertController.addAction(lightBackgroundColorAction)
        alertController.addAction(darkBackgroundColorAction)
        alertController.addAction(resumeAction)
        
        // if statement to check if the device is an ipad and then center the alert if it is an ipad
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alertController.popoverPresentationController { //create popup contoller and initialise
                popoverController.sourceView = view //source this view
                popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0) // center the pop up
                popoverController.permittedArrowDirections = []
            }
        }
        
        present(alertController, animated: true, completion: nil) // show the alert controller
    }
    
    //...................................................................................
    func quit() {
        scene?.gameOver() // call game over
    }
    func makeBackgroundLight() {
        gameDataManager.updateBackgroundColor(color: .white)
        scene?.backgroundColor = gameDataManager.backgroundColor // reset scene background
        resume() // resume game after setting background
    }
    func makeBackgroundDark() {
        print("Changing background to dark theme")
        gameDataManager.updateBackgroundColor(color: .black)
        scene?.backgroundColor = gameDataManager.backgroundColor // reset scene background
        resume() // resume game after setting background
    }
    func toggleGameSound() { // check if sound is off or on and toggle based on it
        if (gameDataManager.isSoundOn){
            gameDataManager.stopSound()
        }else{
            gameDataManager.playSound()
        }
        resume() // resume game after setting sound
    }
    func resume(){
        scene?.gameIsPaused = false // resume game
    }
//............................................................ END OF CLASS .................................................................
}
