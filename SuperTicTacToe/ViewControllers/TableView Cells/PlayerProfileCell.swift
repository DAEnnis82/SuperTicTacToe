import UIKit

class PlayerProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
        
    func populatePlayer(playerData: Player) {
        playerNameLabel.text = playerData.getPlayerName()
        profileImageView.image = playerData.getPlayerImage() ?? UIImage(named: "PlayerImagePlaceholder")
    }

}
