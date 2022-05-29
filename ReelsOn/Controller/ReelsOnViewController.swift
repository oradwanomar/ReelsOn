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
    
    var reels : [ReelData] = [ReelData(userName: "@omarahmed10", userImage: "3", video: "video2", isVerified: true, isLiked: false, caption: "When the song is so beautiful woow ! 😱", likesCount: 9, commentsCount: 6, songTitle: "Adele - Skyfull, James bond film song",songImage: "demo2"),ReelData(userName: "@omarrrradwan037", userImage: "1", video: "demo", isVerified: false, isLiked: true, caption: "When the song is so hot 😱", likesCount: 9, commentsCount: 6, songTitle: "Adele - Skyfull, James bond film song", songImage: "demo1"),ReelData(userName: "@moraradwan11", userImage: "2", video: "demo1", isVerified: true, isLiked: false, caption: "I'm really love this amzing song ❤️😭", likesCount: 223, commentsCount: 34, songTitle: "Ashes - Celien Dion from DeadPool 2", songImage: "demo2"),ReelData(userName: "@markJones", userImage: "1", video: "demo2", isVerified: false, isLiked: false, caption: "That's amazing romantic song 💞🤩🎼", likesCount: 834, commentsCount: 443, songTitle: "Faouzia & John Legend - Minefields", songImage: "demo2"),ReelData(userName: "@omarahmed10", userImage: "3", video: "demo3", isVerified: true, isLiked: true, caption: "what a song from this amazing band 🎸🥁❤️", likesCount: 948, commentsCount: 574, songTitle: "The Score - Stronger (Original)", songImage: "demo1")]

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

extension ReelsOnViewController {
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-75, y: self.view.frame.size.height-300, width: 150, height: 40))
        toastLabel.backgroundColor = .label
        toastLabel.textColor = .systemBackground
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 8;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.5, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
        
        let action3 = UIAlertAction(title: "Save", style: .default) { _ in
            self.showToast(message: "Saved", font: UIFont.systemFont(ofSize: 15))
        }
        
        let action4 = UIAlertAction(title: "copy link", style: .default) { _ in
            self.showToast(message: "Copied", font: UIFont.systemFont(ofSize: 15))
        }
        
        let action5 = UIAlertAction(title: "Share to...", style: .default, handler: nil)
        let action6 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        [action1,action2,action3,action4,action5,action6].forEach{alertSheet.addAction($0)}
        present(alertSheet, animated: true, completion: nil)
    }
    
    
}

