//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Clarissa Vinciguerra on 9/22/20.
//

import UIKit

class CardViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    func fetchImageAndUpdateViews(for card: Cards) {
        CardController.fetchImage(for: card) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
