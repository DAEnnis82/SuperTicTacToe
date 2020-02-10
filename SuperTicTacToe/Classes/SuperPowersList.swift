//
//  SuperPowersList.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/15/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import Foundation


//this struct is called by various viewcontrollers and classes that need to display player powers and their descriptions
struct SuperPowersList {
public let superPowers: [(Int,String,String)] =
    
    [
    (code: 0, powerName: "Random", description: "A random power from the powers list will be chosen each time you play"),
    (code: 1, powerName: "Swap", description: "Choose a space you control to randomly swap with a space your opponent controls"),
    (code: 2, powerName: "Freeze", description: "Choose a spot to freeze it for one turn, neither you or your opponent can select that spot this turn"),
    (code: 3, powerName: "Rewind", description: "Both your and your opponents last moves are undone")
    ]
    
}

