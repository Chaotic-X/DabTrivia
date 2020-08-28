//
//  TriviaQuestionsViewController.swift
//  DabTrivia
//
//  Created by Ben Brandau Brandau on 8/27/20.
//  Copyright © 2020 DAB Fellows. All rights reserved.
//

import UIKit
protocol isAbleToReceiveData: class {
	var sendingScore: Int {get set}  //data: string is an example parameter
}
class TriviaQuestionsViewController: UIViewController {
	
	//MARK: -Outlets
	@IBOutlet weak var questionlabel: UILabel!
	@IBOutlet weak var answerOneButton: UIButton!
	@IBOutlet weak var answerTwoButton: UIButton!
	@IBOutlet weak var answerThreeButton: UIButton!
	@IBOutlet weak var answerFourButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var progressLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	
	//MARK: -Properties
	var questions: [Trivia] = []
	var correctAnswer: String = ""
	var correctAnswerArray: [String] = []
	var answerArray: [String] = []
	var number = 0
	var difficulty = ""
	lazy var buttonArray = [answerOneButton, answerTwoButton, answerThreeButton, answerFourButton]
	var count = 0
	var score = 0
	weak var delegate: isAbleToReceiveData?
	override func viewDidLoad() {
		super.viewDidLoad()
		startGame(with: difficulty, question: number)
		answerOneButton.backgroundColor = .systemGray3
		answerTwoButton.backgroundColor = .systemGray3
		answerThreeButton.backgroundColor = .systemGray3
		answerFourButton.backgroundColor = .systemGray3
		scoreLabel.text = "0"
		
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		delegate? .sendingScore = score
	}
	//MARK: -Actions
	@IBAction func answerButtonTapped(_ sender: UIButton) {
		for i in buttonArray where i?.title(for: .normal) == String(htmlEncodedString: questions.first?.correct_answer ?? "") {
			guard let correct = i else { return }
			switch correct {
				case answerOneButton:
					answerOneButton.backgroundColor = .green
					answerTwoButton.backgroundColor = .red
					answerThreeButton.backgroundColor = .red
					answerFourButton.backgroundColor = .red
					answerEnabled()
					nextButtonState()
				case answerTwoButton:
					answerOneButton.backgroundColor = .red
					answerTwoButton.backgroundColor = .green
					answerThreeButton.backgroundColor = .red
					answerFourButton.backgroundColor = .red
					answerEnabled()
					nextButtonState()
				case answerThreeButton:
					answerOneButton.backgroundColor = .red
					answerTwoButton.backgroundColor = .red
					answerThreeButton.backgroundColor = .green
					answerFourButton.backgroundColor = .red
					answerEnabled()
					nextButtonState()
				case answerFourButton:
					answerOneButton.backgroundColor = .red
					answerTwoButton.backgroundColor = .red
					answerThreeButton.backgroundColor = .red
					answerFourButton.backgroundColor = .green
					answerEnabled()
					nextButtonState()
				default:
					break
			}
		}
		if sender.backgroundColor == .green {
			switch difficulty {
				case "easy":
					score += 5
					scoreLabel.text = "\(score)"
				case "medium":
					score += 10
					scoreLabel.text = "\(score)"
				case "hard":
					score += 15
					scoreLabel.text = "\(score)"
				default:
					print("no points")
			}
		}
	}
	
	@IBAction func nextButtonTapped(_ sender: Any) {
		clearButtonState()
		answerEnabled()
		count += 1
		print(count)
		if count < number {
			questions.remove(at: 0)
			setupGame()
		} else {
			self.dismiss(animated: true, completion: nil)
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
		progressLabel.text = "\(count + 1) of \(number)"
		nextButton.isEnabled = false
//		nextButton.backgroundColor = .clear
		nextButton.tintColor = .systemGray
		questionlabel.text = String(htmlEncodedString: questions.first?.question ?? "")
		correctAnswer = String(htmlEncodedString: questions.first?.correct_answer ?? "") ?? ""
		self.correctAnswerArray = ["\(self.questions.first?.correct_answer ?? "")", "\(self.questions.first?.incorrect_answers[0] ?? "")", "\(self.questions.first?.incorrect_answers[1] ?? "")", "\(self.questions.first?.incorrect_answers[2] ?? "")"]
		self.answerArray = self.correctAnswerArray.shuffled()
		answerOneButton.setTitle(String(htmlEncodedString: answerArray[0]),for: .normal)
		answerTwoButton.setTitle(String(htmlEncodedString: answerArray[1]), for: .normal)
		answerThreeButton.setTitle(String(htmlEncodedString: answerArray[2]), for: .normal)
		answerFourButton.setTitle(String(htmlEncodedString: answerArray[3]), for: .normal)
	}
	
	func clearButtonState(){
		answerOneButton.backgroundColor = .systemGray3
		answerTwoButton.backgroundColor = .systemGray3
		answerThreeButton.backgroundColor = .systemGray3
		answerFourButton.backgroundColor = .systemGray3
		nextButtonState()
	}
	func answerEnabled(){
		answerOneButton.isEnabled.toggle()
		answerTwoButton.isEnabled.toggle()
		answerThreeButton.isEnabled.toggle()
		answerFourButton.isEnabled.toggle()
	}
	func nextButtonState(){
		nextButton.isEnabled.toggle()
		(nextButton.tintColor == .blue) ? (nextButton.tintColor = .systemGray) : (nextButton.tintColor = .blue)
	}
}

