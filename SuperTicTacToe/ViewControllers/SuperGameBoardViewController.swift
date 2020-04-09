//
//  SuperGameBoardViewController.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/4/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

class SuperGameBoardViewController: UIViewController {
    
    @IBOutlet weak var position1: UIButton!
    @IBOutlet weak var position2: UIButton!
    @IBOutlet weak var position3: UIButton!
    @IBOutlet weak var position4: UIButton!
    @IBOutlet weak var position5: UIButton!
    @IBOutlet weak var position6: UIButton!
    @IBOutlet weak var position7: UIButton!
    @IBOutlet weak var position8: UIButton!
    @IBOutlet weak var position9: UIButton!
    @IBOutlet weak var superPowerButton: UIButton!
    
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    var game = EnhancedGame()
    var code = 0
    var superModeActive = false
    
    var player1 : Int?
    var player2 : Int?
    
    //these variables are used in place of a call to getPower each time a check is
    //needed so that if the players power is random it does not mutate each check
    var p1Power : Int?
    var p2Power : Int?
    let powerList = SuperPowersList()
    
    //var tracker = [Bool](repeating: false, count: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p1Power = PlayerTable.shared.getPlayer(position: player1!).getPower()
        p2Power = PlayerTable.shared.getPlayer(position: player2!).getPower()
        
        //TO DO: refactor UI code into custom buttons and labels
        playerTurnLabel.backgroundColor = UIColor.red
        playerTurnLabel.textColor = UIColor.orange
        playerTurnLabel.text = """
        \(PlayerTable.shared.getPlayer(position: player1!).getPlayerName()) Turn
        P: \(powerList.superPowers[p1Power!].1)
        """
        
        //additional button styling code
        
