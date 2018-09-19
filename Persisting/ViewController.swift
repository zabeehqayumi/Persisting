//
//  ViewController.swift
//  Persisting
//
//  Created by Zabeehullah Qayumi on 9/18/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    var itemArray = [Item]()
    
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    


    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
  
     

        
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newTextField = UITextField()
        let alert = UIAlertController(title: "Add Item ", message: "Please add your item", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = newTextField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItem()
            
            
            
            
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Please type here "
            newTextField = textField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        var item = itemArray[indexPath.row]
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    
    func saveItem(){
        do{
            try context.save()
         
        }catch{
            return
        }
        tableView.reloadData()
        
    }
    
    func loadItems(){
        
        let request : NSFetchRequest<Item>  = Item.fetchRequest()
 
            do{
                itemArray  = try context.fetch(request)
            }catch{
                return
            }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = itemArray[indexPath.row]
        item.done = !item.done
        saveItem()
        
        
    }
}
    


