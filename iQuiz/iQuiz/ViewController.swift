//
//  ViewController.swift
//  iQuiz
//
//  Created by Saurav Sawansukha on 5/6/21.
//

import UIKit

class NameSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return(names.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        NSLog("tableView(_:numberofRowsInSection:)\(indexPath)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        cell.detailTextLabel?.text = subtitle[indexPath.row]
        
        return cell
    }
    
    let names = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    let subtitle = ["Calculus III basics", "Potion making class", "How to make fart smell nice"]
    

    
    
    

}

class ViewController: UIViewController {
    let data = NameSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = data
        tableView.tableFooterView = UIView()
    }


    @IBAction func alert(_ sender: Any) {
        let stop = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        
        stop.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(stop, animated: true)
    }
}

