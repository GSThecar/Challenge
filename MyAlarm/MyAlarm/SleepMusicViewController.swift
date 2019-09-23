//
//  SleepMusicViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 23/09/2019.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit

class SleepMusicViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    let imageList = [ "ImageThumbnail_3809446568_Normal", "ImageThumbnail_3584004629_Normal", "ImageThumbnail_3563995743_Normal", "ImageThumbnail_1780940859_Normal", "ImageThumbnail_1592326657_Normal", "ImageThumbnail_4056444929_Normal", "ImageThumbnail_3772789657_Normal", "ImageThumbnail_3084127194_Normal", "ImageThumbnail_3371831658_Normal", "ImageThumbnail_188854531_Normal", "ImageThumbnail_1684937011_Normal" ]
    let nameList = [ "가벼운 비", "거센 비", "보통 비", "숲 1", "숲 속 강가", "벽난로", "파도", "심장 박동", "커피샵", "베타파", "알파파" ]
    
    @IBOutlet weak var musicListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        musicListCollectionView.backgroundColor = UIColor.black
        
        let layout = UICollectionViewFlowLayout()
        let width = self.view.frame.width / 2 - 15 * 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        musicListCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SleepMusicCollectionViewCell.identifier, for: indexPath) as! SleepMusicCollectionViewCell
        cell.musicImageView.image = UIImage(named: imageList[indexPath.row])
        cell.musicNameLabel.text = nameList[indexPath.row]
        return cell
    }
}

extension SleepMusicViewController: UICollectionViewDelegate {
    
}
