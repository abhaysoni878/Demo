//
//  PlayerView.swift
//
//
//  Created by
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class PlayerView: UIView {
    
    
    // MARK: - we can access the player by the player property of AVPlayerLayer
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    
    
}
