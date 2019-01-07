//
//  NewsManager.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/14/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import Foundation

class NewsManager {
    
    static func requestNews(fromURL URL: URL, completionHander: @escaping(LentaAPINewsResponse?) -> Void) {
        
        Network.requestNews(fromURL: URL) { data in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHander(nil)
                    return
                }
                return
            }
            
            print("data before decoding - \(data)")
            
            let decoder = JSONDecoder.init()
            let lentaAPINewsResponse = try? decoder.decode(LentaAPINewsResponse.self, from: data)
            
            DispatchQueue.main.async {
                completionHander(lentaAPINewsResponse)
                return
            }
        }  
    }
    
    static func requestLatestNews(completionHandler: @escaping(LatestNews?) -> Void) {
        
        Network.requestLatestNews { data in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil)
                    return
                }
                return
            }
            
            print("data before decoding - \(data)")
            
            let decoder = JSONDecoder.init()
            let latestNews = try? decoder.decode(LatestNews.self, from: data)
            
            DispatchQueue.main.async {
                completionHandler(latestNews)
                return
            }
        }
    }
}
