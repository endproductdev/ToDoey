//
//  ViewController.swift
//  ToDoey
//
//  Created by admin on 2/11/19.
//  Copyright © 2019 Eras Noel. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        print(dataFilePath!)
        
        let newItem = Item()
        newItem.title = "Find Mike"
        newItem.done=true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Get down with ya bad self"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Stay Woke"
       itemArray.append(newItem3)
        

loadItems()
    
        
    }

    //MARK - Table view Datasource Methods
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        //TERNARY OPERATOR ++>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TABLEVIEW DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
      
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   //MARK - ADD New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIalert
           let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
    
            let encoder = PropertyListEncoder()
            
         self.saveItems()
            
       
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("error encoding item array, \(error)")
        }
      tableView.reloadData()
    }
    
    
    //Load Items
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
    
    
    
    
}



