//
//  ViewController.swift
//  Demo
//
//  Created by Abhay on 04/06/24.
//

import UIKit

class ViewController: UIViewController {

    //MARK: --variable/INSTANCE--
    var videoUrl: String?
    var mediaData: [VideoElement]?
    //MARK: --outlets--
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: --viewlifecycle--
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCollectionViewCell")
        apiCall()
        self.navigationController?.isNavigationBarHidden = false
    }
    //MARK: --Api calling--
    func apiCall() {
        let url = URL(string: "https://uptodd.com/movie/now_playing")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode([VideoElement].self, from: data!)
            self.mediaData = decodedData
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
           
        }.resume()
        
    }
    @objc func videoPlayActn(sender:UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        vc.videoData = videoUrl
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as! MediaCollectionViewCell
        videoUrl = mediaData?[indexPath.row].videoUrl
        let image = "https://image.tmdb.org/t/p/w342" + (mediaData?[indexPath.row].backdropPath ?? "")
        cell.playBtn.addTarget(self, action: #selector(videoPlayActn(sender: )), for: .touchUpInside)
        if let downloadImage = URL(string: image) {
            cell.mediaImg.load(url: downloadImage)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImagePreviewViewController") as! ImagePreviewViewController
        vc.videoData = videoUrl
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2.5)
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
