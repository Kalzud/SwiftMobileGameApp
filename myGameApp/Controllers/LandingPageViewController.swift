//
//  LandingPageViewController.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//
//  This class is the controller of the landing page view and controls all the actions on the landing page


//.........Import Statements.................
import UIKit


class LandingPageViewController: UIViewController, UITextFieldDelegate {
    let fileManager = FileManager.shared // Access the shared FileManager instance
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance
    var players: [Player] = []  // initialise arraylist of players
    
    
    //==================================================================================================================
    @IBOutlet weak var nameInput: UITextField! // Text field for entering the player's name
    // next button action handler
    @IBAction func nextButtonHandler(_ sender: Any) {
        // Check if the name input field is empty
        guard let text = nameInput.text, !text.isEmpty else {
            // Show an alert to prompt the user to enter a name if it is empty
            showAlert(message: "Please enter a name.")
            return
        }

        let enteredText = text //assign input field value to entered text
        print("Entered text: \(enteredText)") // print out entered text value for testing purposes
        
        // Create a new Player object with text from input field and add it to the players array
        let newPlayer = Player(name: text, score: 0)  // initialise new player with name in input text field and 0 score
        gameDataManager.currentPlayerName = nameInput.text ?? "" // update game data with name in input field
        players.append(newPlayer) // add new player to array list of players
    }
    
    //========================================================================================================================
    //============= Initial method to run on load ==========================
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = gameDataManager.backgroundColor // set to current game background color
        nameInput.delegate = self // Set the delegate for the nameInput text field
        gameDataManager.setupBackgroundAudio(filename: "backgroundMusic", volume: 1) // set up the game background music
        
//        fileManager.clearFile()
        // =====Set custom text color for tab bar item===========
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24.0),
            .foregroundColor: UIColor.orange
        ]
        tabBarItem.setTitleTextAttributes(attributes, for: .normal)
    }
    
    //======= Method to run when this view shows/appears =========
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = gameDataManager.backgroundColor // set to current game background color
        nameInput.delegate = self // Set the delegate for the nameInput text field
    }
    
    //===================================================
    // Helper method to show empty input alert message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //=========================================
    // text fied checker to ensure not more than 6 characters are put in the name
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if the text field is the nameInput and if the new text length exceeds 6 characters
        if textField == nameInput {
            // Calculate the new text length after replacement
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            // Limit the length to 6 characters
            return newText.count <= 6
        }
        return true
    }
//.........................................End of class.............................................................................
}