        for position in 1...9 {
            if let button = self.view.viewWithTag(position) as? UIButton {
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor.darkGray, for: .normal)
                button.layer.borderColor = UIColor.black.cgColor;
                button.layer.borderWidth = 1.0
                button.layer.cornerRadius = 10.0
            }
        }
        
        superPowerButton.isEnabled = false
        superPowerButton.backgroundColor = UIColor.gray
        superPowerButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    fileprivate func updateUI() {
        for (index, value) in game.gameboard.enumerated() {
            if let button = self.view.viewWithTag(index + 1) as? UIButton {
                switch value {
                case 0:
                    button.isEnabled = true
                    button.backgroundColor = UIColor.white
                    button.setTitleColor(UIColor.darkGray, for: .normal)
                    button.layer.borderColor = UIColor.black.cgColor
                    button.setTitle("\(index + 1)", for: .normal)
                    break
                case 1:
                    button.isEnabled = false
                    button.backgroundColor = UIColor.red
                    button.setTitleColor(UIColor.orange, for: .normal)
                    button.layer.borderColor = UIColor.orange.cgColor
                    button.setTitle("X", for: .normal)
                    break
                case 2:
                    button.isEnabled = false
                    button.backgroundColor = UIColor.blue
                    button.setTitleColor(UIColor.cyan, for: .normal)
                    button.layer.borderColor = UIColor.cyan.cgColor
                    button.setTitle("O", for: .normal)
                    break
                case 3:
                    break
                case 4:
                    button.isEnabled = false
                    button.backgroundColor = UIColor.systemTeal
                    button.setTitleColor(UIColor.blue, for: .normal)
                    button.layer.borderColor = UIColor.blue.cgColor
                    button.setTitle("F", for: .normal)
                default:
                    break
                }
                
                if superPowerButton.isEnabled == false {
                    superPowerButton.backgroundColor = UIColor.gray
                    superPowerButton.setTitleColor(UIColor.white, for: .normal)
                } else {
                    superPowerButton.backgroundColor = UIColor.purple
                    superPowerButton.setTitleColor(UIColor.orange, for: .normal)
                }
                
            }
        }
    }
    
    fileprivate func prepForSwap() {
        print("VC method prepForSwap called")
        for position in 1...9 {
            if let button = self.view.viewWithTag(position) as? UIButton {
                button.isEnabled = false
                print("positon \(position) is \(button.isEnabled)")
            }
        }
        let positionsToEnable = game.prepareForPlayerPowerSwap()
        for position in positionsToEnable {
            if let button = self.view.viewWithTag(position + 1) as? UIButton{
                button.isEnabled = true
                print("positon \(position) is \(button.isEnabled)")
            }
        }
    }
    
    @IBAction func positionButtonPressed(_ sender: UIButton){
        //on button press, if super mode is active, set superModeActive to false, othwise update the gameboard and then check for victory/stalemate
        if (superModeActive) {
            var power : Int
            if (game.getPlayerTurn() == 1) {
                power = (p1Power!)
            } else {
                power = (p2Power!)
            }
            
            switch power {
            case 1:
                game.playerPowerSwap(position: sender.tag)
                for position in 0...9 {
                    if let button = self.view.viewWithTag(position) as? UIButton {
                        button.isEnabled = false
                    }
                }
                let positionsToEnable = game.resetAfterPlayerPowerSwap()
                for position in positionsToEnable {
                    if let button = self.view.viewWithTag(position) as? UIButton {
                        button.isEnabled = true
                    }
                }
                updateUI()
                break
            case 2:
                game.playerPowerFreeze(position: sender.tag)
                sender.isEnabled = false
                sender.backgroundColor = UIColor.systemTeal
                sender.setTitleColor(UIColor.blue, for: .normal)
                sender.layer.borderColor = UIColor.blue.cgColor
                sender.setTitle("F", for: .normal)
                updateUI()
                break
            case 3:
                //leaving case 3 in here for now, but this power would not
                //be executed on tap of one of the position buttons
                break
            default:
                break
            }
            
            superModeActive = false
            superPowerButton.isEnabled = false
            
        } else {
            game.updateBoard(position: sender.tag)
            updateUI()
            code = game.victoryCheck()
            
            //if victory code comes back as not zero, segue to victory screen vc
            //otherwise, update which players turn it is.
            if (code != 0) {
                performSegue(withIdentifier: "SuperVictoryScreenSegue", sender: nil)
            } else {
                game.setPlayerTurn()
                game.setTurnTracker()
            }
            //checks player turn and updates playerTurnLabel accordingly
            if (game.getPlayerTurn() == 1) {
                playerTurnLabel.backgroundColor = UIColor.red
                playerTurnLabel.textColor = UIColor.orange
                playerTurnLabel.text = """
                \(PlayerTable.shared.getPlayer(position: player1!).getPlayerName()) Turn
                P: \(powerList.superPowers[p1Power!].1)
                """
                superPowerButton.isEnabled = game.canUsePower(power: p1Power!)
                updateUI()
            } else {
                playerTurnLabel.backgroundColor = UIColor.blue
                playerTurnLabel.textColor = UIColor.cyan
                playerTurnLabel.text = """
                \(PlayerTable.shared.getPlayer(position: player2!).getPlayerName()) Turn
                P: \(powerList.superPowers[p2Power!].1)
                """
                superPowerButton.isEnabled = game.canUsePower(power: p2Power!)
                updateUI()
            }
            
        }
    }
    
    @IBAction func superPowerButtonPressed(_ sender: Any) {
        let pTurn = game.getPlayerTurn()
        if (pTurn == 1 && p1Power != 2) {
            switch p1Power{
            case 1:
                prepForSwap()
                superPowerButton.isEnabled = false
                superModeActive = true
                superPowerButton.backgroundColor = UIColor.yellow
                break
            case 3:
                game.playerPowerRewind()
                superPowerButton.isEnabled = false
                updateUI()
                break
            default:
                break
            }
        } else if (pTurn == 2 && p2Power != 2) {
            switch p2Power {
            case 1:
                prepForSwap()
                superPowerButton.isEnabled = false
                superModeActive = true
                superPowerButton.backgroundColor = UIColor.yellow
                break
            case 3:
                game.playerPowerRewind()
                superPowerButton.isEnabled = false
                updateUI()
                break
            default:
                break
            }
        } else {
            superModeActive = true
            superPowerButton.backgroundColor = UIColor.yellow
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SuperVictoryScreenSegue" {
            let vc = segue.destination as? VictoryScreenViewController
            vc?.victoryCode = code;
            vc?.gameMode = 1
            vc?.player1 = player1!
            vc?.player2 = player2!
            
        }
    }
}
