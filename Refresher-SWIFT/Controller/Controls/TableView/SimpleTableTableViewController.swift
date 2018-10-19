//
//  SimpleTableTableViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 10/17/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

class SimpleTableTableViewController: UITableViewController {
    var languages = ["AMHARIC","ARABIC","BENGALI","BELARUSIAN","BULGARIAN","CHINESE - HONGKONG","CHINESE - SIMPLIFIED","GREEK","GUJARATI","HEBREW","HINDI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCellReuseIdentifier", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row]
        return cell
    }
}
