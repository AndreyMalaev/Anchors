//
//  NewsViewController.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/11/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class NewsViewController1: UIViewController {
    
    // model property
    var news: SingleLatestNews?
    var newsContent: LentaAPINewsResponse? {
        didSet {
            self.configureNewsHeaderViewWithlLoadedData()
            print("newsContent didSet succses")
        }
    }
    
    // view property
    let tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.tableFooterView = UIView.init()
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView.init()
        activityIndicator.settingWithStyle(style: .white, andColor: UIColor.lentachGray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private var newsHeaderView: NewsHeaderView!
    
    // view controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden(value: true)
        
        // setup table view
        setupTableViewAnchors()
        setupTableViewProtocols()
        
        // setup activity indicator
        setupActivityIndicatorAnchors()
        
        //
        setupNewsHeaderView()
        configureNewsHeaderViewWithAvailadleData()
        
        // news request
        self.requestNews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            // return navigation bar to default state
            self.navigationController?.navigationBar.isHidden(value: false)
            self.navigationController?.view.backgroundColor = .purple
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // setup color scroll indicator in table view
        self.tableView.setScrollIndicatorColor(color: UIColor.lentachGray)
    }
}

// MARK: - Extensions For Setup UI Controller
// MARK: - Extensions For Setup TableView
extension NewsViewController1 {
    
    private func setupTableViewProtocols() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupTableViewAnchors() {
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

// MARK: - Extension For Setup Activity Indicator
extension NewsViewController1 {
    
    private func setupActivityIndicatorAnchors() {
        
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

// MARK: - Extension For Setup Activity Indicator
extension NewsViewController1 {
    
    private func setupNewsHeaderView() {
        
        self.newsHeaderView = NewsHeaderView.init(frame: CGRect.zero)
        self.tableView.setHeaderView(headerView: newsHeaderView)
    }
}

// MARK: - Extensions For TableView Protocols
// MARK: - Extension For TableView DelegateProtocol
extension NewsViewController1: UITableViewDelegate {
    
}

// MARK: - Extension For TableView DataSourceProtocol
extension NewsViewController1: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.newsContent != nil ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsContent != nil ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        cell.textLabel?.text = "section: \(indexPath.section), row: \(indexPath.row)"
        cell.backgroundColor = .purple
        return cell
    }
}

// MARK: - Extension For Configure NewsHeaderView
extension NewsViewController1 {
    
    private func configureNewsHeaderViewWithAvailadleData() {
        
        if let newsImageStringURL = self.news?.image?.url {
            Network.loadImage(fromStringURL: newsImageStringURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.newsHeaderView.setNewsImage(image)
                }
            }
        }

        self.newsHeaderView.setImageAuthor(self.news?.image?.author)

 
        if let newsDate = self.news?.info?.date {
            let dateString = DateManager.createStringDate(withSecondsIntervalSince1970: newsDate)
            self.newsHeaderView.setDateNews(dateString)
        }
 
        self.newsHeaderView.setTitleNews(news?.info?.title)
        self.newsHeaderView.setAnnounceNews(news?.info?.rightcol)
        
        self.tableView.updateHeaderViewHeight()
    }
    
    func configureNewsHeaderViewWithlLoadedData() {
        
        self.newsHeaderView.setImageDescription(self.newsContent?.news?.newsInfo?.newsImage?.description)
        self.newsHeaderView.setTextNews(self.newsContent?.news?.textContent())
        
        if let stringPreviewImageURL = self.newsContent?.news?.previewImageURL() {
            Network.loadImage(fromStringURL: stringPreviewImageURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.newsHeaderView.setPreviewImage(image, withDelegateForVideoPlayer: self ?? nil)
                }
            }
        }
        
        if let videoContent = self.newsContent?.news?.videoContent() {
            print(videoContent.description ?? "no description")
            self.newsHeaderView.setPreviewImageDescription(videoContent.description, withDelegateForVideoPlayer: self)
        }

        self.tableView.updateHeaderViewHeight()
        self.tableView.reloadData()
    }
}

// MARK: - Extension For Network Request
extension NewsViewController1 {
    
    func requestNews() {
        
        guard let stringURL = self.news?.URLs?.api else { return }
        guard let newsURL = URL.init(string: stringURL) else { return }
        
        NewsManager.requestNews(fromURL: newsURL) { [weak self] newsContent in
            self?.newsContent = newsContent
            self?.activityIndicator.stopAnimating()
        }
    }
}

extension NewsViewController1: PreviewVideoViewDelegate {
    
    func previewVideoViewUserPressPlayVideo(_ previewVideoView: PreviewVideoView) {
        
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
