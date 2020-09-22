//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Trevor Bursach on 9/22/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck")
    static let drawCardEndpoint = "/new/draw/"
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
      // 1 - Prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        //"https://deckofcardsapi.com/api/deck"
        let cardURL = baseURL.appendingPathComponent(drawCardEndpoint)
        //"https://deckofcardsapi.com/api/deck/new/draw"
        
        var components = URLComponents(url: cardURL, resolvingAgainstBaseURL: true)
        let cardQuery = URLQueryItem(name: "count", value: "1")
        components?.queryItems = [cardQuery]
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        //"https://deckofcardsapi.com/api/deck/new/draw/?count=1"
        
        // 2 - Contact server
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
      // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
      // 4 - Check for json data
            guard let data = data else { return completion(.failure(.invalidData)) }
      // 5 - Decode json into a Card
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelDictionary.cards.first else { return }
                return completion(.success(card))
            } catch {
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result <UIImage, CardError>) -> Void) {

      // 1 - Prepare URL
        let url = card.image
      // 2 - Contact server
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
      // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
      // 4 - Check for image data
            guard let data = data else { return completion(.failure(.invalidData)) }
      // 5 - Initialize an image from the data
            guard let image = UIImage(data: data) else { return completion(.failure(.invalidData)) }
            return completion(.success(image))
        }.resume()
    }
    
} // END OF CLASS
