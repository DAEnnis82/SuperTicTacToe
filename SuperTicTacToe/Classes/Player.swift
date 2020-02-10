//
//  File.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/9/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import Foundation
import UIKit

class Player {
    
    private var name : String
    private var power: Int
    private var playerImage = UIImage(named: "PlayerImagePlaceholder")
    private var stndWins = 0
    private var sprWins = 0
    private var stndLoses = 0
    private var sprLoses = 0
    
    
    init(pName: String, pPower: Int) {
        self.name = pName
        self.power = pPower
    }
    
    func playerWonStnd() {
        stndWins += 1
    }
    
    func playerLostStnd() {
        stndLoses += 1
    }
    
    func playerWonSpr() {
        sprWins += 1
    }
    
    func playerLostSpr() {
        sprLoses += 1
    }
    
    //called when a player chooses to edit thier profile and updates their name
    func updateName(newName: String) {
        name = newName
    }
    
    //called when a player chooses to edit thier profile and updates their super power
    func updatePower(newPower: Int) {
        power = newPower
    }
    
    //returns the players name
    func getPlayerName() -> String {
        return name
    }
    
    func getPlayerImage() -> UIImage {
        return playerImage!
    }
    
    //returns standard mode wins and loses
    func getStndWinsLoses() -> (currentStndWins: Int, currentStndLoses: Int) {
        return (stndWins, stndLoses)
    }
    
    //returns super mode wins and loses
    func getSprWinsLoses() -> (currentSprWins: Int, currentSprLoses: Int) {
        return (sprWins, sprLoses)
    }
    
    //returns the current number of total wins and losses for the player
    func getAllWinsLoses() -> (allWins: Int, allLoses: Int) {
        let totalWins = stndWins + sprWins
        let totalLoses = stndLoses + sprLoses
        
        return (totalWins, totalLoses)
    }
    
    //returns the code for which power the player chose, if the player chose "random" as their power then a random number of the other possible
    //powers is returned each time (this method is called at start of each new game, the method displayPower() is called while viewing player profiles
    //to show that the player has a set or random power
    func getPower() -> Int {
        if (power == 0){
            return Int.random(in: 1..<4)
        } else {
            return power
        }
    }
    
    //returns the int value of power, this method is called while viewing player profiles to accurately display that the player has either a a chosen static power or a random one
    func displayPower() -> Int {
        return power
    }
    
    
    
    
    
}
