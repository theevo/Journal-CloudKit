//
//  EntryListTableViewController.swift
//  Journal-CloudKit
//
//  Created by theevo on 3/30/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEntries()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateViews()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.formatDate()
        
        return cell
    }
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    
    // MARK: - Helper Functions
    
    func loadEntries() {
        EntryController.shared.fetchAllEntries { (result) in
            self.updateViews()
        }
    }
    
    
    
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? EntryDetailViewController
                else { return }
            
            let selectedEntry = EntryController.shared.entries[indexPath.row]
            
            destinationVC.entryReceiver = selectedEntry
        }
    }
} // end class

