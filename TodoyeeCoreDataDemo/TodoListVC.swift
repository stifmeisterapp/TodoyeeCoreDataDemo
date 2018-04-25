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
    var itemArray = ["Joe","Mike","Harold","Jeff","Hefner"]

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
      
    }
    
    //MARK:- METHODS
    //MARK:
    func initialSetup(){
        if let items = UserDefaults.standard.value(forKey: "ITEM_ARRAY") as? [String]{
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
            self.itemArray.append(textFeild.text!)
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
        cell?.textLabel?.text = itemArray[indexPath.row]
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

