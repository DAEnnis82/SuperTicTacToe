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
    let backgroundImage = UIImage(named: "SuperTTTSplashBackground")
    
    var modeSelected : Int?
    
    @IBAction func StandardGameButtonTapped(_ sender: Any) {
        modeSelected = 0
        performSegue(withIdentifier: "MainMenuToPlayerSelectSegue", sender: nil)
    }
    
    @IBAction func SuperGameButtonTapped(_ sender: Any) {
        modeSelected = 1
         performSegue(withIdentifier: "MainMenuToPlayerSelectSegue", sender: nil)
    }
    
    @IBAction func PlayerProfileButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "MainMenuToProfilesSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = UIColor(patternImage: backgroundImage!)
        self.view.backgroundColor = background
        
        //button styling
        StandardStartButton.layer.cornerRadius = 10.0;
        SuperStartButton.layer.cornerRadius = 10.0;
        PlayerProfilesButton.layer.cornerRadius = 10.0;
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainMenuToPlayerSelectSegue" {
            let vc = segue.destination as? PlayerSelectViewController
            vc?.mode = modeSelected ?? 0
        }
    }
    
}
