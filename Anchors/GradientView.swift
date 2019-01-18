//
//  GradientView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/19/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    // MARK: - Gradient Property
    var colors: [CGColor]?
    var locations: [NSNumber]?
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    
    // MARK: - UI Properties
    var backgroundGradientView: UIView!
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, colors: [CGColor], locations: [NSNumber]?, startPoint: CGPoint?, endPoint: CGPoint) {
        self.init(frame: frame)
        
        self.colors = colors
        self.locations = locations
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layer = CAGradientLayer.init()
        
        layer.frame = self.bounds
        layer.colors = self.colors
        
        if let locations = self.locations {
            layer.locations = locations
        }
        
        if let startPoint = self.startPoint, let endPoint = self.endPoint {
            layer.startPoint = startPoint
            layer.endPoint = endPoint
        }
        
        self.layer.addSublayer(layer)
    }
}
