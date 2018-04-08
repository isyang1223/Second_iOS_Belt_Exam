//
//  ContactListTableViewController.swift
//  Second iOS Belt Exam
//
//  Created by Ian Yang on 3/27/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit
import CoreData


class ContactListTableViewController: UITableViewController {
    
    var items = [ContactListItem]()
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ContactListTableViewController: AddItemViewControllerDelegate, UIActionSheetDelegate, ItemViewControllerDelegate {

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chooseType(indexPath: indexPath)
    }
    
    func chooseType(indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let viewButton = UIAlertAction(title: "View", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.performSegue(withIdentifier: "showItemSegue", sender: indexPath)
            
            
        })
        let editButton = UIAlertAction(title: "edit", style: .default, handler: { (action) -> Void in
            print("edit button tapped")
            self.performSegue(withIdentifier: "editItemSegue", sender: indexPath)
        })
        
        let  deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            print("Delete button tapped")
            let item = self.items[indexPath.row]
            print(item)
            self.manageObjectContext.delete(item)
            self.appDelegate.saveContext()
            
            self.items.remove(at: indexPath.row)
            self.tableView.reloadData()
            

        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(viewButton)
        alertController.addAction(editButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
    
        cell.titleLabel?.text = items[indexPath.row].firstName! + " " + items[indexPath.row].lastName!
        cell.detailTextLabel?.text = items[indexPath.row].number
        cell.indexPath = indexPath
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editItemSegue" {
        let navigationController = segue.destination as! UINavigationController
        let addItemViewController = navigationController.topViewController as! AddItemViewController
        addItemViewController.delegate = self
        
        if let indexPath = sender as? IndexPath {
            let item = items[indexPath.row]
            addItemViewController.firstName = item.firstName!
            addItemViewController.lastName = item.lastName!
            addItemViewController.number = item.number!

            addItemViewController.indexPath = indexPath
            }
        }
        if segue.identifier == "showItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let ItemViewController = navigationController.topViewController as! ItemViewController
            ItemViewController.delegate = self
            
            if let indexPath = sender as? IndexPath {
                let item = items[indexPath.row]
                ItemViewController.firstName = item.firstName!
                ItemViewController.lastName = item.lastName!
                ItemViewController.number = item.number!
                
                ItemViewController.indexPath = indexPath
            }
        }
            
            
        }
    
    

    
    func fetchAllItems() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactListItem")

        do{
            let result = try manageObjectContext.fetch(request)
            items = result as! [ContactListItem]
            print(items)
        } catch {
            print("\(error)")
        }
    }
    
    func itemSaved(by controller: AddItemViewController, with1 firstName: String, with2 lastName: String, with3 number: String, at indexPath: IndexPath?) {
        if let ip = indexPath {
            let item = items[ip.row]
            item.firstName = firstName
            item.lastName = lastName
            item.number = number
            
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "ContactListItem", into: manageObjectContext) as! ContactListItem
            item.firstName = firstName
            item.lastName = lastName
            item.number = number
            
            items.append(item)
            
        }
        
        appDelegate.saveContext()
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    func cancelButtonPressed(by controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
        print("2")
    }
    func doneButtonPressed(by controller: ItemViewController) {
        dismiss(animated: true, completion: nil)
    }

}
