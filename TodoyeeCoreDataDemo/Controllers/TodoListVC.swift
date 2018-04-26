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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
      
    }
    
    //MARK:- METHODS
    //MARK:
    func initialSetup(){
     
        loadItem()
        
        print(dataFilePath!)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    
    //ENCODING DATA
    func saveDataItems(){
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("Error encoding item array. \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItem(){
        
        if let data = try? Data(contentsOf:dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array. \(error)")
            }
        }
        
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
           
           
            self.saveDataItems()
            
    
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
        self.saveDataItems()
   
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

