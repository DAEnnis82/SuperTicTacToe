//
//  AddPlayerViewController.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 1/11/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit

class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var CreateNewPlayerLabel: UILabel!
    @IBOutlet weak var PlayerNameTextField: UITextField!
    @IBOutlet weak var ChoosePowerLabel: UILabel!
    @IBOutlet weak var PowerDescriptionLabel: UILabel!
    @IBOutlet weak var choosePowerTextField: UITextField!
    
    var powerPicker = UIPickerView()
    var playerName: String?
    var playerPower: Int?
    var powerIndex = SuperPowersList()
    
    @IBAction func CreatePlayerButtonTapped(_ sender: Any) {
        guard let playerName = PlayerNameTextField.text, !playerName.isEmpty && playerName != " " else {
            return
        }
        guard playerPower != nil else {
            return
        }
        if PlayerTable.shared.playerExists(name: playerName) {
            return
        }
        PlayerTable.shared.addPlayer(name: PlayerNameTextField.text!, sPower: playerPower!)
        _ = PlayerTable.shared.sectionedSortedTable()
        navigationController?.popViewController(animated: true)
        //performSegue(withIdentifier: "unwindToPlayerProfileTableViewController", sender: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func createPicker() {
        powerPicker.delegate = self
        powerPicker.delegate?.pickerView?(powerPicker, didSelectRow: 0, inComponent: 0)
        choosePowerTextField.inputView = powerPicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return powerIndex.superPowers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        choosePowerTextField.text = powerIndex.superPowers[row].1
        PowerDescriptionLabel.text = powerIndex.superPowers[row].2
        return powerIndex.superPowers[row].1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerPower = row
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
extension AddPlayerViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     textField.resignFirstResponder()
        return true
        
    }
}
