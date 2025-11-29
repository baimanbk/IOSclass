import UIKit

final class FavoriteCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.backgroundColor = .systemYellow
        iconImageView.image = UIImage(systemName: "star.fill")
        iconImageView.tintColor = .label
        iconImageView.contentMode = .scaleAspectFit
    }

    func configure(with item: FavoriteItem) {
        titleLabel.text = item.title
        if let sys = UIImage(systemName: item.imageName) {
            iconImageView.image = sys
            iconImageView.tintColor = .label
            iconImageView.contentMode = .scaleAspectFit
        } else {
            iconImageView.image = UIImage(named:item.imageName)
            iconImageView.contentMode = .scaleAspectFill
            iconImageView.clipsToBounds = true
        }
    }
}
