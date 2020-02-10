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
    
    var game = SuperGame()
    var code = 0
    var superModeActive = false
    
    var player1 : Int?
    var player2 : Int?
    
    //these variables are used in place of a call to getPower each time a check is
    //needed so that if the players power is random it does not mutate each check
    var p1Power : Int?
    var p2Power : Int?
    
    //var tracker = [Bool](repeating: false, count: 9)

    override func viewDidLoad() {
        super.viewDidLoad()

        p1Power = PlayerTable.shared.getPlayer(position: player1!).getPower()
        p2Power = PlayerTable.shared.getPlayer(position: player2!).getPower()
        
        //TO DO: refactor UI code into custom buttons and labels
        playerTurnLabel.backgroundColor = UIColor.red
        playerTurnLabel.textColor = UIColor.orange
        playerTurnLabel.text = "Player 1 Turn/ P: \(p1Power!)"
        
        //additional button styling code
        position1.backgroundColor = UIColor.white
        position1.setTitleColor(UIColor.darkGray, for: .normal)
        position1.layer.borderColor = UIColor.black.cgColor;
        position1.layer.borderWidth = 1.0
        position1.layer.cornerRadius = 10.0
        
        position2.backgroundColor = UIColor.white
        position2.setTitleColor(UIColor.darkGray, for: .normal)
        position2.layer.borderColor = UIColor.black.cgColor
        position2.layer.borderWidth = 1.0
        position2.layer.cornerRadius = 10.0
        
        position3.backgroundColor = UIColor.white
        position3.setTitleColor(UIColor.darkGray, for: .normal)
        position3.layer.borderColor = UIColor.black.cgColor
        position3.layer.borderWidth = 1.0
        position3.layer.cornerRadius = 10.0
        
        position4.backgroundColor = UIColor.white
        position4.setTitleColor(UIColor.darkGray, for: .normal)
        position4.layer.borderColor = UIColor.black.cgColor
        position4.layer.borderWidth = 1.0
        position4.layer.cornerRadius = 10.0
        
        position5.backgroundColor = UIColor.white
        position5.setTitleColor(UIColor.darkGray, for: .normal)
        position5.layer.borderColor = UIColor.black.cgColor
        position5.layer.borderWidth = 1.0
        position5.layer.cornerRadius = 10.0
        
        position6.backgroundColor = UIColor.white
        position6.setTitleColor(UIColor.darkGray, for: .normal)
        position6.layer.borderColor = UIColor.black.cgColor
        position6.layer.borderWidth = 1.0
        position6.layer.cornerRadius = 10.0
        
        position7.backgroundColor = UIColor.white
        position7.setTitleColor(UIColor.darkGray, for: .normal)
        position7.layer.borderColor = UIColor.black.cgColor
        position7.layer.borderWidth = 1.0
        position7.layer.cornerRadius = 10.0
        
        position8.backgroundColor = UIColor.white
        position8.setTitleColor(UIColor.darkGray, for: .normal)
        position8.layer.borderColor = UIColor.black.cgColor
        position8.layer.borderWidth = 1.0
        position8.layer.cornerRadius = 10.0
        
        position9.backgroundColor = UIColor.white
        position9.setTitleColor(UIColor.darkGray, for: .normal)
        position9.layer.borderColor = UIColor.black.cgColor
        position9.layer.borderWidth = 1.0
        position9.layer.cornerRadius = 10.0
        
        superPowerButton.isEnabled = false
        
    }
    
    fileprivate func redrawUI() {
        let redraw = game.getRedrawRequired()
        if (redraw) {
            let positions = game.toBeRedrawn()
            for position in positions {
                if let button = self.view.viewWithTag(position.position) as? UIButton{
                    if (position.player == 1) {
                        button.isEnabled = false
                        button.backgroundColor = UIColor.red
                        button.setTitleColor(UIColor.orange, for: .normal)
                        button.layer.borderColor = UIColor.orange.cgColor
                        button.setTitle("X", for: .normal)
                    } else if (position.player == 2) {
                        button.isEnabled = false
                        button.backgroundColor = UIColor.blue
                        button.setTitleColor(UIColor.cyan, for: .normal)
                        button.layer.borderColor = UIColor.cyan.cgColor
                        button.setTitle("O", for: .normal)
                    } else {
                        button.isEnabled = true
                        button.backgroundColor = UIColor.white
                        button.setTitleColor(UIColor.darkGray, for: .normal)
                        button.layer.borderColor = UIColor.black.cgColor
                        button.setTitle("\(position.position)", for: .normal)
                    }
                }
            }
        }
        game.setRedrawRequired()
        game.resetToBeRedrawn()
    }
    
    fileprivate func prepForSwap() {
        for position in 0...9 {
            if let button = self.view.viewWithTag(position) as? UIButton {
                button.isEnabled = true
            }
        }
        let positionsToDisable = game.prepareForPlayerPowerSwap()
        for position in positionsToDisable {
            if let button = self.view.viewWithTag(position) as? UIButton{
                button.isEnabled = false
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
                redrawUI()
                break
            case 2:
                game.playerPowerFreeze(position: sender.tag)
                sender.isEnabled = false
                sender.backgroundColor = UIColor.systemTeal
                sender.setTitleColor(UIColor.blue, for: .normal)
                sender.layer.borderColor = UIColor.blue.cgColor
                sender.setTitle("F", for: .normal)
                break
            case 3:
                //leaving case 3 in here for now, but this power would not
                //be executed on tap of one of the position buttons
                break
            default:
                break
            }
            
            superModeActive = false
            superPowerButton.backgroundColor = UIColor.purple
            superPowerButton.isEnabled = false
            
        } else {
            game.updateBoard(position: sender.tag)
            if (game.getPlayerTurn() == 1) {
                sender.isEnabled = false
                sender.backgroundColor = UIColor.red
                sender.setTitleColor(UIColor.orange, for: .normal)
                sender.layer.borderColor = UIColor.orange.cgColor
                sender.setTitle("X", for: .normal)
            } else if (game.getPlayerTurn() == 2) {
                sender.isEnabled = false
                sender.backgroundColor = UIColor.blue
                sender.setTitleColor(UIColor.cyan, for: .normal)
                sender.layer.borderColor = UIColor.cyan.cgColor
                sender.setTitle("O", for: .normal)
            } else {
                sender.isEnabled = false
                sender.backgroundColor = UIColor.black
                sender.setTitleColor(UIColor.green, for: .normal)
                sender.layer.borderColor = UIColor.green.cgColor
                sender.setTitle("Error", for: .normal)
            }
            code = game.victory();
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
                playerTurnLabel.text = "Player 1 Turn/ P: \(p1Power!)"
                superPowerButton.isEnabled = game.canUsePower(power: p1Power!)
                redrawUI()
            } else {
                playerTurnLabel.backgroundColor = UIColor.blue
                playerTurnLabel.textColor = UIColor.cyan
                playerTurnLabel.text = "Player 2 Turn/ P: \(p2Power!)"
                superPowerButton.isEnabled = game.canUsePower(power: p2Power!)
                redrawUI()
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
                break
            case 3:
                game.playerPowerRewind()
                superPowerButton.isEnabled = false
                break
            default:
                break
            }
        } else if (pTurn == 2 && p2Power != 2) {
            switch p2Power {
            case 1:
                prepForSwap()
                superPowerButton.isEnabled = false
                break
            case 2:
                game.playerPowerRewind()
                superPowerButton.isEnabled = false
                break
            default:
                break
            }
        } else {
            superModeActive = true
            superPowerButton.backgroundColor = UIColor.yellow
        }
        redrawUI()
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
