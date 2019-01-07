//
//  NewsImageView.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/22/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

class NewsImageView: UIImageView {
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.settingsImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setting ImageView
    fileprivate func settingsImageView() {
        
        self.contentMode = .scaleAspectFill
        self.backgroundColor = .lentachGray
    }
}

extension NewsImageView {
    
    /// Set image with custom animation
    func setWithAnimation(image: UIImage) {
        
        UIView.animate(withDuration: 3.0) {
            self.image = image
        }
    }
}
