//
//  InstructionsPageViewController.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This is the contoller for the instructions view it would make use of the instructions scene for its view
//

//..............Import Statements...........................................................................
import UIKit
import SpriteKit


class InstructionsPageViewController: UIViewController{
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance
    var scene : InstructionsScene? // Initialise scene for this view controller
    
//...............................................................................................................................................
    override func viewDidLoad() {
        super.viewDidLoad()
        InstructructionsSceneSetup() // set up tehh scene for this controller
        view.backgroundColor = gameDataManager.backgroundColor // set to current game background color
        scene?.setUpbackgroundagain() // reinitlaise the background setup of teh instruction scene when this view is called
        
        // Create swipe gesture recognizer left for play
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeGestureLeft.direction = .left
        view.addGestureRecognizer(swipeGestureLeft)
        
        // Set custom text color for tab bar item
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24.0),
            .foregroundColor: UIColor.orange
        ]
        tabBarItem.setTitleTextAttributes(attributes, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = gameDataManager.backgroundColor // set to current game background color
        scene?.setUpbackgroundagain()
    }
//...............................................................................................................................................

    func InstructructionsSceneSetup(){
        scene = InstructionsScene(size: view.bounds.size)
        let skView = view as! SKView
        scene?.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    @objc func handleSwipeLeft() {
           // Perform navigation to the gameplay page here
           navigateToPlay()
       }
    
    func navigateToPlay() {
        if let playController = storyboard?.instantiateViewController(withIdentifier: "GameplayPageViewController") as? GameplayPageViewController {
            navigationController?.pushViewController(playController, animated: true)
        }
    }
//......................................................... END OF CLASS............................................................................
}
