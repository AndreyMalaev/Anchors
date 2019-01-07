//
//  ModelFeed.swift
//  Anchors
//
//  Created by Andrey Malaev on 12/16/18.
//  Copyright © 2018 Andrey Malaev. All rights reserved.
//

import Foundation

struct LatestNews: Decodable {
    
    let latestNews: [SingleLatestNews]?
    
    enum CodingKeys: String, CodingKey {
        case latestNewsKey = "headlines"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.latestNews = try container.decodeIfPresent([SingleLatestNews].self, forKey: .latestNewsKey)
    }
}

struct SingleLatestNews: Decodable {
    
    let type: String?
    let info: SingleNewsInfo?
    let URLs: SingleNewsURLs?
    let image: SingleNewsImage?
    
    enum CodingKeys: String, CodingKey {
        case type
        case info
        case URLs = "links"
        case image = "title_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.info = try container.decodeIfPresent(SingleNewsInfo.self, forKey: .info)
        self.URLs = try container.decodeIfPresent(SingleNewsURLs.self, forKey: .URLs)
        self.image = try container.decodeIfPresent(SingleNewsImage.self, forKey: .image)
    }
}

struct SingleNewsInfo: Decodable {
    
    let title: String?
    let rightcol: String?
    let date: Double?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rightcol
        case date = "modified"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.rightcol = try container.decodeIfPresent(String.self, forKey: .rightcol)
        self.date = try container.decodeIfPresent(Double.self, forKey: .date)
    }
}

struct SingleNewsURLs: Decodable {
    
    let api: String?
    let site: String?
    
    enum CodingKeys: String, CodingKey {
        case api = "self"
        case site = "public"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.api = try container.decodeIfPresent(String.self, forKey: .api)
        self.site = try container.decodeIfPresent(String.self, forKey: .site)
    }
}

struct SingleNewsImage: Decodable {
    
    let author: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "credits"
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
