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
        
        self.contentMode = .scaleToFill
        self.backgroundColor = .lentachGray
    }
}
