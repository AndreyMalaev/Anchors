//
//  PreviewVideoContentViewModel.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/28/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class PreviewVideoContentViewModel {
    
    var previewImage: UIImage?
    var description: String?
    
    
    required init(_ newsResponse: LentaAPINewsResponse) {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        
        if let stringPreviewImageURL = newsResponse.news?.previewImageURL() {
            Network.loadImage(fromStringURL: stringPreviewImageURL) { [weak self] image in
                self?.previewImage = image
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.wait()
        
        self.description = newsResponse.news?.videoContent()?.description

        dispatchGroup.notify(queue: .global(qos: .background)) { }
    }
}
