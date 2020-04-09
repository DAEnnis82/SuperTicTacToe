//
//  PlayerTableDataManager.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/10/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//


import UIKit

final class PlayerTable {
        
    private var player : Player?
    private var coreDataArray = [SavedPlayer]()
    private var playertable = [Player]()
    
    static let shared = PlayerTable()
    
    private init() {
        if let coreDataArray = CoreDataManager.shared.pullDataFromCoreData() {
            for savedPlayer in coreDataArray {
                var player: Player
                if savedPlayer.playerImage != nil {
                    player = Player(pName: savedPlayer.name!, pPower: Int(savedPlayer.power), stndWins: Int(savedPlayer.stndWins), stndLoses: Int(savedPlayer.stndLoses), sprWins: Int(savedPlayer.sprWins), sprLoses: Int(savedPlayer.sprLoses), accountType: Int(savedPlayer.accountType), playerImage: UIImage(data: savedPlayer.playerImage!))
                } else {
                    player = Player(pName: savedPlayer.name!, pPower: Int(savedPlayer.power), stndWins: Int(savedPlayer.stndWins), stndLoses: Int(savedPlayer.stndLoses), sprWins: Int(savedPlayer.sprWins), sprLoses: Int(savedPlayer.stndLoses), accountType: Int(savedPlayer.accountType))
                }
                playertable.append(player)
                print("new player written to player table")
            }
        } else {
            let player1 = Player(pName: "player1", pPower: 0, accountType: 0)
            let player2 = Player(pName: "player2", pPower: 0, accountType: 0)
            let player3 = Player(pName: "Flippy", pPower: 1, accountType: 0)
            let player4 = Player(pName: "Mr.Freeze", pPower: 2, accountType: 0)
            let player5 = Player(pName: "TimeCop", pPower: 3, accountType: 0)
            playertable.append(player1)
            playertable.append(player2)
            playertable.append(player3)
            playertable.append(player4)
            playertable.append(player5)
            for player in playertable {
                CoreDataManager.shared.saveToCoreData(data: player)
                print("demo player profile written to Core Data")
                
            }
        }
    }
    func addPlayer(name: String, sPower: Int) {
        let newPlayer = Player(pName: name, pPower: sPower, accountType: 1)
        CoreDataManager.shared.saveToCoreData(data: newPlayer)
        playertable.append(newPlayer)
    }
    
    func deletePlayer(name: String) {
        
        playertable.removeAll() {$0.getPlayerName() == name}
        CoreDataManager.shared.deletePlayerFromCoreData(playerToDelete: name)
    }
    
    func tableSize() -> Int {
        return playertable.count
    }
    
    func getPlayer(position: Int) -> Player {
        return playertable[position]
    }
    
    func getIndexOfPlayer(_ name: String) -> Int {
        
        let index = playertable.firstIndex {$0.getPlayerName().hasPrefix(name)}!
        return index
        
    }
    
    func playerExists(name: String) -> Bool {
        for player in playertable {
            if player.getPlayerName() == name {
                return true
            }
        }
        return false
    }
    
    func flatSortedTable(_ searchText: String) -> [Player] {
        var sortedTable : [Player] = []
        
        sortedTable = playertable.filter {$0.getPlayerName().lowercased().contains(searchText.lowercased())}
        
        return sortedTable
    }
    
    func sectionedSortedTable() -> [[Player]] {
        var sortedTable = [[Player]]()
        
        let premadeSubArray = playertable.filter {$0.getAccountType() == 0}
        sortedTable.append(premadeSubArray)
    
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            let subArray = playertable.filter {$0.getPlayerName().uppercased().hasPrefix(String(char)) && $0.getAccountType() == 1}
            if subArray.count != 0 {
                sortedTable.append(subArray)
            }
        }
        
        return sortedTable
    }
   
}
