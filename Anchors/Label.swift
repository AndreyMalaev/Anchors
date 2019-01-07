//
//  Label.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/22/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

class NewsTextLabel: UILabel {
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.settingsLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.settingsLabel()
    }
    
    convenience init(withFrame frame: CGRect, andFontSize fontSize: CGFloat, andTextColor textColor: UIColor = .lentachGray) {
        self.init(frame: frame)
        
        self.font = UIFont.italicSystemFont(ofSize: fontSize)
        self.textColor = textColor
    }
    
    // MARK: - Setting Label
    fileprivate func settingsLabel() {
        
        self.backgroundColor = .clear
        self.contentMode = .scaleToFill
        self.textColor = .lentachGray
        self.numberOfLines = 0
        self.textAlignment = .left
        self.sizeToFit()
    }
}

extension NewsTextLabel {
    
    func updateLabelFrame() {
        
        self.updateLabelHeight()
        self.updateLabelWidth()
    }
    
    func updateLabelHeight() {
        
        let layoutHeight = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var currectFrame = self.frame
        
        if layoutHeight != currectFrame.size.height {
            currectFrame.size.height = layoutHeight
            self.frame = currectFrame
        }
    }
    
    func updateLabelWidth() {
        
        let layoutWidth = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        var currectFrame = self.frame
        
        if layoutWidth != currectFrame.size.width {
            currectFrame.size.width = layoutWidth
            self.frame = currectFrame
        }
    }
}

// MARK: - dont use
class TitleNewsLabel: NewsTextLabel {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.settingsTitleNewsLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.settingsTitleNewsLabel()
    }
    
    // MARK: - Setting Label
    
    fileprivate func settingsTitleNewsLabel() {
        
        self.backgroundColor = .red
        self.font = UIFont.italicSystemFont(ofSize: 30)
    }
}

class TextNewsLabel: NewsTextLabel {
    
    // MARK: - Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.settingsTextNewsLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.settingsTextNewsLabel()
    }
    
    // MARK: - Setting Label
    
    fileprivate func settingsTextNewsLabel() {
        
        self.backgroundColor = .lightGray
        self.font = UIFont.italicSystemFont(ofSize: 20)
    }
}
