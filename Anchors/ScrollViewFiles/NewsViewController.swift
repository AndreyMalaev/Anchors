//
//  NewsScrollViewController.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/24/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit
import AVKit

class NewsViewController: UIViewController {
    
    // MARK: - Model Properties
    var news: SingleLatestNews? {
        didSet {
            if news != nil {
                print("news didSet succses")
                
                DispatchQueue.global(qos: .background).async {
                    let presenter = NewsContentPresenter.init()
                    presenter.createNewsPreviewContentViewModel(fromNews: self.news!, completion: { viewModel in
                        DispatchQueue.main.async { [weak self] in
                        self?.newsScrollView.configureNewsPreviewView(viewModel)
                        }
                    })
                }
            }
        }
    }
    
    var newsContent: LentaAPINewsResponse? {
        didSet {
            if newsContent != nil {
                print("newsContent didSet succses")
                
                self.newsScrollView.setImageDescription(self.newsContent?.news?.imageDescription)
                
                DispatchQueue.global(qos: .background).async {
                    let presenter = NewsContentPresenter.init()
                    
                    presenter.createNewsTextContentViewModel(fromNews: self.newsContent!, completion: { viewModel in
                        DispatchQueue.main.async { [weak self] in
                            self?.newsScrollView.configureTextContentView(viewModel)
                        }
                    })
                    
                    presenter.createNewsPreviewVideoContentViewModel(fromNews: self.newsContent!, completion: { viewModel in
                        DispatchQueue.main.async { [weak self] in
                            self?.newsScrollView.configureVideoContentView(viewModel)
                        }
                    })
                }
            }
        }
    }
    
    // MARK: - UI Properties
    private var newsScrollView = NewsScrollView()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden(value: true)
        
        // setup newsScrollView
        setupNewsScrollView()
        
        // request news content
        requestNews()
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

// MARK: - Extension For Setup NewsScrollView

extension NewsViewController{
    
    private func setupNewsScrollView() {
        
        self.newsScrollView.userActivityDelegate = self
        
        self.newsScrollView.translatesAutoresizingMaskIntoConstraints = true
        self.newsScrollView.frame = self.view.frame
        self.view.addSubview(self.newsScrollView)
    }
}

// MARK: - Extension For Network Request
extension NewsViewController {
    
    func requestNews() {
        
        guard let stringURL = self.news?.URLs?.api else { return }
        guard let newsURL = URL.init(string: stringURL) else { return }
        
        NewsManager.requestNews(fromURL: newsURL) { [weak self] newsContent in
            self?.newsContent = newsContent
        }
    }
}

extension NewsViewController: NewsScrollViewDelegate {
    
    func newsScrollViewDidTapPlayButton(_ newsScrollView: NewsScrollView) {
        
        guard let videoContent = self.newsContent?.news?.videoContent() else { return }
        
        guard let videoURL = URL.init(string: videoContent.url ?? "") else { return }
        
        let player = AVPlayer.init(url: videoURL)
        let playerController = AVPlayerViewController.init()
        playerController.player = player
        
        self.present(playerController, animated: true) {
            playerController.player!.play()
        }
    }
}
