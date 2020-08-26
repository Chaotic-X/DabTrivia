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
	
	static func fetchQuestions(number: Int, difficulty: String, completion: @escaping ([Trivia]?) -> Void) {
		//1 - Prepare URL
		guard let baseURL = baseURL else { return completion(nil) }
		var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		
		let amountQuery = URLQueryItem(name: amountTermKey, value: String(number))
		let difficultyQuery = URLQueryItem(name: difficultyTermKey, value: difficulty)
		components?.queryItems = [amountQuery, difficultyQuery]
		
		guard let finalURL = components?.url else { return completion(nil)}
		print(finalURL)
		
		URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
			if let error = error {
				print(error.localizedDescription)
				return completion(nil)
			}
			
			guard let data = data else { return completion(nil) }
			
			do {
				let toplevelobject = try JSONDecoder().decode(TriviaTopLevelObject.self, from: data)
				let triviaItems = toplevelobject.results
				return completion(triviaItems)
			} catch {
				print(error.localizedDescription)
				return completion(nil)
			}
		}.resume()
		
	}//end of function
	
	
}//end of class
