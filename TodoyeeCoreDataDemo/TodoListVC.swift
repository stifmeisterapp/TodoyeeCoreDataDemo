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
    let itemArray = ["Joe","Mike","Harold","Jeff","Hefner"]

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
      
    }
    
    //MARK:- METHODS
    //MARK:
    func initialSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
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

