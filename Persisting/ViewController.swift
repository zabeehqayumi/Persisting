//
//  ViewController.swift
//  Persisting
//
//  Created by Zabeehullah Qayumi on 9/18/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var itemArray : [String] = []
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data =  defaults.array(forKey: "COOL") as? [String]{
            itemArray = data
        }
        
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newTextField = UITextField()
        let alert = UIAlertController(title: "Add Item ", message: "Please add your item", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.itemArray.append(newTextField.text!)
            self.defaults.set(self.itemArray, forKey: "COOL")
            self.tableView.reloadData()
            
            
            
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
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
}

