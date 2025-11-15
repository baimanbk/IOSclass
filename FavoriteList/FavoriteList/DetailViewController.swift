//
//  DetailViewController.swift
//  FavoriteList
//
//  Created by Baisal Kenesbek on 14.11.2025.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    // Будет приходить весь объект
    var item: FavoriteItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"

        guard let item = item else { return }

        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        reviewLabel.text = item.review
        imageView.image = UIImage(named: item.imageName)
    }
}
