//
//  MainMenuViewController.swift
//  SuperTicTacToe
//
//  Created by Work Mode on 12/20/19.
//  Copyright © 2019 Apps By Ennis. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var StandardStartButton: UIButton!
    @IBOutlet weak var SuperStartButton: UIButton!
    @IBOutlet weak var PlayerProfilesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //button styling
        StandardStartButton.layer.cornerRadius = 10.0;
        SuperStartButton.layer.cornerRadius = 10.0;
        PlayerProfilesButton.layer.cornerRadius = 10.0;
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
