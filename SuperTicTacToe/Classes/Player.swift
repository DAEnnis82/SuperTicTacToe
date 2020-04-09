//
//  File.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/9/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

class Player {
    
    private var name : String
    private var power: Int
    private var accountType: Int //0 for premade guest account, 1 for user made player account
    private var playerImage: UIImage? 
    private var stndWins = 0
    private var sprWins = 0
    private var stndLoses = 0
    private var sprLoses = 0
    
    
    init(pName: String, pPower: Int, accountType: Int) {
        self.name = pName
        self.power = pPower
        self.accountType = accountType
    }
    
    init(pName: String, pPower: Int, stndWins: Int, stndLoses: Int, sprWins: Int, sprLoses: Int, accountType: Int) {
        
        self.name = pName
        self.power = pPower
        self.stndWins = stndWins
        self.stndLoses = stndLoses
        self.sprWins = sprWins
        self.sprLoses = sprLoses
        self.accountType = accountType
    }
    
    init(pName: String, pPower: Int, stndWins: Int, stndLoses: Int, sprWins: Int, sprLoses: Int, accountType: Int, playerImage: UIImage?) {
        
        self.name = pName
        self.power = pPower
        self.stndWins = stndWins
        self.stndLoses = stndLoses
        self.sprWins = sprWins
        self.sprLoses = sprLoses
        self.playerImage = playerImage
        self.accountType = accountType
    }
    
    func playerWonStnd() {
        stndWins += 1
        CoreDataManager.shared.updateSavedPlayerData(player: self)
    }
    
    func playerLostStnd() {
        stndLoses += 1
        CoreDataManager.shared.updateSavedPlayerData(player: self)
    }
    
    func playerWonSpr() {
        sprWins += 1
        CoreDataManager.shared.updateSavedPlayerData(player: self)
    }
    
    func playerLostSpr() {
        sprLoses += 1
        CoreDataManager.shared.updateSavedPlayerData(player: self)
    }
    
    //called when a player chooses to edit thier profile and updates their name
    func updateName(newName: String) {
        name = newName
        CoreDataManager.shared.updateSavedPlayerData(player: self)
    }
    
    //called when a player chooses to edit thier profile and updates their super power
    func updatePower(newPower: Int) {
        power = newPower
        CoreDataManager.shared.updateSavedPlayerData(player: self)
        
    }
    
    //returns the players name
    func getPlayerName() -> String {
        return name
        
    }
    
    func getPlayerImage() -> UIImage? {
        if playerImage != nil {
            return playerImage
        } else {
            return nil
        }
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
    
    func getAccountType() -> Int {
        return accountType
    }
    
    func setAccountType(accountType: Int) {
        self.accountType = accountType
    }
    
    
    
}
