//
//  GameBoardViewController.swift
//  SuperTicTacToe
//
//  Created by Work Mode on 12/20/19.
//  Copyright © 2019 Apps By Ennis. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    
    @IBOutlet weak var position1: UIButton!
    @IBOutlet weak var position2: UIButton!
    @IBOutlet weak var position3: UIButton!
    @IBOutlet weak var position4: UIButton!
    @IBOutlet weak var position5: UIButton!
    @IBOutlet weak var position6: UIButton!
    @IBOutlet weak var position7: UIButton!
    @IBOutlet weak var position8: UIButton!
    @IBOutlet weak var position9: UIButton!
    
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    var game = BasicGame();
    var code = 0
    var player1 : Int?
    var player2 : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TO DO: refactor UI code into custom buttons and labels
        playerTurnLabel.backgroundColor = UIColor.red;
        playerTurnLabel.textColor = UIColor.orange;
        playerTurnLabel.text = "Player 1 Turn";
        
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
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton){
        //on button press, update the gameboard and then check for victory/stalemate
        game.updateBoard(position: sender.tag);
        updateUI()
        code = game.victoryCheck()
        
        //if victory code comes back as not zero, segue to victory screen vc
        //otherwise, update which players turn it is.
        if (code != 0) {
            performSegue(withIdentifier: "StandardVictoryScreenSegue", sender: nil)
        } else {
            game.setPlayerTurn();
        }
        
        //checks player turn and updates playerTurnLabel accordingly
        if (game.getPlayerTurn() == 1) {
            playerTurnLabel.backgroundColor = UIColor.red;
            playerTurnLabel.textColor = UIColor.orange;
            playerTurnLabel.text = "Player 1 Turn";
        } else {
            playerTurnLabel.backgroundColor = UIColor.blue;
            playerTurnLabel.textColor = UIColor.cyan;
            playerTurnLabel.text = "Player 2 Turn";
        }
        
        
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StandardVictoryScreenSegue" {
            let vc = segue.destination as? VictoryScreenViewController
            vc?.victoryCode = code
            vc?.gameMode = 0
            vc?.player1 = player1!
            vc?.player2 = player2!
        }
        
    }
    
}
