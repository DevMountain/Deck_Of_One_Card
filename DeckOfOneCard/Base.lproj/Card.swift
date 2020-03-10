//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Anthroman on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct TopLevelObject: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let image: URL
    let value: String
    let suit: String
}
