//
//  PlayerProfileCell.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/13/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

class PlayerProfileCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    var player : Player?
    
    func populatePlayer(playerData: Player) {
        playerNameLabel.text = playerData.getPlayerName()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
