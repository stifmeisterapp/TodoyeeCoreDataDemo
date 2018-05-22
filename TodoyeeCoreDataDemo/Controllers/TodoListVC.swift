//
//  ViewController.swift
//  TodoyeeCoreDataDemo
//
//  Created by Callsoft on 25/04/18.
//  Copyright © 2018 Callsoft. All rights reserved.
//

import UIKit
import CoreData

class TodoListVC: UITableViewController {
    
    //MARK:- OUTLETS
    //MARK:
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:- VARIABLES
    //MARK:
    
    var itemArray = [Item]()
    var selectedCategories:Categories?{
        didSet{
        }
    }

    
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
      
    }
    
    //MARK:- METHODS
    //MARK:
    func initialSetup(){
     let request : NSFetchRequest<Item> = Item.fetchRequest()
        loadItem(with: request)
        print(dataFilePath!)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
       
    }
    
    
    //ENCODING DATA
    func saveDataItems(){
        
        
        do{
           try context.save()
        }catch{
            print("Error saving context. \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItem(with request:NSFetchRequest<Item> = Item.fetchRequest(),predcate:NSPredicate? = nil){

        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategories!.name!)
        if let additionalPredicate = predcate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }
        
        else{
            request.predicate = categoryPredicate
        }
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predcate])
//        request.predicate = compoundPredicate
        
        do{
         itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context. \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK:- ACTIONS
    //MARK:
    
    @IBAction func addBtnTapped(_ sender: Any) {
    
         var textFeild = UITextField()
    
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
           
            let newItem = Item(context: self.context)
            newItem.title = textFeild.text!
            newItem.done = false
            newItem.parent = self.selectedCategories
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
        
        //itemArray[indexPath.row].setValue("completed", forKey: "title") //Updating data into database
        
        //context.delete(itemArray[indexPath.row]) //Deleting item from database important order must retain
        //itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveDataItems()
   
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

//MARK:- SEARCH BAR EXTENTION
//MARK:

extension TodoListVC : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS %@[cd]", searchBar.text!)
        //request.predicate = predicate
        //request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        //let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        //request.sortDescriptors = [sortDescriptor]
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItem(with : request,predcate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0
        {
            loadItem()
            DispatchQueue.main.async {
             searchBar.resignFirstResponder()
            }
            
        }
    }
}

