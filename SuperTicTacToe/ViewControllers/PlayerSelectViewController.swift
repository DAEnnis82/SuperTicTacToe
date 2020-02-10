//
//  PlayerSelectViewController.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/18/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

class PlayerSelectViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, PlayerProfileCollectionViewCellDelegate {
   
    @IBOutlet weak var selectPlayerLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var playerProfileCollectionView: UICollectionView!
    @IBOutlet weak var startGameButton: UIButton!
    
    var playerBeingSelected = 1
    var player1 : Int?
    var player2 : Int?
    var mode : Int?
    let powerIndex = SuperPowersList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let player1 = players.getPlayer(position: 0)
        //let player2 = players.getPlayer(position: 1)
        // Do any additional setup after loading the view.
        selectPlayerLabelController()
    }
    

    @IBAction func startGameButtonTapped(_ sender: Any) {
        
        if (mode == 0) {
            performSegue(withIdentifier: "StandardGameStartSegue", sender: nil)
        } else if (mode == 1) {
            performSegue(withIdentifier: "SuperGameStartSegue", sender: nil)
        } else {
            fatalError()
        }
        
        
    }
    
    func selectPlayerLabelController() {
        if playerBeingSelected == 1 {
            selectPlayerLabel.text = "Select Player 1!"
            selectPlayerLabel.backgroundColor = UIColor.red
            selectPlayerLabel.textColor = UIColor.white
        } else if playerBeingSelected == 2 {
            selectPlayerLabel.text = "Select Player 2!"
            selectPlayerLabel.backgroundColor = UIColor.blue
            selectPlayerLabel.textColor = UIColor.white

        } else {
            selectPlayerLabel.text = "Prepare to Play!"
            selectPlayerLabel.backgroundColor = UIColor.green
            selectPlayerLabel.textColor = UIColor.yellow
        }
    }
    
    func didTapSelectProfile(playerSelected: Player, indexTag: Int) {
        if (playerBeingSelected == 1) {
            player1 = indexTag
            } else {
            player2 = indexTag
            }
        playerBeingSelected += 1
        selectPlayerLabelController()
        if let indexPath = playerProfileCollectionView?.indexPathsForVisibleItems {
            playerProfileCollectionView?.reloadItems(at: indexPath)
        }
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PlayerTable.shared.tableSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerProfileCell", for: indexPath) as! PlayerProfileCollectionViewCell
        cell.playerBeingSelected = playerBeingSelected
        cell.player = PlayerTable.shared.getPlayer(position: indexPath.item)
        cell.indexTag = indexPath.item
        cell.populateCell(playerData: PlayerTable.shared.getPlayer(position: indexPath.item), power: powerIndex)
        cell.delegate = self
        
        return cell
        
    }
    
   
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "SuperGameStartSegue" {
            if let vc = segue.destination as? SuperGameBoardViewController {
                vc.player1 = player1 ?? 0
                vc.player2 = player2 ?? 1
            }
        }
    }

}
