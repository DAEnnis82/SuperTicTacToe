import UIKit

class MainMenuViewController: UIViewController {

    // Current guidance from Apple (which has flip-flopped in the past)
    // is to have outlets be `strong` not `weak`.
    // Part of the reasoning here is that during animations and view adjustments
    // views are sometimes taken out of the view hierarchy.
    // https://stackoverflow.com/a/31395938
    @IBOutlet var StandardStartButton: UIButton!
    // outlet names should be cammelCase and start with a lowercase letter.
    // generally speaking you might consider installing SwiftLint which can point out
    // such coding standards.
    @IBOutlet var SuperStartButton: UIButton!
    // I also make my own outlets `UIButton?` for safer access, though I acknoledge
    // Apple demo code used bang ! -- I use SwiftLint rules that disallow all bangs.
    @IBOutlet var PlayerProfilesButton: UIButton!
    let backgroundImage = UIImage(named: "SuperTTTSplashBackground")
    
    // If this is only going to be used internally, consider making `private`.
    // Also if the mode is a strict list of possibilities, consider using an Enum value.
    var modeSelected : Int?
    
    // Unless you are going to use the `sender` you can drop the argument in these IBAction calls.
    // If in the future you DO use the `sender` consider making the expected type specific like UIButton
    @IBAction func standardGameButtonTapped(_ sender: Any) {
        modeSelected = 0
        // Consider making a String value-based Enum to hold constants like this.
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
        
        // If you are going to use this `background` variable, consider making the bellow a one liner.
        let background = UIColor(patternImage: backgroundImage!)
        self.view.backgroundColor = background
        
        // Any time you write a comment like it its a smell that you might have been better off
        // with a self describing function name `applyButtonStyles()`.
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
