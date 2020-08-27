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
    var difficulty:String {
        get {
            
        }
    }
    var numberOfQuestions
    

//MARK: Lifecycles
	var trivia: [Trivia] = []
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    // Actions
    
    @IBAction func beginGameButtonTapped(_ sender: Any) {
        prepare(for: UIStoryboardSegue, sender: <#T##Any?#>){
        
        }
    }
    // Methods:
    
}// end of class
