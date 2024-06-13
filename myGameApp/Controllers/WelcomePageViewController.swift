//
//  WelcomePageViewController.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//
// This is the contoller for the welcome page of the game

import UIKit


class WelcomePageViewController: UIViewController, UIViewControllerTransitioningDelegate{
    let fileManager = FileManager.shared // Access the shared FileManager instance
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance
    
    @IBOutlet weak var welcomeLabel: UILabel! // Welcome text
    
    //=============================================================================================================
    // on view loading
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setUpGestures()
    }
    // on view showing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        setUpGestures()
    }
    
    //==================================================================================================================
    func updateUI(){
        view.backgroundColor = GameDataManager.shared.backgroundColor // set to current game background color
        let currentPlayerName = GameDataManager.shared.currentPlayerName
            print("Entered Name: \(currentPlayerName)") // print out current player name for testing
        
        // Set the welcome label text to the current player's name
        welcomeLabel.text = "Welcome, \(currentPlayerName)!"
    }
    
    func setUpGestures(){
        // Create swipe gesture recognizer to left for play
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeGestureLeft.direction = .left
        view.addGestureRecognizer(swipeGestureLeft)
        
        // Create swipe gesture recognizer up for settings
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp))
        swipeGestureUp.direction = .up
        view.addGestureRecognizer(swipeGestureUp)
    }
    //=================================================================================================================
    
    // MARK: - SWIPE FUNCTIONS
    @objc func handleSwipeLeft() {
           // Performing navigation to the play page here
           navigateToPlay()
       }
    
    @objc func handleSwipeUp() {
           // Performing navigation to the settings page here
           navigateToSettings()
       }

    // MARK: - NAVIGATION FUNCTIONS
    func navigateToPlay() {
       if let instructionsController = storyboard?.instantiateViewController(withIdentifier: "InstructionsPageViewController") as? InstructionsPageViewController {
           navigationController?.pushViewController(instructionsController, animated: true)
       }
    }
    
    func navigateToSettings() {
        if let settingsController = storyboard?.instantiateViewController(withIdentifier: "SettingsPageViewController") as? SettingsPageViewController {
            navigationController?.pushViewController(settingsController, animated: true)
        }
    }
//.............................................. END OF CLASS ................................................................
}
