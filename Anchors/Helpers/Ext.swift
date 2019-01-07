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
    
    
    func updateHeightHeaderView() {
        if let headerView = self.tableHeaderView {

            print("tableHeaderView frame: - \(headerView.frame)")
            print("tableHeaderView bounds: - \(headerView.bounds)")
            print("tableView content offset - \(self.contentOffset.y)")
            
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                self.tableHeaderView = headerView
                

                print("============")
                print("tableHeaderView frame: - \(headerView.frame)")
                print("tableHeaderView bounds: - \(headerView.bounds)")
                print("tableView content offset - \(self.contentOffset.y)")
            }
        }
    }
}

extension UITableView {
    
    func customSetTableHeaderView(headerView: UIView) {
        
        self.tableHeaderView = headerView
        
        guard let tableHeaderViewSuperview = tableHeaderView?.superview else {
            assertionFailure("This should not be reached!")
            return
        }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        tableHeaderViewSuperview.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        tableHeaderViewSuperview.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

extension UITableView {
    
    // https://stackoverflow.com/a/43539653
    
    func setTableHeaderView(headerView: UIView?) {
        // set the headerView
        tableHeaderView = headerView
        
        // check if the passed view is nil
        guard let headerView = headerView else { return }
        
        // check if the tableHeaderView superview view is nil just to avoid
        // to use the force unwrapping later. In case it fail something really
        // wrong happened
        guard let tableHeaderViewSuperview = tableHeaderView?.superview else {
            assertionFailure("This should not be reached!")
            return
        }
        
        // force updated layout
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        // set tableHeaderView width
        tableHeaderViewSuperview.addConstraint(headerView.widthAnchor.constraint(equalTo: tableHeaderViewSuperview.widthAnchor, multiplier: 1.0))
        
        // set tableHeaderView height
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        tableHeaderViewSuperview.addConstraint(headerView.heightAnchor.constraint(equalToConstant: height))
    }
    
    func setTableFooterView(footerView: UIView?) {
        // set the footerView
        tableFooterView = footerView
        
        // check if the passed view is nil
        guard let footerView = footerView else { return }
        
        // check if the tableFooterView superview view is nil just to avoid
        // to use the force unwrapping later. In case it fail something really
        // wrong happened
        guard let tableFooterViewSuperview = tableFooterView?.superview else {
            assertionFailure("This should not be reached!")
            return
        }
        
        // force updated layout
        footerView.setNeedsLayout()
        footerView.layoutIfNeeded()
        
        // set tableFooterView width
        tableFooterViewSuperview.addConstraint(footerView.widthAnchor.constraint(equalTo: tableFooterViewSuperview.widthAnchor, multiplier: 1.0))
        
        // set tableFooterView height
        let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        tableFooterViewSuperview.addConstraint(footerView.heightAnchor.constraint(equalToConstant: height))
    }
}
