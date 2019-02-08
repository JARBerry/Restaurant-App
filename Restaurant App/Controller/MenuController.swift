//
//  MenuController.swift
//  Restaurant App
//
//  Created by James and Ray Berry on 05/02/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    
    static let shared = MenuController()
    
    // hits local server - ensure server is up and running first
    let baseURL = URL(string: "http://localhost:8090/")!
    
    
    // Make request URL session for categories which are defined in menu.json
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        // Feedback responses for categories
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // Make request URL session for Menu Items which are defined in menu.json
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        // Feedback repsonses for menuItems
        let task = URLSession.shared.dataTask(with: menuURL)
        {
            (data,response,error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Posts Submitted orders
    func submitOrder(menuIds: [Int],  completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        
        // Modify from GET to POST
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        
        // Telling the server that the data will be a JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Store the array of menu IDs in JSON under the key "menuIds"
        let data: [String: Any] = ["menuIds": menuIds]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        
        // Store the data within the body of the request.
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let prepTime = jsonDictionary?["preparation_time"] as? Int {
                completion(prepTime)
                
            } else {
                completion(nil)
            }
            
        }
        
        task.resume()
    }
    
    
    // fecth image data
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    
}

