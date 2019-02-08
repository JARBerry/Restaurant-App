//
//  IntermediaryModels.swift
//  Restaurant App
//
//  Created by James and Ray Berry on 05/02/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
