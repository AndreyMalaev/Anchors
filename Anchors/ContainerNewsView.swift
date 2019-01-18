//
//  ContainerNewsView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/8/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class ConteinerNewsView: UIView {
    
    // MARK: - UI Properties
    var newsImageView: NewsImageView!
    var newsImageAuthorView: ImageAuthorView!
    var newsDateLabel: NewsTextLabel!
    var newsTitleLabel: NewsTextLabel!
    var newsTextLabel: NewsTextLabel!
    
    // MARK: - Constraint Properties
    var heightImageAuthorViewConstraint: NSLayoutConstraint?
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupNewsImageView()
        self.setupImageAuthorView()
        self.setupDateLabel()
        self.seputTitleNewsLabel()
        self.setupNewsTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConteinerNewsView {
    
    fileprivate func setupNewsImageView() {
        
        self.newsImageView = NewsImageView.init(frame: CGRect.zero)
        self.newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsImageView)
        
        self.newsImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.newsImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: +0).isActive = true
        self.newsImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.newsImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        // bottom anchor
        // self.newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func setupImageAuthorView() {
        
        self.newsImageAuthorView = ImageAuthorView.init(frame: CGRect.zero)
        self.newsImageAuthorView.translatesAutoresizingMaskIntoConstraints = false
        
        self.newsImageView.addSubview(self.newsImageAuthorView)
        
        self.newsImageAuthorView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        self.newsImageAuthorView.leftAnchor.constraint(equalTo: self.newsImageView.leftAnchor).isActive = true
        self.newsImageAuthorView.rightAnchor.constraint(equalTo: self.newsImageView.rightAnchor).isActive = true
        self.newsImageAuthorView.bottomAnchor.constraint(equalTo: self.newsImageView.bottomAnchor).isActive = true
        
        self.heightImageAuthorViewConstraint = self.newsImageAuthorView.topAnchor.constraint(equalTo: self.newsImageView.topAnchor, constant: 180)
        
        self.heightImageAuthorViewConstraint?.isActive = true
    }
    
    fileprivate func setupDateLabel() {
        
        self.newsDateLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 18)
        self.newsDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsDateLabel)
        
        self.newsDateLabel.topAnchor.constraint(equalTo: self.newsImageView.bottomAnchor, constant: +10).isActive = true
        self.newsDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func seputTitleNewsLabel() {
        
        self.newsTitleLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 25)
        self.newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsTitleLabel)
        
        self.newsTitleLabel.topAnchor.constraint(equalTo: self.newsDateLabel.bottomAnchor, constant: +10).isActive = true
        self.newsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func setupNewsTextLabel() {
        
        self.newsTextLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 18)
        self.newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsTextLabel)
        
        self.newsTextLabel.topAnchor.constraint(equalTo: self.newsTitleLabel.bottomAnchor, constant: +10).isActive = true
        self.newsTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.newsTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}
