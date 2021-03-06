//
//  MenuItemDetailViewController.swift
//  Restaurant App
//
//  Created by James and Ray Berry on 05/02/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    var delegate: AddToOrderDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    
    
    
    var menuItem: MenuItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        
        // display menu item details
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "£%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        addToOrderButton.layer.cornerRadius = 5.0
        MenuController.shared.fetchImage(url: menuItem.imageURL)
        {(image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    // passes details to order table view controller
    func setupDelegate() {
        if let navController = tabBarController?.viewControllers?.last as? UINavigationController,
            let orderTableViewController = navController.viewControllers.first as? OrderTableViewController {
            delegate = orderTableViewController
        }
    }
    
   
// animate order button if add to order button tapped
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(menuItem: menuItem)
    }
    
   
}

protocol AddToOrderDelegate {
    func added(menuItem: MenuItem)
}
