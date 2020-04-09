//
//  GameLogicRework.swift
//  SuperTicTacToe
//
//  Created by Work Mode on 2/27/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import Foundation

class BasicGame {
    
    var gameboard = [Int](repeating: 0, count: 9)
    var stalemateTracker = [Bool](repeating: false, count: 9)
    var turnTracker = 1
    var playerTurn = 1
    
    
    
    //when victory function is called it checks the board to determine if there is a winner or a stalemate and then returns an int
    //value to interpreted. returns 1 for player 1 victory, 2 for player 2 victory or 3 for stalemate. if 0 is returned, no one has won
    //and there are still possible moves on the board.
    func victoryCheck() -> Int {
        print("victory check function called")
        var code = 0
        var marker = 0
        
        //top row across
        if (gameboard[0] != 0 && (gameboard[0] == gameboard[1] && gameboard[0] == gameboard[2])) {
            marker = gameboard[0]
            
            //left column vetical
        } else if (gameboard[0] != 0 && (gameboard[0] == gameboard[3] && gameboard[0] == gameboard[6])) {
            marker = gameboard[0]
            
            //diagonal top left to bottom right
        } else if (gameboard[0] != 0 && (gameboard[0] == gameboard[4] && gameboard[0] == gameboard[8])) {
            marker = gameboard[0]
            
            //diagonal bottom left to top right
        } else if (gameboard[6] != 0 && (gameboard[6] == gameboard[4] && gameboard[6] == gameboard[2])) {
            marker = gameboard[6]
            
            //middle row across
        } else if (gameboard[3] != 0 && (gameboard[3] == gameboard[4] && gameboard[3] == gameboard[5])) {
            marker = gameboard[3]
            
            //bottom row across
        } else if (gameboard[6] != 0 && (gameboard[6] == gameboard[7] && gameboard[6] == gameboard[8])) {
            marker = gameboard[6]
            
            //middle column vertical
        } else if (gameboard[1] != 0 && (gameboard[1] == gameboard[4] && gameboard[1] == gameboard[7])) {
            marker = gameboard[1]
            
            //right column vertical
        } else if (gameboard[2] != 0 && (gameboard[2] == gameboard[5] && gameboard[2] == gameboard[8])) {
            marker = gameboard[2]
        }
        
        
        code = marker
        
        //if the marker is still 0 after the board has been checked, check to see how
        //many total positions on the board are filled. if all positions are filled
        //set the code to 3 for stalemate
        if (marker == 0) {
            var flag = 0
            for position in stalemateTracker {
                if position {
                    flag+=1
                }
            }
            if flag == 9 {
                code = 3
            }
        }
        print("gameboard: ")
        dump(gameboard)
        print("victory return: " + "\(code)")
        return code
    }
    
    func updateBoard(position: Int) {
        print("super.updateBoard called")
        let player = getPlayerTurn()
        let position = position - 1
        
        gameboard[position] = player
        stalemateTracker[position] = true
    }
    
    //advance the playerTurn varaible which is used to calculate whose turn it is
    func setPlayerTurn() {
        playerTurn+=1;
    }
    
    //getter function that returns either 1 or 2 to indicate which player turn it is.
    func getPlayerTurn() -> Int {
        var pTurn = 0
        if (playerTurn % 2 != 0) {
            pTurn = 1
        } else {
            pTurn = 2
        }
        
        return pTurn
    }
    
    func setTurnTracker() {
        turnTracker += 1
    }
    
    func getTurnTracker() -> Int {
        return turnTracker
    }
}


class EnhancedGame: BasicGame {
    
    
    private var p1PowerUsed = false
    private var p2PowerUsed = false
    
    private var rewindTracker = [0,0]
    
    private var freezeTracker = [(turn: 99, position: 99)]
    
    //private var positionsToRedraw = [(position:Int, player:Int)]()
    
    override func updateBoard(position: Int) {
        print("updateBoard called")
        print("position passed in: " + "\(position)")
        print("turnTracker: " + "\(turnTracker)")
        print("p1 power:" + "\(p1PowerUsed)")
        print("p2 power:" + "\(p2PowerUsed)")
        super.updateBoard(position: position)
        rewindTracker[self.getPlayerTurn() - 1] = position
        dump(rewindTracker)
        dump(freezeTracker)
        if (freezeTracker[0].turn != 99) {
            print("in freezeTracker update")
            print(turnTracker)
            if (getTurnTracker() == (freezeTracker[0].turn) + 1) {
                print("in freezeTracker second statement")
                print("powersBoard:")
                reOpenPosition(positionToReOpen: freezeTracker[0].position)
                //positionsToRedraw.append((freezeTracker[0].position, 0))
                freezeTracker.append((turn: 99, position: 99))
                print("freezeTracker:")
                dump(freezeTracker)
                freezeTracker.removeFirst()
                dump(freezeTracker)            }
        }
    }
    
    func reOpenPosition(positionToReOpen: Int) {
        let position = positionToReOpen - 1
        print("reOpenPosition triggered")
        print("position to be reopenned:" + "\(positionToReOpen)")
        stalemateTracker[position] = false
        print("tracker after: ")
        dump(stalemateTracker)
        gameboard[position] = 0
        print("gameboard after: ")
        dump(gameboard)
        
    }
    
