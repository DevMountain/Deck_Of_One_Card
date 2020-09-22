//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Trevor Bursach on 9/22/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var suitAndValueLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Actions
    
    @IBAction func drawNewCardButton(_ sender: Any) {
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
    func fetchImageAndUpdateViews(for card: Card) {
        CardController.fetchImage(for: card) { [weak self] (result) in
            DispatchQueue.main.async {
                
            switch result {
            case .success(let image):
                self?.cardImageView.image = image
                self?.suitAndValueLabel.text = "\(card.value) of \(card.suit)"
            case .failure(let error):
                self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }

} // END OF CLASS
