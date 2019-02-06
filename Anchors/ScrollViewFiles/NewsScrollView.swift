//
//  NewsScrollView.swift
//  Anchors
//
//  Created by Andrey Malaev on 2/2/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

protocol NewsScrollViewDelegate: class {
    
    func newsScrollViewDidTapPlayButton(_ newsScrollView: NewsScrollView)
}

class NewsScrollView: UIScrollView {
    
    // MARK: - Delegate
    weak var userActivityDelegate: NewsScrollViewDelegate?
    
    // MARK: - UI Properties
    private var previewContentView: NewsPreviewContentView!
    private var textContentView: NewsTextContentView!
    private var previewVideoContentView: NewsPreviewVideoContentView!

    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        settingsScrollView()
        setupPreviewContentView()
        setupTextContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup UI-Elements Constraints
extension NewsScrollView {
    
    private func settingsScrollView() {
    
        self.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.contentInsetAdjustmentBehavior = .never
    
        self.contentSize = CGSize.init(width: self.bounds.width, height: self.bounds.height)
    }
    
    private func setupPreviewContentView() {
        
        self.previewContentView = NewsPreviewContentView.init(frame: CGRect.zero)
        
        self.addSubview(self.previewContentView)
        
        self.previewContentView.translatesAutoresizingMaskIntoConstraints = false
        self.previewContentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.previewContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.previewContentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    fileprivate func setupTextContentView() {
        
        self.textContentView = NewsTextContentView.init(frame: CGRect.zero)
        
        self.addSubview(self.textContentView)
        
        self.textContentView.translatesAutoresizingMaskIntoConstraints = false
        self.textContentView.topAnchor.constraint(equalTo: self.previewContentView.bottomAnchor).isActive = true
        self.textContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.textContentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    fileprivate func setupPreviewVideoContentView() {
        
        self.previewVideoContentView = NewsPreviewVideoContentView.init(frame: CGRect.zero)
        self.previewVideoContentView.delegate = self
        
        self.addSubview(self.previewVideoContentView)
        
        self.previewVideoContentView.translatesAutoresizingMaskIntoConstraints = false
        self.previewVideoContentView.topAnchor.constraint(equalTo: self.textContentView.bottomAnchor,
                                                         constant: +10).isActive = true
        self.previewVideoContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: +15).isActive = true
        self.previewVideoContentView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -30).isActive = true
    }
}

// MARK: - Extension For Update Height ScrollView
extension NewsScrollView {
    
    private func updateScrollViewHeightContentSize() {
        self.layoutIfNeeded()
        
        if self.previewVideoContentView != nil {
            self.contentSize.height = self.previewVideoContentView.frame.maxY + 10
        } else {
            self.contentSize.height = self.textContentView.frame.maxY + 10
        }
    }
}

// MARK: - Extension For PreviewVideoContentViewDelegate
extension NewsScrollView: NewsPreviewVideoContentViewDelegate {
    
    func newsPreviewVideoContentViewDidTapPlayButton(_ newsPreviewVideoContentView: NewsPreviewVideoContentView) {
        print("play video - // NewsScrollView")
        self.userActivityDelegate?.newsScrollViewDidTapPlayButton(self)
    }
}

extension NewsScrollView {
    
    func configureNewsPreviewView(_ newsPreviewViewModel: NewsPreviewContentViewModel) {
        self.previewContentView.configure(newsPreviewViewModel)
        updateScrollViewHeightContentSize()
    }
    
    func setImageDescription(_ text: String?) {
        self.previewContentView.setImageDescription(text)
    }
    
    func configureTextContentView(_ textContentViewModel: NewsTextContentViewModel) {
        self.textContentView.configure(textContentViewModel)
        updateScrollViewHeightContentSize()
    }
    
    func configureVideoContentView(_ videoContentViewModel: NewsPreviewVideoContentViewModel) {
        setupPreviewVideoContentView()
        self.previewVideoContentView.configure(videoContentViewModel)
        updateScrollViewHeightContentSize()
    }
}
