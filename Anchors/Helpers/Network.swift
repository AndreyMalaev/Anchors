//
//  Network.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/14/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

class Network {
    
    static func requestNews(fromURL URL: URL, completionHandler: @escaping(Data?) -> Void) {
        
        URLSession.shared.dataTask(with: URL) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let loadData = data else {
                completionHandler(nil)
                return
            }
            
            completionHandler(loadData)
            
        }.resume()
    }
    
    static func requestLatestNews(completionHandler: @escaping(Data?) -> Void) {
        
        guard let url = URL.init(string: String("https://api.lenta.ru/lists/latest")) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let loadData = data else {
                completionHandler(nil)
                return
            }
            
            completionHandler(loadData)
            
        }.resume()
    }
    
    static func loadImage(fromStringURL stringURL: String, completionHandler: @escaping(UIImage?) -> Void) {
        
        guard let url = URL.init(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let loadData = data else {
                completionHandler(nil)
                return
            }
            
            completionHandler(UIImage.init(data: loadData))
            
        }.resume()
    }
}
