//
//  CategoryVC.swift
//  List
//
//  Created by Ljubomir Masirevic on 2/10/19.
//  Copyright © 2019 Ljubomir Masirevic. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {
    
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        context.delete(categoryArray[indexPath.row])
        categoryArray.remove(at: indexPath.row)
        saveItems()
        
    }
    
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            
              let newCategory = Category(context: self.context)
              newCategory.name = textField.text!


            self.categoryArray.append(newCategory)

            self.saveItems()
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category"
            textField = alertTextField
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems () {
        
        do {
            try context.save()
        } catch {
            print("Error Saving \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems () {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fatching data \(error)")
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListVC
        
        if let indexPatxxx = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPatxxx.row]
        }
        
    }
    
}
