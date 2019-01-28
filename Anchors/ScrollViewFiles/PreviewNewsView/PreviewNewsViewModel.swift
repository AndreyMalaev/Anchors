//
//  PreviewNewsViewModel.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/27/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class PreviewNewsViewModel {
    
    var image: UIImage?
    var imageAuthor: String?
    var date: String?
    var title: String?
    var announce: String?
    
    required init(_ news: SingleLatestNews) {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        if let newsImageStringURL = news.image?.url {
            Network.loadImage(fromStringURL: newsImageStringURL) { [weak self] image in
                self?.image = image
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.wait()
        
        self.imageAuthor = news.image?.author
        self.date = DateManager.createStringDate(withSecondsIntervalSince1970: news.info?.date)
        self.title = news.info?.title
        self.announce = news.info?.rightcol
        
        dispatchGroup.notify(queue: .global(qos: .background)) { }
    }
}


