//
//  MenuItemDetailViewController.swift
//  Restaurant App
//
//  Created by Ray Berry on 05/02/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    
    
    
    var menuItem: MenuItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "£%.2f", menuItem.price)
        descriptionLabel.text = menuItem.description
        addToOrderButton.layer.cornerRadius = 5.0
    }

    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
