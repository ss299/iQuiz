//
//  Answer.swift
//  iQuiz
//
//  Created by Saurav Sawansukha on 5/11/21.
//

import UIKit

class Answer: UIViewController {

    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    
    var current_question = "Question For Now"
    var answerPicked = 0
    var indexOfAnswer = 0
    var solutionLabel = ""
    var questionUpdate = 0
    var countCorrect = 0
    var questionArraySize = 0
    var gameStatus = true
    
    var questionArray = [[String]]()
    var choiceArray = [[String]]()
    var solutionArray = [[Int]]()



    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        question.text = current_question
        
        if (answerPicked == indexOfAnswer) {
            comment.text = "Correct dawg!"
            countCorrect = countCorrect + 1
        } else {
            comment.text = "Stop being on TikTok and go study!"
        }
        
        answer.text = solutionLabel

    }
    

    @IBAction func next(_ sender: Any) {
        
        if (gameStatus == true) {
            performSegue(withIdentifier: "answerToFinal", sender: self)

            
        } else {
            performSegue(withIdentifier: "answerToQuestion", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "answerToQuestion" {

                let controller = segue.destination as! QuestionViewController
            
                controller.correctAnswer = solutionArray
                controller.questionChoices = choiceArray
                controller.question = questionArray
                controller.questionCounter = questionUpdate
                controller.correctAnswerNum = countCorrect
            
        } else {
            let controller = segue.destination as! Final
            controller.totalCorrect = countCorrect
            controller.questionArraySize = questionArraySize
        }
    }
    
}
