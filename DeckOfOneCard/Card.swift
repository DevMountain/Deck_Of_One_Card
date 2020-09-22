//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Trevor Bursach on 9/22/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct Card: Decodable {
    var value: String
    var suit: String
    let image: URL
}

struct TopLevelObject: Decodable {
    var cards: [Card]
    
}// END OF CLASS
