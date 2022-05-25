//
//  ReelsOnViewController.swift
//  ReelsOn
//
//  Created by Omar Ahmed on 14/05/2022.
//

import UIKit

class ReelsOnViewController: UIViewController {
    
    var isPlay = false
    var isMute = false
    
    lazy var collectionView : UICollectionView = {
        let collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        let layout = UICollectionViewFlowLayout.init()
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.showsVerticalScrollIndicator = false
        layout.scrollDirection = .vertical
        
        
        collectionview.contentInsetAdjustmentBehavior = .never
        collectionview.setCollectionViewLayout(layout, animated: false)
        collectionview.register(ReelCollectionViewCell.self, forCellWithReuseIdentifier: "ReelCollectionViewCell")
        collectionview.isPagingEnabled = true
        collectionview.backgroundColor = .systemBackground
        collectionview.delegate = self
        collectionview.dataSource = self
        return collectionview
    }()
    
    var reels : [ReelData] = [ReelData(userName: "@omarahmed10", userImage: "3", video: "video2", isVerified: true, isLiked: false, caption: "When the song is so beautiful woow ! 😱", likesCount: 9, commentsCount: 6, songTitle: "Adele - Skyfull, James bond film song",songImage: "demo2"),ReelData(userName: "@omarrrradwan037", userImage: "1", video: "demo", isVerified: false, isLiked: true, caption: "When the song is so hot 😱", likesCount: 9, commentsCount: 6, songTitle: "Adele - Skyfull, James bond film song", songImage: "demo1")]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Reels"
        navigationController?.navigationBar.shadowImage = UIImage()
        view.addSubview(collectionView)
        setUpConstrains()
    }
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}

extension ReelsOnViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCollectionViewCell", for: indexPath) as! ReelCollectionViewCell
        cell.reelData = reels[indexPath.row]
        cell.delegate = self
        if let urlPath = Bundle.main.url(forResource: reels[indexPath.row].video, withExtension: "mp4"){
            cell.setUpPlayer(url: urlPath, bounds: collectionView.frame)
            if !isPlay{
                cell.avQueuePlayer?.play()
                isPlay = true
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach { cell in
            let cell = cell as! ReelCollectionViewCell
            cell.avQueuePlayer?.pause()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach { cell in
            let cell = cell as! ReelCollectionViewCell
            cell.avQueuePlayer?.seek(to: .zero)
            cell.avQueuePlayer?.play()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ReelCollectionViewCell
        cell.avQueuePlayer?.pause()
    }
    
    
    
}

extension ReelsOnViewController : reelCellDelegate {
    
    func hideWhenLongTouchBegan() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func showWhenLongTouchEnded() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func presentActionSheet() {
        let alertSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Report", style: .destructive, handler: nil)
        let action2 = UIAlertAction(title: "Not intersted", style: .destructive, handler: nil)
        let action3 = UIAlertAction(title: "Save", style: .default, handler: nil)
        let action4 = UIAlertAction(title: "copy link", style: .default, handler: nil)
        let action5 = UIAlertAction(title: "Share to...", style: .default, handler: nil)
        let action6 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        [action1,action2,action3,action4,action5,action6].forEach{alertSheet.addAction($0)}
        present(alertSheet, animated: true, completion: nil)
    }
    
    
}
