//
//  Trivia.swift
//  DabTrivia
//
//  Created by Alex Lundquist on 8/26/20.
//

import Foundation

struct TriviaTopLevelObject: Decodable {
	let results: [Trivia]
}

struct Trivia: Decodable {
	let difficulty: String
	let question: String
	let correct_answer: String
	let incorrect_answers: [String]
}

    
