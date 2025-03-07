//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by rasha  on 10/04/1443 AH.
//

import Foundation
import  UIKit

class ItemsViewController: UITableViewController {
    
    var filteredItems = [[Item]]()
    var itemStore: ItemStore! {
        didSet {
            // reload table each time new data is set
            filteredItems = itemStore.filterItemsBy()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        
        
        // Create a new item and add it to the store
        let newItem = itemStore.createitem()
        // Figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            // Turn off editing mode
            setEditing(false, animated: true)
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredItems.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Over $50"
        case 1:
            return "Under $50"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = filteredItems[indexPath.section][indexPath.row]
        
        // this is better for memory management but must be configued in IB
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
        
    }
}

