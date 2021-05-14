//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Saurav Sawansukha on 5/11/21.
//

import UIKit


class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionTitle: UILabel!
    var correctAnswer = [[Int]] ()
    var question = [[String]]()
    var questionChoices = [[String]]()
    var answerLabel:String = ""
    var numQuestions: Int = 0
    var questionCounter: Int = 0
    var correctAnswerNum: Int = 0
    var userPicked: Int = 0 //index of what the user selected

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        questionTitle.text = question[questionCounter][0]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        numQuestions = question.count
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table", for: indexPath)
        
                
        cell.textLabel?.text = questionChoices[questionCounter][indexPath.row]
        
        return cell
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        let position = correctAnswer[questionCounter][0]
        
        userPicked = indexPath.row

        answerLabel = questionChoices[questionCounter][position]
    }
    
    @IBAction func submitToAnswer(_ sender: Any) {
                
        performSegue(withIdentifier: "answerSwitch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "answerSwitch" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = segue.destination as! Answer
                
                controller.current_question = questionTitle.text!
                
                controller.answerPicked = userPicked
                
                controller.indexOfAnswer = correctAnswer[questionCounter][0]
                
            
                controller.solutionLabel = answerLabel
                
                controller.questionArray = question
                
                controller.choiceArray = questionChoices
                
                controller.solutionArray = correctAnswer
 
                controller.questionUpdate = questionCounter
                
                controller.countCorrect = correctAnswerNum
                
                controller.questionArraySize = numQuestions
                
                if (questionCounter != numQuestions - 1) {
                    controller.questionUpdate = questionCounter + 1
                
                    controller.gameStatus = false
                    
                } else {
                    
                    controller.gameStatus = true
                    
                }

            }
        }
    }
    
}
