//
//  SleepMusicViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 23/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class SleepMusicViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    let imageList = [ "ImageThumbnail_3809446568_Normal", "ImageThumbnail_3584004629_Normal", "ImageThumbnail_3563995743_Normal", "ImageThumbnail_1780940859_Normal", "ImageThumbnail_1592326657_Normal", "ImageThumbnail_4056444929_Normal", "ImageThumbnail_3772789657_Normal", "ImageThumbnail_3084127194_Normal", "ImageThumbnail_3371831658_Normal", "ImageThumbnail_188854531_Normal", "ImageThumbnail_1684937011_Normal" ]
    
    let nameList = [ "가벼운 비", "거센 비", "보통 비", "숲 1", "숲 속 강가", "벽난로", "파도", "심장 박동", "커피샵", "베타파", "알파파" ]
    
    let dropBoxURLs = ["https://dl.dropbox.com/s/dtzzpxgoc9kmuj8/%EA%B0%80%EB%B2%BC%EC%9A%B4%20%EB%B9%84.mp3?dl=0", "https://dl.dropbox.com/s/o3i1m72lnu2t7p8/%EA%B1%B0%EC%84%BC%20%EB%B9%84.mp3?dl=0", "https://dl.dropbox.com/s/epgh0dubcr57o0f/%EB%B3%B4%ED%86%B5%20%EB%B9%84.mp3?dl=0", "https://dl.dropbox.com/s/kgpre9pxvmb4rj0/%EC%88%B2%201.mp3?dl=0", "https://dl.dropbox.com/s/9072rm1r3ldi9go/%EC%88%B2%20%EC%86%8D%20%EA%B0%95%EA%B0%80.mp3?dl=0", "https://dl.dropbox.com/s/lddin4vvhm7q8nd/%EB%B2%BD%EB%82%9C%EB%A1%9C.mp3?dl=0", "https://dl.dropbox.com/s/q1fj721xbcm4yvh/%ED%8C%8C%EB%8F%84.mp3?dl=0", "https://dl.dropbox.com/s/f7107ajsi4lq0ga/%EC%8B%AC%EC%9E%A5%20%EB%B0%95%EB%8F%99.mp3?dl=0", "https://dl.dropbox.com/s/taltldnjbnixf52/%EC%BB%A4%ED%94%BC%EC%83%B5.mp3?dl=0", "https://dl.dropbox.com/s/3kntu7im4m9una6/%EB%B2%A0%ED%83%80%ED%8C%8C.mp3?dl=0", "https://dl.dropbox.com/s/hzlcu6ab74026cd/%EC%95%8C%ED%8C%8C%ED%8C%8C.mp3?dl=0"]
    
    var musicPlayer: AVAudioPlayer?
    var audioSession: AVAudioSession?
    
    let mp3Path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    
    @IBOutlet weak var musicListCollectionView: UICollectionView!
    @IBOutlet weak var thumbNailImageView: UIImageView!
    @IBOutlet weak var tumbNailNameLabel: UILabel!
    @IBOutlet weak var musicPlayTimeLabel: UILabel!
    @IBOutlet weak var musicPlayButton: UIButton!
    @IBOutlet weak var musicPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicListCollectionView.backgroundColor = UIColor.black
        
        let layout = UICollectionViewFlowLayout()
        let width = self.view.frame.width / 2 - 15 * 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        musicListCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    @IBAction func playMusic(_ sender: Any) {
        guard let player = musicPlayer else { return }
        player.play()
        musicPlayButton.isHidden = true
        musicPauseButton.isHidden = false
        
    }
    
    @IBAction func pauseMusic(_ sender: Any) {
        
        musicPlayer?.pause()
        musicPlayButton.isHidden = false
        musicPauseButton.isHidden = true
    }
    
    deinit {
        print(self, #function)
    }
    
}

extension SleepMusicViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SleepMusicCollectionViewCell.reuseIdentifier, for: indexPath) as! SleepMusicCollectionViewCell
        cell.musicImageView.image = UIImage(named: imageList[indexPath.row])
        cell.musicNameLabel.text = nameList[indexPath.row]
        return cell
    }
}

extension SleepMusicViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        thumbNailImageView.image = UIImage(named: imageList[indexPath.row])
        tumbNailNameLabel.text = nameList[indexPath.row]
        
        let pathComponent = mp3Path.appendingPathComponent("\(nameList[indexPath.row])" + ".mp3")
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
                        do {
                            musicPlayer = try AVAudioPlayer(contentsOf: pathComponent)
                            playMusic(self)
                        } catch {
                            print("Invalid Player")
                        }
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! SleepMusicCollectionViewCell
            cell.indicator.startAnimating()
            
            guard let url = URL(string: dropBoxURLs[indexPath.row]) else { return }
            
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
            
            AF.download(url, interceptor: nil, to: destination).downloadProgress { (progress) in
                
            }.responseData(queue: .main) { [weak self](response) in
                cell.indicator.stopAnimating()
                do {
                    self?.musicPlayer = try AVAudioPlayer(contentsOf: pathComponent)
                    self?.playMusic(self)
                } catch {
                    print("Invalid Player")
                }
            }
        }
    }
    
}
