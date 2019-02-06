//
//  ContentNewsView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/28/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

final class NewsTextContentView: UIView {
    
    // MARK: - UI Properties
    private var newsTextLabel: NewsTextLabel!
    private var textSeparator: UIView!
    
    // MARK: - Constraint Properties
    private var textSeparartorBottomConstraints: NSLayoutConstraint?
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupNewsTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI Constraints
extension NewsTextContentView {
    
    fileprivate func setupNewsTextLabel() {
        
        self.newsTextLabel = NewsTextLabel.init(frame: CGRect.zero, fontSize: 18)
        self.newsTextLabel.backgroundColor = .red
        self.addSubview(self.newsTextLabel)
        
        self.newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.newsTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: +10).isActive = true
        self.newsTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.newsTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        setupTextSeparator()
    }
    
    fileprivate func setupTextSeparator() {
        
        self.textSeparator = UIView.init(frame: CGRect.zero)
        self.textSeparator.backgroundColor = .lentachGray
        self.textSeparator.alpha = 0.3
        self.textSeparator.isHidden = true
        self.addSubview(self.textSeparator)
        
        self.textSeparator.translatesAutoresizingMaskIntoConstraints = false
        self.textSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.textSeparator.topAnchor.constraint(equalTo: self.newsTextLabel.bottomAnchor, constant: +20).isActive = true
        self.textSeparator.leftAnchor.constraint(equalTo: self.leftAnchor, constant: +15).isActive = true
        self.textSeparator.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.textSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}

// MARK: - Setup Data In UI
extension NewsTextContentView {
    
    func setTextNews(_ text: String?) {
        self.newsTextLabel.text = text
    }
    
    func configure(_ viewModel: TextContentNewsViewModel) {
        if let text = viewModel.text {
            setTextNews(text)
            self.textSeparator.isHidden = false
            self.layoutIfNeeded()
        }
    }
}
