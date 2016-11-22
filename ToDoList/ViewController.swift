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
    
    var toDolist = [Int: String]()
    
    var toDoId: Int?

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var enterToDo: UITextField!
    @IBOutlet weak var toDoButton: UIButton!
    
    private let db = DatabaseHelper()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if db == nil {
            print("Error")
        }
        
        
        // Create a restoration id for the view
        restorationIdentifier = "ViewController"
        restorationClass = ViewController.self
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Return the amount of rows in the database.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = Int()
        
        do {
            
        count = try db!.amountOfRows()!
            
        } catch {
            print(error)
        }

        return count
    }
    
    
    //Put the data of each row in a cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoCell
        
        var toDoString = String()
        
        do {
            toDoString = try db!.read(index: indexPath.row)!
        } catch {
            print (error)
        }
        cell.checkLabel.text = toDoString
        
        return cell
    }
    
    // Make rows Editable.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    // Enable the user to delete rows.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            do {
                try db!.delete(index: indexPath.row)
            } catch {
                print(error)
            }
            
            self.tableView.reloadData()
        }
    }
    
    // insert the contents of the text field in the database and tableviewcontroller
    @IBAction func insertToDo(_ sender: Any) {
        
        if toDoButton.isTouchInside {
            
            // Insert textfield into database
            do {
                try db!.create(toDo: enterToDo.text!)
            
            } catch {
                print (error)
            }
            
            
        }
        
        // Update tableview
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        
    }
    
    
    // When the user quits the app encode state.
    override func encodeRestorableState(with coder: NSCoder) {
       
        
        if let toDoItem = enterToDo.text {
            coder.encode(toDoItem, forKey: "toDoItem")
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    // When the user opens the app. Decode state.
    override func decodeRestorableState(with coder: NSCoder) {
        
        
        if let toDoItem = coder.decodeObject(forKey: "toDoItem") as? String {
            enterToDo.text = toDoItem
        }
    
        
        super.decodeRestorableState(with: coder)
    }
    
    
}

// Restore view.
extension ViewController: UIViewControllerRestoration {
    static func viewController(withRestorationIdentifierPath identifierComponents: [Any],
                               coder: NSCoder) -> UIViewController? {
        let vc = ViewController()
        return vc
    }
}


