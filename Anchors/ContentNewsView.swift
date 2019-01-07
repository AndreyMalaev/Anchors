//
//  ContentNewsCell.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/17/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

class ContentNewsView: UIView {
    
    // MARK: - UI Properties
    var newsImageView: NewsImageView!
    var newsImageAuthorLabel: NewsTextLabel!
    var newsDateLabel: NewsTextLabel!
    var newsTitleLabel: NewsTextLabel!
    var newsTextLabel: NewsTextLabel!
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .lightGray
        
        // setup ui elements
        self.setupNewsImageView()
        self.setupImageAuthorLabel()
        // self.setupDateLabel()
        // self.seputTitleNewsLabel()
        // self.setupNewsTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentNewsView {
    
    private func setupNewsImageView() {
        
        self.newsImageView = NewsImageView.init(frame: CGRect.zero)
        self.newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsImageView)
        
        self.newsImageView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        self.newsImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.newsImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.newsImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        // bottom anchor
        self.newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupImageAuthorLabel() {
        
        self.newsImageAuthorLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 15, andTextColor: .white)
        self.newsImageAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.newsImageView.addSubview(self.newsImageAuthorLabel)
        
        self.newsImageAuthorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.newsImageAuthorLabel.leftAnchor.constraint(equalTo: self.newsImageView.leftAnchor, constant: +15).isActive = true
        self.newsImageAuthorLabel.rightAnchor.constraint(equalTo: self.newsImageView.rightAnchor).isActive = true
        self.newsImageAuthorLabel.bottomAnchor.constraint(equalTo: self.newsImageView.bottomAnchor).isActive = true
    }
    
    private func setupDateLabel() {
        
        self.newsDateLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 14)
        self.newsDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsDateLabel)
        
        self.newsDateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: +0).isActive = true
        self.newsDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func seputTitleNewsLabel() {
        
        self.newsTitleLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 20)
        self.newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsTitleLabel)
        
        self.newsTitleLabel.topAnchor.constraint(equalTo: newsDateLabel.bottomAnchor, constant: +0).isActive = true
        self.newsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        // bottom anchor
        // self.newsTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupNewsTextLabel() {
        
        self.newsTextLabel = NewsTextLabel.init(withFrame: CGRect.zero, andFontSize: 15)
        self.newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.newsTextLabel)
        
        self.newsTextLabel.topAnchor.constraint(equalTo: self.newsTitleLabel.bottomAnchor, constant: +0).isActive = true
        self.newsTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.newsTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0).isActive = true
    }
}
