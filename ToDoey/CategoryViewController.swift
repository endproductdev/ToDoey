//
//  CategoryViewController.swift
//  ToDoey
//
//  Created by admin on 2/20/19.
//  Copyright © 2019 Eras Noel. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    var categories = [Chapter]()
    
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let chapter = categories[indexPath.row]
        
        cell.textLabel?.text = chapter.name
        
        
        //TERNARY OPERATOR ++>
        // value = condition ? valueIfTrue : valueIfFalse
        
        //cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Chapter", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIalert
            
            
            let newChapter = Chapter(context: self.context)
            newChapter.name = textField.text!
            
            self.categories.append(newChapter)
            
            
            self.saveChapters()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
    }
    
    func saveChapters()
    {
        do{
            try context.save()
        }catch{
            print("error saving chapter, \(error)")
        }
        tableView.reloadData()
    }
    //Load Categories
    func loadCategories(with request: NSFetchRequest<Chapter> = Chapter.fetchRequest()){
        //let request : NSFetchRequest<Chapter> = Chapter.fetchRequest()
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error fetching data \(error)")
        }
        tableView.reloadData()
    }

        //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
}






