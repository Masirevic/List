//
//  ToDoExtension.swift
//  List
//
//  Created by Ljubomir Masirevic on 2/9/19.
//  Copyright © 2019 Ljubomir Masirevic. All rights reserved.
//

import UIKit
import CoreData



extension ToDoListVC: UISearchBarDelegate  {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
         loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           
        }
    }
    
    
    }
    









