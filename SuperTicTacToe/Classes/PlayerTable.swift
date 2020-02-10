//
//  PlayerTableDataManager.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/10/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import Foundation

final class PlayerTable {
    
    private var player : Player?
    private var playertable = [Player]()
    
    static let shared = PlayerTable()
    
    private init() {
        let player1 = Player(pName: "player1", pPower: 0)
        let player2 = Player(pName: "player2", pPower: 0)
        let player3 = Player(pName: "Flippy", pPower: 1)
        let player4 = Player(pName: "Mr.Freeze", pPower: 2)
        let player5 = Player(pName: "TimeCop", pPower: 3)
        playertable.append(player1)
        playertable.append(player2)
        playertable.append(player3)
        playertable.append(player4)
        playertable.append(player5)
    }
    
    func addPlayer(name: String, sPower: Int) {
        let newPlayer = Player(pName: name, pPower: sPower)
        playertable.append(newPlayer)
    }
    
    func deletePlayer(name: String) {
        
    }
    
    func tableSize() -> Int {
        return playertable.count
    }
    
    func getPlayer(position: Int) -> Player {
        return playertable[position]
    }
    
    
    
    
}
