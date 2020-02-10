//
//  VictoryScreenViewController.swift
//  SuperTicTacToe
//
//  Created by Work Mode on 12/20/19.
//  Copyright © 2019 Apps By Ennis. All rights reserved.
//

import UIKit

class VictoryScreenViewController: UIViewController {

    @IBOutlet weak var victoryTextLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var mainMenuButton: UIButton!
    
    @IBAction func MainMenuButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "VictoryToMainMenuSegue", sender: nil)
    }
    
    @IBAction func PlayAgainButtonTapped(_ sender: Any) {
        switch gameMode {
        case 0:
            performSegue(withIdentifier: "VictoryToStandardGameSegue", sender: nil)
            break
        case 1:
            performSegue(withIdentifier: "VictoryToSuperGameSegue", sender: nil)
            break
        default:
            break
        }
    }
    
    var victoryCode = 0
    var gameMode : Int?
    var player1 : Int?
    var player2 : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //button styling
        playAgainButton.layer.cornerRadius = 10.0;
        mainMenuButton.layer.cornerRadius = 10.0;
        
        //sets what the label will display based on the winner
        switch victoryCode {
        case 1:
            victoryTextLabel.text = "VICTORY, \(PlayerTable.shared.getPlayer(position: player1!).getPlayerName())!";
            victoryTextLabel.backgroundColor = UIColor.red;
            victoryTextLabel.textColor = UIColor.orange;
            break;
        case 2:
            victoryTextLabel.text = "VICTORY, \(PlayerTable.shared.getPlayer(position: player2!).getPlayerName())";
            victoryTextLabel.backgroundColor = UIColor.blue;
            victoryTextLabel.textColor = UIColor.cyan;
            break;
        case 3:
            victoryTextLabel.text = "STALEMATE";
            victoryTextLabel.backgroundColor = UIColor.darkGray;
            victoryTextLabel.textColor = UIColor.green;
            break;
        default:
            break;
        }
        
        
        
        
        
        
        
    }
    
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VictoryToSuperGameSegue" {
            let vc = segue.destination as? SuperGameBoardViewController
            vc?.player1 = player1
            vc?.player2 = player2
        }
    }
   

}
