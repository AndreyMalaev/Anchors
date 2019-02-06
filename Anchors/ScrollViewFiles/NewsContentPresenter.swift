//
//  NewsContentPresenter
//  Anchors
//
//  Created by Andrey Malaev on 2/2/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class NewsContentPresenter {
    
    func createNewsPreviewContentViewModel(fromNews news: SingleLatestNews,
                                              completion: @escaping(NewsPreviewContentViewModel) -> Void) {
        
        let newsPreviewContentViewModel = NewsPreviewContentViewModel.init()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        if let newsImageStringURL = news.image?.url {
            Network.loadImage(fromStringURL: newsImageStringURL) { [weak newsPreviewContentViewModel] image in
                newsPreviewContentViewModel?.image = image
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.wait()
        
        newsPreviewContentViewModel.imageAuthor = news.image?.author
        newsPreviewContentViewModel.date = DateManager.createStringDate(withSecondsIntervalSince1970: news.info?.date)
        newsPreviewContentViewModel.title = news.info?.title
        newsPreviewContentViewModel.announce = news.info?.rightcol
        
        dispatchGroup.notify(queue: .global(qos: .background)) {
            completion(newsPreviewContentViewModel)
        }
    }
    
    func createNewsTextContentViewModel(fromNews news: LentaAPINewsResponse,
                                           completion: @escaping(NewsTextContentViewModel) -> Void) {
        
        let newsTextContentViewModel = NewsTextContentViewModel.init()
        newsTextContentViewModel.text = news.news?.textContent()
        
        completion(newsTextContentViewModel)
    }
    
    func createNewsPreviewVideoContentViewModel(fromNews news: LentaAPINewsResponse,
                                        completion: @escaping(NewsPreviewVideoContentViewModel) -> Void) {
        
        let newsPreviewVideoContentViewModel = NewsPreviewVideoContentViewModel.init()
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        if let stringPreviewImageURL = news.news?.previewImageURL() {
            Network.loadImage(fromStringURL: stringPreviewImageURL) { [weak newsPreviewVideoContentViewModel] image in
                newsPreviewVideoContentViewModel?.previewImage = image
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.wait()
        
        newsPreviewVideoContentViewModel.description = news.news?.videoContent()?.description
        
        dispatchGroup.notify(queue: .global(qos: .background)) {
            completion(newsPreviewVideoContentViewModel)
        }
    }
}
