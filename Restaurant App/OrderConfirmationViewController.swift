//
//  OrderConfirmationViewController.swift
//  Restaurant App
//
//  Created by James and Ray Berry on 07/02/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes"

        // Do any additional setup after loading the view.
    }
    


}
