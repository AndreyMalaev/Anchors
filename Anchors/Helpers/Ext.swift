//
//  Ext.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/14/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

extension UIColor {
    class var lentachGray: UIColor {
        return UIColor(red: 32/255.0, green: 32/255.0, blue: 32/255.0, alpha: 1)
    }
}

extension UIActivityIndicatorView {
    func settingWithStyle(style: Style, andColor color: UIColor) {
        self.style = style
        self.color = color
    }
}

// MARK: - extension for hide or show navigation bar
extension UINavigationBar {
    
    func isHidden(value: Bool) {
        switch value {
        case true:
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            self.isTranslucent = true
        case false:
            self.setBackgroundImage(nil, for: .default)
            self.shadowImage = nil
            self.isTranslucent = false
        }
    }
}

extension UITableView {
    func setScrollIndicatorColor(color: UIColor) {
        for view in self.subviews {
            if view.isKind(of: UIImageView.self), let imageView = view as? UIImageView, let image = imageView.image {
                
                imageView.tintColor = color
                imageView.image = image.withRenderingMode(.alwaysTemplate)
            }
        }
        self.flashScrollIndicators()
    }
    
    func updateHeaderViewHeight() {
        if let headerView = self.tableHeaderView {
            headerView.layoutIfNeeded()
            self.tableHeaderView = headerView
        }
    }
    
    func setHeaderView(headerView: UIView) {
        self.tableHeaderView = headerView
        
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.updateHeaderViewHeight()
    }
}

extension String {
    static var paragraphSeparator: String {
        return "\n\n"
    }
}
