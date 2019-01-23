//
//  VideoPlayerView.swift
//  Anchors
//
//  Created by Andrey Malaev on 1/22/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

final class VideoPlayerView: UIView {
    
    // MARK: - UI Properties
    private var player: AVPlayer!
    private var playerController: AVPlayerViewController!
    
    // MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lentachGray.withAlphaComponent(0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoPlayerView {
    
    private func setupPlayer() {
        
        self.player = AVPlayer.init()
        
        let playerLayer = AVPlayerLayer.init(player: self.player)
        playerLayer.frame = self.bounds
        
        self.layer.addSublayer(playerLayer)
    }
}

extension VideoPlayerView {
    
    func setupVideoURL(_ URL: URL) {
        
        if self.player == nil {
            setupPlayer()
        }
        
        self.player.replaceCurrentItem(with: AVPlayerItem.init(url: URL))
        
        print("video will start play")
    }
    
    func play() {
        self.player.play()
    }
    
    func setupPlayerWithURL(_ URL: URL) {
        self.player = AVPlayer.init(url: URL)
        let playerLayer = AVPlayerLayer.init(player: self.player)
        playerLayer.frame = self.bounds
        self.layer.addSublayer(playerLayer)
    }
}
