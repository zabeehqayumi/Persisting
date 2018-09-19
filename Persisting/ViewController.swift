//
//  ViewController.swift
//  Persisting
//
//  Created by Zabeehullah Qayumi on 9/18/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UITableViewController {
    
    var itemArray : Results<Item>?
    
    let realm = try! Realm()
    
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    


    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
  
    
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newTextField = UITextField()
        let alert = UIAlertController(title: "Add Item ", message: "Please add your item", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = newTextField.text!
            self.saveItems(contents: newItem)

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
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = itemArray?[indexPath.row].title ?? ""
        return cell
    }
    
    
 
    func saveItems(contents : Item){
        do{
            try realm.write {
                realm.add(contents)
            }
        }
        catch{
            return
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        itemArray =  realm.objects(Item.self)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        
        
    }
}
    


