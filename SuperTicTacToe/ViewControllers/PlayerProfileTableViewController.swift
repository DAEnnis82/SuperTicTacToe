//
//  PlayerProfileTableViewController.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/8/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

class PlayerProfileTableViewController: UITableViewController {
    
    private var table = PlayerTable.shared.sectionedSortedTable()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    @IBAction func unwindToPlayerProfileTableViewController(segue: UIStoryboard) {
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return PlayerTable.shared.sectionedSortedTable().count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      if section == 0 {
          return "Premade Accounts"
      } else {
          return String(table[section][0].getPlayerName().prefix(1).uppercased())
      }
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = table[section].count
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerProfileTableCell", for: indexPath) as! PlayerProfileCell
        cell.populatePlayer(playerData: table[indexPath.section][indexPath.row])

        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
           tableView.deselectRow(at: indexPath, animated: true)
        
       }
    
      override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        } else {
          return true
        }
    }

      
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let playerToDelete = table[indexPath.section][indexPath.row].getPlayerName()
            var sectionEmpty: Bool
            if table[indexPath.section].count == 1 {
                           sectionEmpty = true
                       } else {
                           sectionEmpty = false
                       }
            print("sectionEmpty: \(sectionEmpty)")
            PlayerTable.shared.deletePlayer(name: playerToDelete)
            self.table = PlayerTable.shared.sectionedSortedTable()
          
            tableView.beginUpdates()
            
            if !sectionEmpty {
              
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                
                tableView.deleteSections([indexPath.section], with: .fade)
            }
           
            tableView.endUpdates()
       
        } else if editingStyle == .insert {
            return// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
      }
    
      /*
      // Override to support rearranging the table view.
      override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

      }
      */

      /*
      // Override to support conditional rearranging of the table view.
      override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
          // Return false if you do not want the item to be re-orderable.
          return true
      }
      */

   
      // MARK: - Navigation

      // In a storyboard-based application, you will often want to do a little preparation before navigation
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          // Get the new view controller using segue.destination.
        if segue.identifier == "ProfileTableToPofileDetailViewSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let selectedPlayer = PlayerTable.shared.getPlayer(position: indexPath!.row)
            
            if let vc = segue.destination as? ProfileDetailViewController {
                vc.player = selectedPlayer
            }
        }
          // Pass the selected object to the new view controller.
      }
  
}

