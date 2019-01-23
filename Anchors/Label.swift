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
    
    convenience init(withFrame frame: CGRect,
                andFontSize fontSize: CGFloat,
              andTextColor textColor: UIColor = .lentachGray) {
        self.init(frame: frame)
        
        self.font = UIFont.italicSystemFont(ofSize: fontSize)
        self.textColor = textColor
    }
    
    // MARK: - Setting Label
    fileprivate func settingsLabel() {
        
        self.contentMode = .scaleToFill
        self.numberOfLines = 0
        self.textAlignment = .left
        self.sizeToFit()
    }
}

extension NewsTextLabel {
    
    fileprivate func setupBottomBorderWithColor(color: UIColor, andHeight height: CGFloat) {
        let borberView = UIView.init(frame: CGRect.zero)
        borberView.backgroundColor = color
        
        self.addSubview(borberView)
        
        borberView.translatesAutoresizingMaskIntoConstraints = false
        borberView.heightAnchor.constraint(equalToConstant: height).isActive = true
        borberView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        borberView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        borberView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
