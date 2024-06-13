//
//  GameendPageViewController.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//
//  This is the controller for the game end view where highscores would
//  be shown and where the user can navigate to tahe tab controller

//..............Import Statements...........................................................................
import UIKit


class GameendPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let fileManager = FileManager.shared // Access the shared FileManager instance
    let gameDataManager = GameDataManager.shared // Access the shared GameDataManager instance
    let cellIdentifier = "myCellIdentifier2" // assigning field with identifier of table cell
    
    //........Set up labels and image view ...................................................
    @IBOutlet weak var highScoreText: UILabel!
    @IBOutlet weak var sadface: UIImageView!
    @IBOutlet weak var delightface: UIImageView!
    
    override func viewDidLoad() { // on view loading
        super.viewDidLoad()
        view.backgroundColor = gameDataManager.backgroundColor //set background
        navigationItem.hidesBackButton = true // control navigation by hiding back button
        delightface.isHidden = true // hide image view for UI effects
    }
    
    override func viewWillAppear(_ animated: Bool) { // on view showing
        super.viewWillAppear(animated)
        view.backgroundColor = gameDataManager.backgroundColor // set to current game background color
        delightface.isHidden = true // hide image view for UI effects
    }
    //..................................................................................................................
    
    
    // MARK: - TABLE METHODS
    
    // Implement UITableViewDelegate methods to customize cell height and spacing
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // Adjust cell height as needed
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20 // Add space at the bottom of each section
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20 // Add space at the top of each section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let top5Scores = getTop5Scores(players: readScoresFromFile())
            return top5Scores.count
    }
    
    // =========================== Set up each cell in the table ========================================================================
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let top5Scores = getTop5Scores(players: readScoresFromFile())
        let playerScore = top5Scores[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row + 1). Name: \(playerScore.name) Score: \(playerScore.score)" // Configure cell text
        cell.textLabel?.textColor = UIColor.orange // Set text color to orange
        cell.backgroundColor = UIColor.clear
        
        // Check if the current player ENTERED THE TOP 5
        if playerScore.name == gameDataManager.currentPlayerName && playerScore.score == gameDataManager.currentPlayerScore {
            print("Name: \(gameDataManager.currentPlayerName)")
            // Highlight the cell with a blue background color
            cell.backgroundColor = UIColor.blue
            delightface.isHidden = false
            sadface.isHidden = true
            highScoreText.text = "Congratulations!!! You made it to top 5"
        } else {
            // Reset the cell background color if not the current player
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }

    // MARK: - reading and getting top 5 scores
    
    // Retrieve the players' data and scores from a file, line by line
    func readScoresFromFile() -> [Player] {
        var players = [Player]()  // Initialize an empty array to store Player objects
        
        // Check if fileContents is successfully retrieved from readFileContents()
        if let fileContents = fileManager.readFileContents() {
            
            let lines = fileContents.components(separatedBy: .newlines) // Split fileContents into an array of lines
            
            // Iterate through each line in the file
            for line in lines {
                
                let components = line.components(separatedBy: ",") // Split each line into components using comma as the separator
                
                // Check if the line contains exactly two components (name and score)
                if components.count == 2 {
                    // Extract player name and score from the components
                    let playerName = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    let scoreString = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let score = Int(scoreString) ?? 0 // Convert scoreString to an integer; default to 0 if conversion fails
                    
                    let player = Player(name: playerName, score: score) // Create a Player object with the extracted name and score
                    
                    players.append(player) // Add the Player object to the players array
                }
            }
        }
        return players  // Return the array of Player objects read from the file
    }

    // Get the top 5 players with the highest scores from the given array of players
    func getTop5Scores(players: [Player]) -> [Player] {
        let sortedPlayerScores = players.sorted { $0.score > $1.score } // Sort the array of players based on their scores in descending order
        let top5Scores = Array(sortedPlayerScores.prefix(5)) // Extract the top 5 players with the highest scores from the sorted array
        return top5Scores // Return the array containing the top 5 players with the highest scores
    }
//............................................................. END OF CLASS ............................................................
}
