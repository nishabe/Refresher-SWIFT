//
//  AVPlayerSampleViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 10/10/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit
import AVKit

class AVPlayerSampleOneViewController: UIViewController {
    var avPlayer: AVPlayer!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let filepath: String? = Bundle.main.path(forResource: "big_buck_bunny", ofType: "mp4")
        if let filepath = filepath {
            let fileURL = URL.init(fileURLWithPath: filepath)
            let player = AVPlayer(url: fileURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
        }
    }

}
