//
//  Player.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//  This is the player object
//


class Player{
    // Properties
    var name: String
    var score: Int

    // Initializer (Constructor)
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }

    // Method to display player information
    func displayPlayerInfo() {
        print("Player Name: \(name), Score: \(score)")
    }

    // Method to update player's score
    func updateScore(newScore: Int) {
        score = newScore
        print("\(name)'s score updated to \(score)")
    }
    //............................................................. END OF CLASS ............................................................
}
