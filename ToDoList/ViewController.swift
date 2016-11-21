//
//  ViewController.swift
//  ToDoList
//
//  Created by Olaf Kroon on 21/11/16.
//  Copyright © 2016 Olaf Kroon. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //TEMPORARY ARRAY FOR ID. THIS COULD PROBABLY BE REPLACED
    var idArray = [Int()]
    
   
    
//    var toDictionary: [Int: String] = [1: "Toronto Pearson", 2: "Dublin"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Return the amount of rows in the database.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 5
    }
    
    
    //Put the data of each row in a cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoCell
        
//        cell.checkLabel.text = idArray[indexPath.row]
//
//        if let checkDictionary = toDictionary[idArray[indexPath.row]] {
//            print (checkDictionary)
//            cell.toDo.text = checkDictionary
//        }

        
        return cell
    }
    
//     When the user deletes a cell, delete data from database.
     func tableView(_ commitforRowAttableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            idArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    
//             Add SQLite code here that deletes data at the given cell.
        }
    }
    


}

