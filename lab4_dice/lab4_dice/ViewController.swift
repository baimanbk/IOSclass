//
//  ViewController.swift
//  lab4_dice
//
//  Created by nurshat serik on 16.10.2025.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftDiceImageView: UIImageView!
    @IBOutlet weak var rightDiceImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем фон
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backkk")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }

    @IBOutlet weak var roll: UIButton!
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let diceImages = [
            UIImage(named: "dice1"),
            UIImage(named: "dice2"),
            UIImage(named: "dice3"),
            UIImage(named: "dice4"),
            UIImage(named: "dice5"),
            UIImage(named: "dice6")
        ]

        leftDiceImageView.image = diceImages.randomElement()!
        rightDiceImageView.image = diceImages.randomElement()!
    }
}

