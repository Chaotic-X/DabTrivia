//
//  TriviaViewController.swift
//  DabTrivia
//
//  Created by Alex Lundquist on 8/26/20.
//

import UIKit

class TriviaViewController: UIViewController {
	
	// Outlets
	
	@IBOutlet weak var easyModeButton: UIButton!
	@IBOutlet weak var mediumModebutton: UIButton!
	@IBOutlet weak var hardModebutton: UIButton!
	@IBOutlet weak var tenQuestionsButton: UIButton!
	@IBOutlet weak var fifteenQuestions: UIButton!
	@IBOutlet weak var tewntyQuestions: UIButton!
	
	//MARK: Properties
	
	var numberOfQuestions = 10
	var difficulty: String = "easy"
	
	//MARK: Lifecycles
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		destinationVC.number = questionsNumber
		destinationVC.difficulty = difficultyToSend
	}
	
	// Methods:

}// end of class
