//
//  PlayerViewController.swift
//  Demo
//
//  Created by Abhay on .
//

import UIKit
import WebKit
import AVKit
class ImagePreviewViewController: UIViewController {
    //MARK: --Outlets--
    @IBOutlet weak var crossBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var videovw: PlayerView!
    //MARK: --variable/INSTANCE--
    var nav: UINavigationController?
    var videoData: String?
    var players: AVPlayer?
    var playerLayers: AVPlayerLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.crossBtn.setImage(self.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
//        self.crossBtn.imageView?.tintColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetup()
        loadYoutube(videoID: videoData ?? "")

    }
    func loadYoutube(videoID:String) {
    guard let youtubeURL = URL(string: videoID) else {
    return
    }
        webView.configuration.allowsInlineMediaPlayback = false
        if #available(iOS 15.4, *) {
            webView.configuration.preferences.isElementFullscreenEnabled = true
        } else {
            // Fallback on earlier versions
        }
    webView.load(URLRequest(url: youtubeURL))
    
    }
    //MARK: ------------------Navigation Setup----
    func navigationSetup() {

        self.navigationController?.isNavigationBarHidden = true
        //setupNavigationBarWithTitle(title: "Popular Talent", titleFont: UIFont(name: "Poppins-Bold", size: 21), titleLeadingImage: "", titleTrailingImage: "", textcolor: .black, transpapernt: true)
    }
    @IBAction func crossBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    

   

}
