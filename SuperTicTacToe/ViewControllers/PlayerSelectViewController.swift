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
    var searchActive = false
    var searchText : String?
    var filteredSearchTable : [Player] = []
    let powerIndex = SuperPowersList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        //searchTextField.addTarget(self, action: #selector(PlayerSelectViewController.textFieldDidChangeSelection(_:)), for: .editingChanged)
        
        selectPlayerLabelController()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
            searchTextField.resignFirstResponder()
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
        _ = textFieldShouldClear(searchTextField)
        playerProfileCollectionView?.reloadItems(at: playerProfileCollectionView!.indexPathsForVisibleItems)
    
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive && filteredSearchTable.count > 0 {
            print("in collectionView method")
            print("search Table size \(filteredSearchTable.count)")
            return filteredSearchTable.count
        } else {
             return PlayerTable.shared.tableSize()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("in the collection view method")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerProfileCell", for: indexPath) as! PlayerProfileCollectionViewCell
        if (player1 != nil && indexPath.item == player1) {
            cell.hasBeenSelected = true
            print("cell \(indexPath.item) selected as player1")
        } else if (player2 != nil && indexPath.item == player2) {
            cell.hasBeenSelected = true
            print("cell \(indexPath.item) selected as player2")
        } else {
            cell.hasBeenSelected = false
            print("cell \(indexPath.item) unselected")
        }
        cell.playerBeingSelected = playerBeingSelected
        if searchActive && filteredSearchTable.count > 0 {
            print("cells populating with search data")
            cell.player = filteredSearchTable[indexPath.item]
            cell.indexTag = PlayerTable.shared.getIndexOfPlayer(filteredSearchTable[indexPath.item].getPlayerName())
            cell.populateCell(playerData: filteredSearchTable[indexPath.item], power: powerIndex)
        } else {
        cell.player = PlayerTable.shared.getPlayer(position: indexPath.item)
        cell.indexTag = indexPath.item
        cell.populateCell(playerData: PlayerTable.shared.getPlayer(position: indexPath.item), power: powerIndex)
        }
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
        if segue.identifier == "StandardGameStartSegue" {
            if let vc = segue.destination as? GameBoardViewController {
                vc.player1 = player1 ?? 0
                vc.player2 = player2 ?? 1
            }
        }
    }

}
extension PlayerSelectViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     textField.resignFirstResponder()
        return true
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchText = searchTextField.text
        print("search text updated")
        filteredSearchTable = PlayerTable.shared.flatSortedTable(searchText!)
        playerProfileCollectionView.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchActive = true
        print("search mode active")
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchActive = false
        playerProfileCollectionView.reloadData()
        print("search mode ended")
        return true
    }
    

    
    
}


