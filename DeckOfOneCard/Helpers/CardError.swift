//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Anthroman on 3/10/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
}
