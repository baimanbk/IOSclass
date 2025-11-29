import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reviewTextView: UITextView!

    var item: FavoriteItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"

        guard item != nil else { return }

            // --- Image ---
        if let sys = UIImage(systemName: item.imageName) {
            coverImageView.image = sys
            coverImageView.tintColor = .label
            coverImageView.contentMode = .scaleAspectFit
            // аккуратный размер SF Symbol
            coverImageView.preferredSymbolConfiguration =
                UIImage.SymbolConfiguration(pointSize: 140, weight: .regular)
        } else {
            coverImageView.image = UIImage(named: item.imageName)
            coverImageView.contentMode = .scaleAspectFill
            coverImageView.clipsToBounds = true
        }

        // --- Texts ---
        titleLabel.text = item.title
        descriptionTextView.text = item.description
        reviewTextView.text = item.review
            // Внутри UIStackView, поэтому отключаем скролл, чтобы лейаут раскладывался
        for tv in [descriptionTextView, reviewTextView] {
            tv?.isEditable = false
            tv?.isScrollEnabled = false
            tv?.textContainerInset = .zero
            tv?.textContainer.lineFragmentPadding = 0
            tv?.font = .preferredFont(forTextStyle: .body)
        }
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        
    }
    // Разрешаем тексту растягиваться, чтобы не сжимался
    


//    static func instantiate() -> DetailViewController {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        return sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//    }
}
extension DetailViewController {
    static func instantiate() -> DetailViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
    }
}
