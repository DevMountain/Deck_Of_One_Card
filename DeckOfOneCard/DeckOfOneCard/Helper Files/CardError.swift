//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Clarissa Vinciguerra on 9/22/20.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case invalidData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Unable to reach the URL."
        case .thrownError(let error):
            return "We found an error: \(error.localizedDescription)"
        case .invalidData:
            return "Data was not found, or was invalid."
        }
    }
    
}
