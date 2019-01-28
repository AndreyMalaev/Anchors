//
//  NewsScrollViewController.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/24/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class NewsScrollViewController: UIViewController {
    
    // MARK: - Model Properties
    var news: SingleLatestNews? {
        didSet {
            if news != nil {
                print("news didSet succses")
                
                DispatchQueue.global(qos: .background).async {
                    let previewNewsViewModel = PreviewNewsViewModel.init(self.news!)
                    DispatchQueue.main.async { [weak self] in
                        self?.previewNewsView.configure(previewNewsViewModel)
                        self?.updateScrollViewHeightContentSize()
                    }
                }
            }
        }
    }
    
    var newsContent: LentaAPINewsResponse? {
        didSet {
            if newsContent != nil {
                print("newsContent didSet succses")
                
                DispatchQueue.global(qos: .background).async {
                    let textContentNewsViewModel = TextContentNewsViewModel.init(self.newsContent!)
                    let previewVideoContentViewModel = PreviewVideoContentViewModel.init(self.newsContent!)
                    DispatchQueue.main.async { [weak self] in
                        self?.textContentNewsView.configure(textContentNewsViewModel)
                        self?.previewVideoContentView.configure(previewVideoContentViewModel)
                        self?.updateScrollViewHeightContentSize()
                    }
                }
            }
        }
    }
    
    // MARK: - View Properties
    private var newsScrollView = UIScrollView()
    private var previewNewsView = PreviewNewsView()
    private var textContentNewsView = TextContentNewsView()
    private var previewVideoContentView = PreviewVideoContentView()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden(value: true)
        
        // request news content
        requestNews()
        
        setupNewsScrollView()
        setupPreviewNewsView()
        setupTextContentView()
        setupPreviewVideoContentView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            // return navigation bar to default state
            self.navigationController?.navigationBar.isHidden(value: false)
            self.navigationController?.view.backgroundColor = .purple
        }
    }
}

//MARK: - Setup UI-Elements Constraints
extension NewsScrollViewController {
    
    private func setupNewsScrollView() {
        
        self.newsScrollView.frame = CGRect.zero
        self.newsScrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.newsScrollView.contentInsetAdjustmentBehavior = .never
        
        self.newsScrollView.contentSize = CGSize.init(width: self.view.bounds.width, height: self.view.bounds.height)
        self.newsScrollView.backgroundColor = .orange
        
        self.view.addSubview(self.newsScrollView)
        
        self.newsScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.newsScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.newsScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.newsScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.newsScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setupPreviewNewsView() {
        
        self.previewNewsView.frame = CGRect.zero
        
        self.newsScrollView.addSubview(self.previewNewsView)
        
        self.previewNewsView.translatesAutoresizingMaskIntoConstraints = false
        self.previewNewsView.topAnchor.constraint(equalTo: self.newsScrollView.topAnchor).isActive = true
        self.previewNewsView.leadingAnchor.constraint(equalTo: self.newsScrollView.leadingAnchor).isActive = true
        self.previewNewsView.widthAnchor.constraint(equalTo: self.newsScrollView.widthAnchor).isActive = true
    }
    
    fileprivate func setupTextContentView() {
        
        self.textContentNewsView.frame = CGRect.zero
        
        self.newsScrollView.addSubview(self.textContentNewsView)
        
        self.textContentNewsView.translatesAutoresizingMaskIntoConstraints = false
        self.textContentNewsView.topAnchor.constraint(equalTo: self.previewNewsView.bottomAnchor,
                                                     constant: +0).isActive = true
        self.textContentNewsView.leadingAnchor.constraint(equalTo: self.newsScrollView.leadingAnchor).isActive = true
        self.textContentNewsView.widthAnchor.constraint(equalTo: self.newsScrollView.widthAnchor).isActive = true
    }
    
    fileprivate func setupPreviewVideoContentView() {
        
        self.previewVideoContentView.frame = CGRect.zero
        self.previewVideoContentView.delegate = self
        
        self.newsScrollView.addSubview(self.previewVideoContentView)
        
        self.previewVideoContentView.translatesAutoresizingMaskIntoConstraints = false
        self.previewVideoContentView.topAnchor.constraint(equalTo: self.textContentNewsView.bottomAnchor,
                                                         constant: +10).isActive = true
        self.previewVideoContentView.leadingAnchor.constraint(equalTo: self.newsScrollView.leadingAnchor,
                                                             constant: +15).isActive = true
        self.previewVideoContentView.widthAnchor.constraint(equalTo: self.newsScrollView.widthAnchor,
                                                           constant: -30).isActive = true
    }
}

// MARK: - Extension For Network Request
extension NewsScrollViewController {
    
    func requestNews() {
        
        guard let stringURL = self.news?.URLs?.api else { return }
        guard let newsURL = URL.init(string: stringURL) else { return }
        
        NewsManager.requestNews(fromURL: newsURL) { [weak self] newsContent in
            self?.newsContent = newsContent
        }
    }
}

// MARK: - Extension For PreviewVideoContentViewDelegate
extension NewsScrollViewController: PreviewVideoContentViewDelegate {
    
    func previewVideoContentViewDidTapPlay(_ previewVideoContentView: PreviewVideoContentView) {
        print("play video")
    }
    
}

extension NewsScrollViewController {

    private func updateScrollViewHeightContentSize() {
        self.newsScrollView.layoutIfNeeded()
        self.newsScrollView.contentSize.height = self.previewVideoContentView.frame.maxY + 10
    }
}
