import UIKit

// 投稿一覧画面のセル
class MessageTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak internal var nameLabel: UILabel!
    @IBOutlet weak internal var photoImageView: UIImageView!
    @IBOutlet weak internal var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
