//
// Bitmovin Player iOS SDK
// Copyright (C) 2021, Bitmovin GmbH, All Rights Reserved
//
// This source code and its use and distribution, is subject to the terms
// and conditions of the applicable license agreement.
//

import UIKit
import BitmovinPlayer
import BitmovinAnalyticsCollector

final class ViewController: UIViewController {
    var player: Player!
    var analyticsCollector: BitmovinPlayerCollector

    required init?(coder aDecoder: NSCoder) {
        // Set up Bitmovin Analytics
        let analyticsLicenseKey = Bundle.main.object(forInfoDictionaryKey: "BitmovinAnalyticsLicenseKey") as! String
        let analyticsConfig = BitmovinAnalyticsConfig(key: analyticsLicenseKey)
        analyticsConfig.customerUserId = "user_1"
        analyticsCollector = BitmovinPlayerCollector(config: analyticsConfig)
        
        super.init(coder: aDecoder)
    }
    
    deinit {
        analyticsCollector.detachPlayer()
        player?.destroy()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black

        // Define needed resources
        guard let streamUrl = URL(string: "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"),
              let posterUrl = URL(string: "https://bitmovin-a.akamaihd.net/content/MI201109210084_1/poster.jpg") else {
            return
        }

        // Create player configuration
        let playerConfig = PlayerConfig()

        // Create player based on player config
        player = PlayerFactory.create(playerConfig: playerConfig)

        // Create player view and pass the player instance to it
        let playerView = PlayerView(player: player, frame: .zero)

        // Listen to player events
        player.add(listener: self)

        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        playerView.frame = view.bounds

        view.addSubview(playerView)
        view.bringSubviewToFront(playerView)

        // Create source config
        let sourceConfig = SourceConfig(url: streamUrl, type: .hls)
        
        // Set a poster image
        sourceConfig.posterSource = posterUrl
        
        // setup analytics
        analyticsCollector.attachPlayer(player: player)
        let source = SourceFactory.create(from: sourceConfig)
        let metadata = SourceMetadata(videoId: "awolnation_id",
                                      title: "awolnation",
                                      experimentName: "ios-analytics-integration")
        self.analyticsCollector.addSourceMetadata(playerSource: source, sourceMetadata: metadata)

        player.load(source: source)
    }
}

extension ViewController: PlayerListener {
    func onEvent(_ event: Event, player: Player) {
        dump(event, name: "[Player Event]", maxDepth: 1)
    }
}
