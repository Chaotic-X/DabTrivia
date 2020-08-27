//
//  TriviaController.swift
//  DabTrivia
//
//  Created by Alex Lundquist on 8/26/20.
//

import Foundation

class TriviaController {
	
	static let baseURL = URL(string: "https://opentdb.com/api.php")
	static let amountTermKey = "amount"
	static let difficultyTermKey = "difficulty"
	
	static func fetchQuestions(number: Int, difficulty: String, completion: @escaping (Result<[Trivia], TriviaError>) -> Void) {
		//1 - Prepare URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
		var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		
		let amountQuery = URLQueryItem(name: amountTermKey, value: String(number))
		let difficultyQuery = URLQueryItem(name: difficultyTermKey, value: difficulty)
		components?.queryItems = [amountQuery, difficultyQuery]
		
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
		print(finalURL)
		
		URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
			if let error = error {
				print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
			}
			
            guard let data = data else { return completion(.failure(.noData)) }
			
			do {
				let toplevelobject = try JSONDecoder().decode(TriviaTopLevelObject.self, from: data)
				let triviaItems = toplevelobject.results
                return completion(.success(triviaItems))
			} catch {
				print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
			}
		}.resume()
		
	}//end of function
//CRUD
    
    
}//end of class
