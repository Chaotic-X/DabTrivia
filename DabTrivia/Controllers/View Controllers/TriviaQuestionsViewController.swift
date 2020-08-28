//
//  TriviaQuestionsViewController.swift
//  DabTrivia
//
//  Created by Ben Brandau Brandau on 8/27/20.
//  Copyright © 2020 DAB Fellows. All rights reserved.
//

import UIKit

class TriviaQuestionsViewController: UIViewController {
	
	@IBOutlet weak var questionlabel: UILabel!
	@IBOutlet weak var answerOneLabel: UIButton!
	@IBOutlet weak var answerTwoLabel: UIButton!
	@IBOutlet weak var answerThreeLabel: UIButton!
	@IBOutlet weak var answerFourLabel: UIButton!
	
	var questions: [Trivia] = []
	var correctAnswerArray: [String] = []
	var answerArray: [String] = []
	var number = 0
	var difficulty = ""
	lazy var count = number
	override func viewDidLoad() {
		super.viewDidLoad()
		startGame(with: difficulty, question: number)
		
	}
	
	//MARK: -Actions
	@IBAction func answerButtonTapped(_ sender: UIButton) {
		switch sender.tag {
			case 0:
				if answerOneLabel.title(for: .normal) == questions.first?.correct_answer {
					answerOneLabel.backgroundColor = .green
					answerTwoLabel.backgroundColor = .red
					answerThreeLabel.backgroundColor = .red
					answerFourLabel.backgroundColor = .red
				} else {
					print("You got it wrong")
					answerOneLabel.backgroundColor = .red
				}
			case 1:
				if answerTwoLabel.title(for: .normal) == questions.first?.correct_answer {
					answerOneLabel.backgroundColor = .red
					answerTwoLabel.backgroundColor = .green
					answerThreeLabel.backgroundColor = .red
					answerFourLabel.backgroundColor = .red
				} else {
					print("You got it wrong")
					answerTwoLabel.backgroundColor = .red
				}
			case 2:
				if answerThreeLabel.title(for: .normal) == questions.first?.correct_answer {
					answerOneLabel.backgroundColor = .red
					answerTwoLabel.backgroundColor = .red
					answerThreeLabel.backgroundColor = .green
					answerFourLabel.backgroundColor = .red
				} else {
					print("You got it wrong")
					answerThreeLabel.backgroundColor = .red
				}
			case 3:
				if answerFourLabel.title(for: .normal) == questions.first?.correct_answer {
					answerOneLabel.backgroundColor = .red
					answerTwoLabel.backgroundColor = .red
					answerThreeLabel.backgroundColor = .red
					answerFourLabel.backgroundColor = .green
				} else {
					print("You got it wrong")
					answerFourLabel.backgroundColor = .red
				}
			default:
				print("no go")
		}
	}
	
	@IBAction func nextButtonTapped(_ sender: Any) {
		
		count -= 1
		print(count)
		if count > 0 {
			questions.remove(at: 0)
			setupGame()
		} else {
			self.dismiss(animated: true, completion: nil)
//			navigationController?.popViewController(animated: true)
		}
	}
	
	
	//MARK: -Class Methods
	func startGame(with difficulty: String, question number: Int) {
		TriviaController.fetchQuestions(number: number, difficulty: difficulty) { (result) in
			DispatchQueue.main.async {
				switch result {
					case .success(let trivia):
						self.questions = trivia
						self.setupGame()
					case .failure(let error):
						print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
				}
			}
		}
	}
	func setupGame(){
		questionlabel.text = String(htmlEncodedString: questions.first?.question ?? "")
		self.correctAnswerArray = ["\(self.questions.first?.correct_answer ?? "")", "\(self.questions.first?.incorrect_answers[0] ?? "")", "\(self.questions.first?.incorrect_answers[1] ?? "")", "\(self.questions.first?.incorrect_answers[2] ?? "")"]
		self.answerArray = self.correctAnswerArray.shuffled()
		answerOneLabel.setTitle(String(htmlEncodedString: answerArray[0]),for: .normal)
		answerTwoLabel.setTitle(String(htmlEncodedString: answerArray[1]), for: .normal)
		answerThreeLabel.setTitle(String(htmlEncodedString: answerArray[2]), for: .normal)
		answerFourLabel.setTitle(String(htmlEncodedString: answerArray[3]), for: .normal)
	}
}

