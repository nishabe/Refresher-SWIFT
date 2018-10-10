//
//  AVPlayerViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 10/10/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit
import AVKit

class AVPlayerSampleTwoViewController: UIViewController {
var avPlayer: AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filepath: String? = Bundle.main.path(forResource: "big_buck_bunny", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)
        avPlayer = AVPlayer(url: fileURL)
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        present(avPlayerController, animated: true) {
            avPlayerController.player?.play()
        }
    }
}
