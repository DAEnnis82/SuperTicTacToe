//
//  GameLogic.swift
//  SuperTicTacToe
//
//  Created by Work Mode on 12/23/19.
//  Copyright © 2019 Apps By Ennis. All rights reserved.
//

import Foundation

class StandardGame {
    
    
    var gameboard = [[0,0,0],
                     [0,0,0],
                     [0,0,0]];
    
    var tracker = [Bool](repeating: false, count: 9);
    
    var playerTurn = 1;
    
    
    //when victory function is called it checks the board to determine if there is a winner or a stalemate and then returns an int
    //value to interpreted. returns 1 for player 1 victory, 2 for player 2 victory or 3 for stalemate. if 0 is returned, no one has won
    //and there are still possible moves on the board.
    func victory() -> Int {
        var code = 0
        var marker = 0;
        
        //check top row across
        if ((gameboard[0][0] != 0)&&(gameboard[0][0] == gameboard[0][1] && gameboard[0][1] == gameboard[0][2])) {
            marker = gameboard[0][0];
        //check left row up/down
        } else if ((gameboard[0][0] != 0)&&(gameboard[0][0] == gameboard[1][0] && gameboard[1][0] == gameboard[2][0])) {
            marker = gameboard[0][0];
        //check diagonal top left to bottom right
        } else if ((gameboard[0][0] != 0)&&(gameboard[0][0] == gameboard[1][1] && gameboard[1][1] == gameboard[2][2])) {
            marker = gameboard[0][0];
        //check diagonal bottom left to top right
        } else if ((gameboard[2][0] != 0)&&(gameboard[2][0] == gameboard[1][1] && gameboard[1][1] == gameboard[0][2])) {
            marker = gameboard[2][0];
        //check middle row across
        } else if ((gameboard[1][0] != 0)&&(gameboard[1][0] == gameboard[1][1] && gameboard[1][1] == gameboard[1][2])) {
            marker = gameboard[1][0];
        //check bottom row across
        } else if ((gameboard[2][0] != 0)&&(gameboard[2][0] == gameboard[2][1] && gameboard[2][1] == gameboard[2][0])) {
            marker = gameboard[2][0];
        //check middle row up/down
        } else if ((gameboard[0][1] != 0)&&(gameboard[0][1] == gameboard[1][1] && gameboard[1][1] == gameboard[2][1])) {
            marker = gameboard[0][1];
        //check right row up/down
        } else if ((gameboard[0][2] != 0)&&(gameboard[0][2] == gameboard[1][2] && gameboard[1][2] == gameboard[2][2])) {
            marker = gameboard[0][2];
        }
        
        code = marker;
        
        //if the marker is still 0 after the board has been checked, check to see how
        //many total positions on the board are filled. if all positions are filled
        //set the code to 3 for stalemate
        if (marker == 0) {
             var flag = 0;
                   for position in tracker {
                       if position {
                           flag+=1;
                       }
                   }
            if flag == 9 {
                code = 3;
            }
        }
        
        return code;
        
    }
    
    //function recieves the tag number of the position that was tapped and by which player
    //and then updates the gameboard and tracker arrays accordingly
    func updateBoard(position: Int) {
        
        let player = getPlayerTurn();
        tracker[position - 1] = true;
        
        switch position {
        case 1:
            gameboard[0][0] = player;
            break;
        case 2:
            gameboard[0][1] = player;
            break;
        case 3:
            gameboard[0][2] = player;
            break;
        case 4:
            gameboard[1][0] = player;
            break;
        case 5:
            gameboard[1][1] = player;
            break;
        case 6:
            gameboard[1][2] = player;
            break;
        case 7:
            gameboard[2][0] = player;
            break;
        case 8:
            gameboard[2][1] = player;
            break;
        case 9:
            gameboard[2][2] = player;
            break;
        default:
            break;
        }
        
        
    }
    
    func setPlayerTurn() {
        playerTurn+=1;
    }
    
    func getPlayerTurn() -> Int {
        var pTurn = 0;
        if (playerTurn % 2 != 0) {
            pTurn = 1;
        } else {
            pTurn = 2;
        }
        
        return pTurn;
    }
    
}

