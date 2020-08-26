//
//  TriviaError.swift
//  DabTrivia
//
//  Created by Drew Miller on 8/26/20.
//  Copyright © 2020 DAB Fellows. All rights reserved.
//

import Foundation

enum TriviaError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL: your search term may not exist."
        case .thrownError(let error):
            return "Error! \(error.localizedDescription)"
        case .noData:
            return "No data: your search term may not exist."
        case .unableToDecode:
            return "Unable to decode your image from the data"
        }
    }
    
}
