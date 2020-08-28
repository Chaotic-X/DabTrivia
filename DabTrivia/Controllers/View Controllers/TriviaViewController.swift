//
//  TriviaViewController.swift
//  DabTrivia
//
//  Created by Alex Lundquist on 8/26/20.
//

import UIKit

class TriviaViewController: UIViewController, isAbleToReceiveData {
	var sendingScore: Int = 0
	
	
	// Outlets
	
	@IBOutlet weak var easyModeButton: UIButton!
	@IBOutlet weak var mediumModebutton: UIButton!
	@IBOutlet weak var hardModebutton: UIButton!
	@IBOutlet weak var tenQuestionsButton: UIButton!
	@IBOutlet weak var fifteenQuestions: UIButton!
	@IBOutlet weak var tewntyQuestions: UIButton!
	@IBOutlet weak var highScoreLabel: UILabel!
	
	//MARK: Properties
	
	var numberOfQuestions = 10
	var difficulty: String = "easy"
	var highScore = 0
	//MARK: Lifecycles
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		highScoreTally()
	}
	// Actions
	@IBAction func easyButtonTapped(_ sender: Any) {
		difficulty = "easy"
	}
	@IBAction func mediumButtonTapped(_ sender: Any) {
		difficulty = "medium"
	}
	
	@IBAction func hardButtonTapped(_ sender: Any) {
		difficulty = "hard"
	}
	@IBAction func tenButtonTapped(_ sender: Any) {
		numberOfQuestions = 10
	}
	@IBAction func fifteenButtonTapped(_ sender: Any) {
		numberOfQuestions = 15
	}
	@IBAction func twentyButtonTapped(_ sender: Any) {
		numberOfQuestions = 20
	}
	@IBAction func beginGameButtonTapped(_ sender: Any) {
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let questionsNumber = self.numberOfQuestions
		let difficultyToSend = self.difficulty
		//						print("\(String(describing: questionsToSend.first?.correct_answer))")
		guard let destinationVC = segue.destination as? TriviaQuestionsViewController else {return}
		destinationVC.delegate = self
		destinationVC.number = questionsNumber
		destinationVC.difficulty = difficultyToSend
	}
	
	// Methods:
	func highScoreTally() {
		if highScore >= sendingScore {
			highScoreLabel.text = "\(highScore)"
		} else if highScore < sendingScore {
			highScore = sendingScore
			highScoreLabel.text = "\(highScore)"
		}
		
	}
}// end of class
