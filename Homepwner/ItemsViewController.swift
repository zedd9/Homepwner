//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by 신현욱 on 2021/02/25.
//

import UIKit

class ItemsViewController: UITableViewController
{
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    @IBAction func addNewItem(sender: AnyObject)
    {
        //_ = itemStore.createItem()
        // tableView.reloadData()
        
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
       
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell

        cell.updateLabels()
        
        if indexPath.row == itemStore.allItems.count {
            cell.nameLabel.text = "No more items!"
            cell.serialNumberLabel.text = ""
            cell.valueLabel.text = ""
            cell.isUserInteractionEnabled = false
        } else {
            let item = itemStore.allItems[indexPath.row]
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
            
            if item.valueInDollars >= 50 {
                cell.valueLabel.textColor = UIColor.red
            } else {
                cell.valueLabel.textColor = UIColor.green
            }
            
            cell.isUserInteractionEnabled = true
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == itemStore.allItems.count {
            return
        }
        
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancleAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancleAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (acction) in
                self.itemStore.removeItem(item: item)
                
                self.imageStore.deleteImageForKey(key: item.itemKey)
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            ac.view.translatesAutoresizingMaskIntoConstraints = false
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == itemStore.allItems.count {
            return sourceIndexPath
        }
        
        return proposedDestinationIndexPath
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == itemStore.allItems.count {
            return false
        }
        else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == itemStore.allItems.count {
            return false
        }
        else {
            return true
        }
    }    
  
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            if let row = tableView.indexPathForSelectedRow?.row , row < itemStore.allItems.count{
                
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewConroller
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
