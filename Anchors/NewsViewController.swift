//
//  NewsViewController.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/11/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    // model property
    var news: SingleLatestNews?
    var newsContent: LentaAPINewsResponse? {
        didSet {
            print("newsContent sucsses loaded")
            self.configureContentViews()
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
    
    // view controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print input news
        print(news ?? "luuul")
        
        // hide navigation bar
        self.navigationController?.navigationBar.isHidden(value: true)
        
        // setup table view
        self.setupTableViewAnchors()
        self.setupTableViewProtocols()
        
        // setup activity indicator
        self.setupActivityIndicatorAnchors()
        
        //
        self.setupContentNewsView()
        
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

// MARK: - extensions for setup ui controller
// MARK: - extensions for setup table view
extension NewsViewController {
    
    func setupTableViewProtocols() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupTableViewAnchors() {
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}

// MARK: - extension for setup activity indicator
extension NewsViewController {
    
    func setupActivityIndicatorAnchors() {
        
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func setupContentNewsView() {
        
        let containerNewsView = ConteinerNewsView.init(frame: CGRect.init(x: 0,
                                                                          y: 0,
                                                                      width: self.tableView.bounds.width,
                                                                     height: 0))
        
        if let newsImageStringURL = self.news?.image?.url {
            Network.loadImage(fromStringURL: newsImageStringURL) { [weak containerNewsView] image in
                DispatchQueue.main.async {
                    containerNewsView?.newsImageView.image = image
                }
            }
        }
        
        if let newsDate = self.news?.info?.date {
            containerNewsView.newsDateLabel.text = DateManager.createStringDate(withSecondsIntervalSince1970: newsDate)
        }
        
        if let newsTitle = self.news?.info?.title {
            containerNewsView.newsTitleLabel.text = newsTitle
        }
        
        self.tableView.setHeaderView(headerView: containerNewsView)
        self.tableView.updateHeaderViewHeight()
    }
}

// MARK: - Extensions for table view protocols
// MARK: - Extension for table view delegate
extension NewsViewController: UITableViewDelegate {
    
}

// MARK: - Extension for table view data source
extension NewsViewController: UITableViewDataSource {
    
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

// MARK: - extension for update content views after load news detail content

extension NewsViewController {
    
    func configureContentViews() {
        
        guard let text = self.newsContent?.news?.newsTextContent() else { return }

        if let header = self.tableView.tableHeaderView as? ConteinerNewsView {
            print(text)
            header.newsTextLabel.text = text
        }
        
        self.tableView.updateHeaderViewHeight()
        
        self.tableView.reloadData()
    }
}

// MARK: - extension for network request
extension NewsViewController {
    
    func requestNews() {
        
        guard let stringURL = self.news?.URLs?.api else { return }
        guard let newsURL = URL.init(string: stringURL) else { return }
        
        NewsManager.requestNews(fromURL: newsURL) { [weak self] newsContent in
            self?.newsContent = newsContent
        }
    }
}
