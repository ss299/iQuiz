//
//  ViewController.swift
//  iQuiz
//
//  Created by Saurav Sawansukha on 5/6/21.
//

import UIKit

//class NameSource: NSObject, UITableViewDataSource{
//    
//    let names = ["Mathematics", "Marvel Super Heroes", "Science"]
//    
//    let subtitle = ["Calculus III basics", "Potion making class", "How to make fart smell nice"]
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return(names.count)
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////        NSLog("tableView(_:numberofRowsInSection:)\(indexPath)")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
//        
//        cell.textLabel?.text = names[indexPath.row]
//        
//        cell.detailTextLabel?.text = subtitle[indexPath.row]
//        
//        return cell
//    }
//    
//
//    
//
//}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let names = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    let subtitle = ["Calculus III basics", "Potion making class", "How to make fart smell nice"]
    
    let question = [[["What is 3 + 2?"], ["What is 6 X 2"]],[["When did Marvel Start"], ["Who is Iron Man?"]] , [["What is lighter than oxygen"], ["What does Na stand for?"]]]
    
    let choices = [[["5", "55", "0", "3"], ["12", "61", "45", "34"]], [["1209", "1945", "1939", "2000"], ["Chris Hemsworth", "Saurav", "Zen", "Robert Downey Jr."]], [["Chlorine", "Hydrogen", "Helium", "Argon"], ["Pink Salt", "Sodium", "Magnesium", "Chevron"]]]
    
    let answer = [[[0], [0]],[[2], [3]], [[2], [1]]]
    
    var counter:Int = 0
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return(names.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        cell.detailTextLabel?.text = subtitle[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        counter = indexPath.row
        performSegue(withIdentifier: "quizSelector", sender: cell)
        }
    
    @IBAction func alert(_ sender: Any) {
        let stop = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        
        stop.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(stop, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizSelector" {
                let parser = segue.destination as! QuestionViewController
                parser.question = question[counter]
                parser.questionChoices = choices[counter]
                parser.correctAnswer = answer[counter]
                
        }
    }
    
    
}

