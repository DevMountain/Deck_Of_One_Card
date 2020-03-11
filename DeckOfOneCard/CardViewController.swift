//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Anthroman on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func fetchImageAndUpdateViews(for card: Card) {
        CardController.fetchImage(for: card) { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let image):
                    self?.cardNameLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImage.image = image
                    
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func drawButtonTapped(_ sender: UIButton) {
        CardController.fetchCard { [weak self] (result) in
            switch result {
            case .success(let card):
                self?.fetchImageAndUpdateViews(for: card)
            case .failure(let error):
                self?.presentErrorToUser(localizedError: error)
            }
        }
    }
    
    func setupViews() {
        cardNameLabel.layer.cornerRadius = 20
    }
}
