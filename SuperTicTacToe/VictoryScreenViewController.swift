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
    
    var victoryCode = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //button styling
        playAgainButton.layer.cornerRadius = 10.0;
        mainMenuButton.layer.cornerRadius = 10.0;
        
        //sets what the label will display based on the winner
        switch victoryCode {
        case 1:
            victoryTextLabel.text = "VICTORY, Player 1!";
            victoryTextLabel.backgroundColor = UIColor.red;
            victoryTextLabel.textColor = UIColor.orange;
            break;
        case 2:
            victoryTextLabel.text = "VICTORY, Player 2!";
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
