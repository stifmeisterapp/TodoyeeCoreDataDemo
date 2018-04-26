//
//  ViewController.swift
//  TodoyeeCoreDataDemo
//
//  Created by Callsoft on 25/04/18.
//  Copyright © 2018 Callsoft. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {
    
    //MARK:- VARIABLES
    //MARK:
    var itemArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
      
    }
    
    //MARK:- METHODS
    //MARK:
    func initialSetup(){
        let item1 = Item()
        item1.title = "Joe"
        itemArray.append(item1)
        
        let item2 = Item()
        item2.title = "Rob"
        itemArray.append(item2)
        
        let item3 = Item()
        item3.title = "Harry"
        itemArray.append(item3)
        
        let item4 = Item()
        item4.title = "Jim"
        itemArray.append(item4)
        
        let item5 = Item()
        item5.title = "Jules"
        itemArray.append(item5)
        if let items = UserDefaults.standard.value(forKey: "ITEM_ARRAY") as? [Item]{
            itemArray = items
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    //MARK:- ACTIONS
    //MARK:
    
    @IBAction func addBtnTapped(_ sender: Any) {
    
         var textFeild = UITextField()
    
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textFeild.text!
            self.itemArray.append(newItem)
            UserDefaults.standard.set(self.itemArray, forKey: "ITEM_ARRAY")
            self.tableView.reloadData()
    
        }
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create new item"
            textFeild = alertTextFeild
        }
        alert.addAction(action)

       present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    //MARK:- TABLEVIEW DATA SOURCE AND DELEGATES METHODS
    //MARK:
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell")
        cell?.textLabel?.text = itemArray[indexPath.row].title
        cell?.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
   
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

