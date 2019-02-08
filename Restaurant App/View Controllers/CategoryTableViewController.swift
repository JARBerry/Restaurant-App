//
//  CategoryTableViewController.swift
//  Restaurant App
//
//  Created by James and Ray Berry on 05/02/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
  //  let menuController = MenuController()
    var categories = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        // load categories from the URL requests
        MenuController.shared.fetchCategories { (categories) in
            if let categories = categories {
                self.updateUI(with: categories)

            }
        }

    }
    // update screen with the categories
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // number of sections must be updated
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the number of categories taken from URL requests
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
      // Configure the cell...
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
    
    // Prepapre Segue for Menu Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
    }

    

}
