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
    
    var game = StandardGame();
    var code = 0;
    
    var tracker = [Bool](repeating: false, count: 9);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerTurnLabel.backgroundColor = UIColor.red;
        playerTurnLabel.textColor = UIColor.orange;
        playerTurnLabel.text = "Player 1 Turn";
        
        //additional button styling code
        position1.backgroundColor = UIColor.white;
        position1.setTitleColor(UIColor.darkGray, for: .normal)
        position1.layer.borderColor = UIColor.black.cgColor;
        position1.layer.borderWidth = 1.0;
        position1.layer.cornerRadius = 10.0;
        
        position2.backgroundColor = UIColor.white;
        position2.setTitleColor(UIColor.darkGray, for: .normal)
        position2.layer.borderColor = UIColor.black.cgColor;
        position2.layer.borderWidth = 1.0;
        position2.layer.cornerRadius = 10.0;
        
        position3.backgroundColor = UIColor.white;
        position3.setTitleColor(UIColor.darkGray, for: .normal)
        position3.layer.borderColor = UIColor.black.cgColor;
        position3.layer.borderWidth = 1.0;
        position3.layer.cornerRadius = 10.0;
        
        position4.backgroundColor = UIColor.white;
        position4.setTitleColor(UIColor.darkGray, for: .normal)
        position4.layer.borderColor = UIColor.black.cgColor;
        position4.layer.borderWidth = 1.0;
        position4.layer.cornerRadius = 10.0;
        
        position5.backgroundColor = UIColor.white;
        position5.setTitleColor(UIColor.darkGray, for: .normal)
        position5.layer.borderColor = UIColor.black.cgColor;
        position5.layer.borderWidth = 1.0;
        position5.layer.cornerRadius = 10.0;
        
        position6.backgroundColor = UIColor.white;
        position6.setTitleColor(UIColor.darkGray, for: .normal)
        position6.layer.borderColor = UIColor.black.cgColor;
        position6.layer.borderWidth = 1.0;
        position6.layer.cornerRadius = 10.0;
        
        position7.backgroundColor = UIColor.white;
        position7.setTitleColor(UIColor.darkGray, for: .normal)
        position7.layer.borderColor = UIColor.black.cgColor;
        position7.layer.borderWidth = 1.0;
        position7.layer.cornerRadius = 10.0;
        
        position8.backgroundColor = UIColor.white;
        position8.setTitleColor(UIColor.darkGray, for: .normal)
        position8.layer.borderColor = UIColor.black.cgColor;
        position8.layer.borderWidth = 1.0;
        position8.layer.cornerRadius = 10.0;
        
        position9.backgroundColor = UIColor.white;
        position9.setTitleColor(UIColor.darkGray, for: .normal)
        position9.layer.borderColor = UIColor.black.cgColor;
        position9.layer.borderWidth = 1.0;
        position9.layer.cornerRadius = 10.0;

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton){
        //on button press, update the gameboard and then check for victory/stalemate
        game.updateBoard(position: sender.tag);
        if (game.getPlayerTurn() == 1) {
            sender.isEnabled = false
            sender.backgroundColor = UIColor.red;
            sender.setTitleColor(UIColor.orange, for: .normal);
            sender.layer.borderColor = UIColor.orange.cgColor;
            sender.setTitle("X", for: .normal);
        } else if (game.getPlayerTurn() == 2) {
            sender.isEnabled = false
            sender.backgroundColor = UIColor.blue;
            sender.setTitleColor(UIColor.cyan, for: .normal);
            sender.layer.borderColor = UIColor.cyan.cgColor;
            sender.setTitle("O", for: .normal);
        } else {
            sender.isEnabled = false
            sender.backgroundColor = UIColor.black;
            sender.setTitleColor(UIColor.green, for: .normal);
            sender.layer.borderColor = UIColor.green.cgColor;
            sender.setTitle("Error", for: .normal);
        }
        
        code = game.victory();
        
        //if victory code comes back as not zero, segue to victory screen vc
        //otherwise, update which players turn it is.
        if (code != 0) {
            performSegue(withIdentifier: "VictoryScreenSegue", sender: nil)
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
        if segue.identifier == "VictoryScreenSegue" {
            let vc = segue.destination as? VictoryScreenViewController
            vc?.victoryCode = code;
        }
       
    }

}
