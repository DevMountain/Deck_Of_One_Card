//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Anthroman on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/")
    static let drawEndpoint = "draw/new/"
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        // 1 - Prepare URL
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let drawEndpointURL = baseURL.appendingPathComponent(drawEndpoint)
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: drawEndpointURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            // 4 - Check for json data
            guard let data = data else {return completion(.failure(.noData))}
            // 5 - Decode json into a Card
            do {
                let deck = try JSONDecoder().decode(Deck.self, from: data)
                guard let card = deck.cards.first else {return completion(.failure(.noData))}
                return completion(.success(card))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        // URL
        let cardImageURL = card.image
        // datatask
        URLSession.shared.dataTask(with: cardImageURL) { (data, _, error) in
        // error handling
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
         // check for data
            guard let data = data else {return completion(.failure(.noData))}
         // decode the data
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            return completion(.success(image))
        }.resume()
    }
}
