//
//  OrderTableViewController.swift
//  Restaurant App
//
//  Created by James and Ray Berry on 05/02/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController, AddToOrderDelegate {
   
    

    var menuItems = [MenuItem]()
    var orderMinutes: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

    }
    // added menu items
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        let count = menuItems.count
        let indexPath = IndexPath(row: count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }
    
  // update badge number
    func updateBadgeNumber() {
        let badgeValue = menuItems.count > 0 ?
        "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
 // confirm order button tapped
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal = menuItems.reduce(0.0) { (result, menuItem) -> Double in
            return result + menuItem.price
            
        }
        let formattedOrder = String(format: "£%.2f", orderTotal)
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in
            self.uploadOrder()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // post order to URL
    func uploadOrder() {
        let menuIds = menuItems.map {$0.id}
        MenuController.shared.submitOrder(menuIds: menuIds)
        { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    // dismiss button pressed go back to order screen
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
            menuItems.removeAll()
            tableView.reloadData()
            updateBadgeNumber()
        }
        
    }
    
    
    // prepare confirmation screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination as!OrderConfirmationViewController
            orderConfirmationViewController.minutes = orderMinutes
        }
    }

    // MARK: - Table view data source

    // number of section is only 1
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    // number of rows is the totl of menu items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuItems.count
    }

    // configure the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)


        
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    
    // customise the cell
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "£%.2f", menuItem.price)
        
        MenuController.shared.fetchImage(url: menuItem.imageURL)
        { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath != indexPath {
                    return
                }
                cell.imageView?.image = image
            }
        }
        
        
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            menuItems.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
        }
    }
    
    // change table view height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    

}
