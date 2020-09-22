//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Clarissa Vinciguerra on 9/22/20.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let cards: [Cards]
}

struct Cards: Decodable {
    let value: String
    let suit: String
    let image: URL
}
