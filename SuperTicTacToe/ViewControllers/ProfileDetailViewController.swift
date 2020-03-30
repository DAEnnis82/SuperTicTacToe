//
//  ProfileDetailViewController.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/17/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
    
    @IBOutlet weak var playerProfileImage: UIImageView!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var powerNameLabel: UILabel!
    @IBOutlet weak var powerDescriptionLabel: UILabel!
    
    @IBOutlet weak var standardWinsLabel: UILabel!
    @IBOutlet weak var standardLosesLabel: UILabel!
    
    @IBOutlet weak var superWinsLabel: UILabel!
    @IBOutlet weak var superLosesLabel: UILabel!
    
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLosesLabel: UILabel!
    
    var player : Player?
    var powerIndex = SuperPowersList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerProfileImage.image = player?.getPlayerImage() ?? UIImage(named: "PlayerImagePlaceholder")
        playerNameLabel.text = player?.getPlayerName()
        powerNameLabel.text = powerIndex.superPowers[player?.displayPower() ?? 0].1
        powerDescriptionLabel.text = powerIndex.superPowers[player?.displayPower() ?? 0].2
        
        standardWinsLabel.text =  "\(player?.getStndWinsLoses().0 ?? 0)"
        standardLosesLabel.text = "\(player?.getStndWinsLoses().1 ?? 0)"
        
        superWinsLabel.text = "\(player?.getSprWinsLoses().0 ?? 0)"
        superLosesLabel.text = "\(player?.getSprWinsLoses().1 ?? 0)"
        
        totalWinsLabel.text = "\(player?.getAllWinsLoses().0 ?? 0)"
        totalLosesLabel.text = "\(player?.getAllWinsLoses().1 ?? 0)"
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
