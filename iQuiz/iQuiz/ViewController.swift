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


struct Questions: Decodable {
    let title: String
    let desc: String

}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var first = [Dictionary<String, Any>]()
    
    var names:[String] = []
    
    var subtitle:[String] = []
    
    //var question = [[["What is 3 + 2?"], ["What is 6 X 2"]],[["When did Marvel Start"], ["Who is Iron Man?"]] , [["What is lighter than oxygen"], ["What does Na stand for?"]]]
    
    var question: [[[String]]] = []
    var choices: [[[String]]] = []
    var answer: [[[Int]]] = []
   // var choices = [[["5", "55", "0", "3"], ["12", "61", "45", "34"]], [["1209", "1945", "1939", "2000"], ["Chris Hemsworth", "Saurav", "Zen", "Robert Downey Jr."]], [["Chlorine", "Hydrogen", "Helium", "Argon"], ["Pink Salt", "Sodium", "Magnesium", "Chevron"]]]
    
    //var answer = [[[0], [0]],[[2], [3]], [[2], [1]]]
    
    var counter:Int = -1
    
    var chillin:String = "please change me"
    
    var newTry: [Questions] = []
    
    //var tests = Questions.init(json: ["title": "1"])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        
        DispatchQueue.global().async {
            let jsonUrlString = "http://tednewardsandbox.site44.com/questions.json"
            
            let url = URL(string: jsonUrlString)!
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {return}
                
                do{
                    
    //                save = try JSONDecoder().decode([Questions].self, from: data)
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

                    let save = (json as! [Dictionary<String, Any>])
                    
                    self.first = save
                    
                    for item in self.first{
                        
                        var anotherArray: [[String]] = []
                        
                        self.names.append(item["title"] as! String)
                        self.subtitle.append(item["desc"] as! String)
                        let questionsDict = item["questions"] as! [Dictionary<String, Any>]
                        //print(question["text"])
                        for questionTitle in questionsDict{
                        
                            
                            let printText = questionTitle["text"]!
                            var dummyArray:[String] = []
            
                            dummyArray.append(printText as! String)
                           // if(questionTitle)
                            anotherArray.append(dummyArray)
                            
                        }
                        self.question.append(anotherArray)
                        anotherArray.removeAll()
                        
                        var answersArray: [[String]] = []
                        for answerChoices in questionsDict{
                        
                            
                            let printText = answerChoices["answers"]!
                            answersArray.append(printText as! [String])
                            
                        }
                        self.choices.append(answersArray)
                        answersArray.removeAll()
                        
                        
                        var actualAnswerArray: [[Int]] = []
                        for answer in questionsDict{
                        
                            var answersArray: [Int] = []

                            var printText = answer["answer"]!
                            printText = Int(printText as! String)!
                            printText = printText as! Int - 1
                            print(printText)
                            answersArray.append(printText as! Int)
                            
                            actualAnswerArray.append(answersArray)

                        }
                        self.answer.append(actualAnswerArray)
                        answersArray.removeAll()
                        
                        
                        
                        
                    }
                    
                    print(self.answer)
                    
                    

                    //print(self.question)
                    
                    
                } catch let jsonErr {
                    print("Error right here: ", jsonErr)
                }
            }.resume()
        
            
            Thread.sleep(forTimeInterval: 0.5)
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()

            }
        }
        

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(names.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
    
                
            
                cell.textLabel?.text = self.names[indexPath.row]
                //print(cell.textLabel?.text)
                
                cell.detailTextLabel?.text = self.subtitle[indexPath.row]
                
            


  

 

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

