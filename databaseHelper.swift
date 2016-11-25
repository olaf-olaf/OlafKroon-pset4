//
//  databaseHelper.swift
//  ToDoList
//
//  Created by Olaf Kroon on 22/11/16.
//  Copyright © 2016 Olaf Kroon. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
   
    
    private let toDoList = Table("list")
    private let id = Expression<Int>("id")
    private let toDo = Expression<String?>("toDo")
    
    private var db: Connection?
    
    init?() {
        do{
            try setupDatabase()
        } catch {
            print (error)
            return nil
        }
    }
    private func setupDatabase() throws{
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            try createTable()
        } catch {
            throw error
        }
    }
    
    private func createTable() throws {
        
        do {
            try db!.run(toDoList.create(ifNotExists: true) {
                
                t in
                
                t.column(id, primaryKey: .autoincrement)
                t.column(toDo)
                
            })
            
        } catch{
            throw error
        }
    }
   
//   func showTutorial() throws {
//      for hint in instructions {
//         let insert = toDoList.insert(self.toDo <- hint)
//         do {let rowId = try db!.run(insert)
//            print("ROWID: ", rowId)
//            
//         } catch {
//            throw error
//         }
//         
//      }
//   }
   
    // Insert a element into the table.
    func create(toDo: String) throws {
        let insert = toDoList.insert(self.toDo <- toDo)
        
        do {
            let rowId = try db!.run(insert)
            print("ROWID: ", rowId)
        } catch {
            throw error
        }
    }
    
    
    // Return a toDo with an id that corresponds to the tablerow
    func read(index: Int) throws -> String? {
    var result: String?
    var count = 0
    
    do {
        
        for row in try db!.prepare(toDoList) {
            if count == index {
                result = row[toDo]
            }
            count = count + 1
        }
    
    } catch {
    throw error
    }
    return result
    }
    
    // Delete a row where id = rowid.
    func delete(index: Int) throws {
        var rowId = Int()
        
        var count = 0
        
        //let target = toDoList.filter(id == rowid)
        
        do{
            for checkId in try db!.prepare(toDoList) {
                if count == index {
                    rowId = checkId[id]
                }
                count = count + 1
                
            }
            
            let location = toDoList.filter(id == rowId)
            try db!.run(location.delete())
        } catch {
            
            throw error
            
        }
        
    }
    
    // Get the amount of rows in a table
    func amountOfRows() throws -> Int? {
        var count = Int()
        do {
            for _ in try db!.prepare(toDoList) {
                count = count + 1
            }
        } catch {
            throw error
        }
        return count
    }
}
