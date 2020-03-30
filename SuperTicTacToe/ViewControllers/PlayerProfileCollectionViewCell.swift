//
//  PlayerProfileCollectionViewCell.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/18/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

protocol PlayerProfileCollectionViewCellDelegate {
    func didTapSelectProfile(playerSelected: Player, indexTag: Int)
}

class PlayerProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPowerLabel: UILabel!
    @IBOutlet weak var profileSelectButton: UIButton!
    
    var delegate : PlayerProfileCollectionViewCellDelegate?
    var player: Player?
    var playerBeingSelected: Int?
    var indexTag: Int?
    var hasBeenSelected: Bool?
    //var player : Player?
    //playerPowerLabel.text
    
    @IBAction func profileSelectButtonTapped(_ sender: Any) {
        delegate?.didTapSelectProfile(playerSelected: player!, indexTag: indexTag!)
        profileSelectButton.isEnabled = false
        if playerBeingSelected == 1 && hasBeenSelected == false {
            profileSelectButton.isEnabled = false
            profileSelectButton.backgroundColor = UIColor.red
            profileSelectButton.setTitle("Player 1", for: .normal)
        } else if playerBeingSelected == 2 && hasBeenSelected == false {
            profileSelectButton.isEnabled = false
            profileSelectButton.backgroundColor = UIColor.blue
            profileSelectButton.setTitle("Player 2", for: .normal)
        } else {
            profileSelectButton.isEnabled = false
            profileSelectButton.backgroundColor = UIColor.purple
            profileSelectButton.setTitle("", for: .normal)
        }
    }
    
    func populateCell(playerData: Player, power: SuperPowersList) {
        playerImageView.image = playerData.getPlayerImage() ?? UIImage(named: "PlayerImagePlaceholder")
        playerNameLabel.text = playerData.getPlayerName()
        playerPowerLabel.text = power.superPowers[playerData.displayPower()].1
        if playerBeingSelected == 1  && hasBeenSelected == false {
            profileSelectButton.backgroundColor = UIColor.red
            profileSelectButton.setTitle("Select Profile as P1", for: .normal)
        } else if playerBeingSelected == 2  && hasBeenSelected == false {
            profileSelectButton.backgroundColor = UIColor.blue
            profileSelectButton.setTitle("Select Profile as P2", for: .normal)
        } else {
            profileSelectButton.backgroundColor = UIColor.purple
            profileSelectButton.setTitle("", for: .normal)
            profileSelectButton.isEnabled = false
        }
    }
    
    override func awakeFromNib() {
    }
}
