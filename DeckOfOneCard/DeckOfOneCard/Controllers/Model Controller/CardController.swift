//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Clarissa Vinciguerra on 9/22/20.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/")
    static let cardEndpoint = "draw"
    
    static func fetchCard(completion: @escaping (Result <Cards, CardError>) -> Void) {
        //1 - prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let finalURL = baseURL.appendingPathComponent(cardEndpoint)
        print(finalURL)
        //2 - FETCH
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            //3 - handle errors
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            //4 - handle data
            guard let data = data else { return completion(.failure(.invalidData))}
            //5 - decode
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                if let card = topLevelDictionary.cards.first {
                    return completion(.success(card))
                }
                completion(.failure(.invalidData))
            } catch {
                print("There was an error: \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Cards, completion: @escaping (Result <UIImage, CardError>) -> Void) {
        
        // 1. perpare URL
        let imageURL = card.image
        
        // 2. Fetch
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            // 3. handle error
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            // 4. handle data
            guard let data = data else { return completion(.failure(.invalidData))}
            // 5. decode already decoded image so don't really need to decode anything. Instead use guard statement to make sure the image is already there. Return unwrapped image.
            guard let image = UIImage(data: data) else { return completion(.failure(.invalidData))}
            return completion(.success(image))
        }.resume()
    }
}// End of class