    func prepareForPlayerPowerSwap() -> [Int] {
        print("prepareForPlayerPowerSwap called")
        var positionsToEnable = [Int]()
        let player = getPlayerTurn()
        for (index, value) in gameboard.enumerated() {
            if (value == player) {
                positionsToEnable.append(index)
            }
        }
        print("returned positions to enable: ")
        dump(positionsToEnable)
        return positionsToEnable
    }
    
    //function that executes the "Swap" super power. The player selects one of their positions that is currently filled and it
    //then randomly swaps it with one of their opponents positions that is filled.
    func playerPowerSwap(position: Int){
        print("playerPowerSwap called")
        print("position passed in:" + "\(position)")
        print("Initial Player Turn:" + "\(getPlayerTurn())")
        print("gameboard at start of playerPowerSwap")
        dump(gameboard)
        
        
        var canSwap = [Int]()
        setPlayerTurn()
        var pTurn = getPlayerTurn()
        print("Initial pTurn:" + "\(pTurn)")
        //get the positions currently belonging to the other player (the 0 and 4 values
        //denote, respectively, positions that are currently unfilled or frozen)
        for (index, value) in gameboard.enumerated() {
            if (value == pTurn) {
                canSwap.append(index)
            }
        }
        print("canSwap array:")
        dump(canSwap)
        //choose one at random
        let swapped = Int .random(in: 0..<canSwap.count)
        print("choosen index:" + "\(swapped)")
        
        //update the board
        setPlayerTurn()
        pTurn = getPlayerTurn()
        print("pTurn updated")
        print("pTurn:" + "\(pTurn)")
        super.updateBoard(position: canSwap[swapped] + 1)
        setPlayerTurn()
        
        pTurn = getPlayerTurn()
        print("pTurn updated")
        print("pTurn:" + "\(pTurn)")
        super.updateBoard(position: position)
        setPlayerTurn()
        print("gameboard at end of playerPowerSwap")
        dump(gameboard)
        print("powersBoard at end of playerPowerSwap")
        print("player turn before exit:" + "\(getPlayerTurn())")
        print("postionsToRedraw at end of playerPowerSwap:")
        
        //update which player used their power
        setPlayerPowerUsed()
        
    }
    
    //after swap power is used this function is called to reenable all
    //all avaiable positions on the board.
    func resetAfterPlayerPowerSwap() -> [Int] {
        print("resetAfterPlayerPowerSwap called")
        var enablePositions = [Int]()
        for (index, value) in gameboard.enumerated() {
            if (value == 0) {
                enablePositions.append(index)
            }
        }
        print("returned positions to enable:")
        dump(enablePositions)
        
        return enablePositions
    }
    
    //function that executes the "Freeze" super power. The player selects one position, and neither they or their opponent can use that position this turn.
    func playerPowerFreeze(position: Int) {
        print("playerPowerFreeze called")
        print("position passed in:" + "\(position)")
        //update the powers board to reflect the position the player selected to be frozen
        gameboard[position - 1] = 4
        print("freezeTracker at power start:")
        dump(freezeTracker)
        if (freezeTracker[0].turn == 99) {
            freezeTracker.append((turn: getTurnTracker(), position: position))
            freezeTracker.removeFirst()
            print("freezeTracker first element removed and new one appended")
            print("freezeTracker:")
            dump(freezeTracker)
        } else {
            freezeTracker.append((turn: getTurnTracker(), position: position))
            print("freezeTracker first element NOT removed, one element appended")
            print("freezeTracker:")
            dump(freezeTracker)
        }
        setPlayerPowerUsed()
        
    }
    //function that executes the "Rewind super power. When the player activates this power both their last move and their opponents last move are undone
    func playerPowerRewind() {
        print("playerPowerRewind called")
        for position in rewindTracker {
            reOpenPosition(positionToReOpen: position)
        }
        setPlayerPowerUsed()
    }
    
    //function to update the variables that track whether a player has used their super power
    func setPlayerPowerUsed() {
        print("setPlayerPowerUsed called")
        print("p1Power at start:" + "\(p1PowerUsed)")
        print("p2Power at start:" + "\(p2PowerUsed)")
        if (self.getPlayerTurn() == 1) {
            p1PowerUsed = true
        } else {
            p2PowerUsed = true
        }
        
        print("at end:")
        print("p1PowerUsed:" + "\(p1PowerUsed)")
        print("p2PowerUsed:" + "\(p2PowerUsed)")
    }
    
    //function to pull whether the current player has used their super power
    func getPlayerPowerUsed() -> Bool {
        if (self.getPlayerTurn() == 1) {
            return p1PowerUsed
        } else {
            return p2PowerUsed
        }
    }
    
    //this function will be called at the beginning of each players turn to determin whether or
    //not the player is allowed to activate thier super power this turn.
    func canUsePower(power: Int) -> Bool {
        print("canUsePower called")
        var canUse = false
        let pTurn = getPlayerTurn()
        
        if (pTurn == 1 && p1PowerUsed == true) {
            return canUse
        } else if (pTurn == 2 && p2PowerUsed == true) {
            return canUse
        } else {
            var count = 0
            for position in gameboard {
                if (position == 0 || position == 4) {
                    count += 1
                }
            }
            switch power {
            case 1:
                if (count >= 2) {
                    canUse = true
                }
                break
            case 2:
                if (count <= 7) {
                    canUse = true
                }
                break
            case 3:
                if (count >= 2) {
                    canUse = true
                }
                break
            default:
                canUse = false
                break
                
            }
            print("canUse return:" + "\(canUse)")
            return canUse
        }
        
    }
    
    
}
