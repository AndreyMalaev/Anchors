//
//  ContentNewsViewModel.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/28/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class TextContentNewsViewModel {
    
    var text: String?
    
    required init(_ newsResponse: LentaAPINewsResponse) {
        
        self.text = newsResponse.news?.textContent()
    }
}
