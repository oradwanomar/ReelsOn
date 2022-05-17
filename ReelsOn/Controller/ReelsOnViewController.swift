//
//  ReelsOnViewController.swift
//  ReelsOn
//
//  Created by Omar Ahmed on 14/05/2022.
//

import UIKit

class ReelsOnViewController: UIViewController {
    
    
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
    
    var reels : [ReelData] = [ReelData(userName: "@omarradwan037", userImage: "", video: "", isVerified: true, isLiked: true, caption: "When the song is so hot 😱", likesCount: 9, commentsCount: 6, songTitle: "Adele - Skyfull, James bond film song"),ReelData(userName: "@omarradwan037", userImage: "", video: "", isVerified: true, isLiked: true, caption: "", likesCount: 9, commentsCount: 6, songTitle: "Adele - Skyfull, James bond film song")]

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
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    
}
