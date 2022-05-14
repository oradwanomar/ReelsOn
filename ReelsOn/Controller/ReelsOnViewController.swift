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
        collectionview.isPagingEnabled = true
        collectionview.backgroundColor = .systemBackground
        collectionview.delegate = self
        collectionview.dataSource = self
        return collectionview
    }()
    
    var reels : [ReelData] = []

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
        <#code#>
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
