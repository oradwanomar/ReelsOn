//
//  ReelCollectionViewCell.swift
//  ReelsOn
//
//  Created by Omar Ahmed on 14/05/2022.
//

import UIKit
import AVKit


protocol reelCellDelegate {
    func hideWhenLongTouchBegan()
    func showWhenLongTouchEnded()
}

class ReelCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Properties
    
    var avQueuePlayer : AVQueuePlayer?
    var avplayerLayer : AVPlayerLayer?
    var delegate :reelCellDelegate?
    
        
    var reelData : ReelData? {
        didSet {
            setUpReelData()
        }
    }
    
    let playerView : UIView = {
        let pv = UIView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    private let reelDetails : ReelDetailsView = {
        let reelDetails = ReelDetailsView()
        reelDetails.translatesAutoresizingMaskIntoConstraints = false
        return reelDetails
    }()
    
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playerView)
        addSubview(reelDetails)
        setUpConstrains()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        addGestureRecognizer(longPress)
        
//        let press = UIGestureRecognizer(target: self, action: #selector(press))
//        addGestureRecognizer(press)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPlayer(url:URL ,bounds:CGRect){
        avQueuePlayer = AVQueuePlayer(url: url)
        avplayerLayer = AVPlayerLayer(player: avQueuePlayer!)
        avplayerLayer?.frame = bounds
        avplayerLayer?.fillMode = .both
        avplayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerView.layer.addSublayer(avplayerLayer!)
    }
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
            reelDetails.leadingAnchor.constraint(equalTo: leadingAnchor),
            reelDetails.trailingAnchor.constraint(equalTo: trailingAnchor),
            reelDetails.bottomAnchor.constraint(equalTo: bottomAnchor),
            reelDetails.heightAnchor.constraint(equalToConstant: 240),
            
            playerView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            playerView.topAnchor.constraint(equalTo: playerView.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
        ])
    }
    
    @objc func longPressAction(gesture : UILongPressGestureRecognizer){
        if gesture.state == .began {
            avQueuePlayer?.pause()
            delegate?.hideWhenLongTouchBegan()
            UIView.animate(withDuration: 0.3){
                DispatchQueue.main.async {
                    self.reelDetails.alpha = 0

                }
            }
        }
        if gesture.state == .ended {
            avQueuePlayer?.play()
            delegate?.showWhenLongTouchEnded()
            UIView.animate(withDuration: 0.3){
                DispatchQueue.main.async {
                    self.reelDetails.alpha = 1

                }
            }
        }
    }
    
//    @objc func press(gesture : UIGestureRecognizer){
//        if gesture.state == .began {
//            avQueuePlayer?.volume = 0
//        }
//    }
    
    func setUpReelData(){
        guard let reelData = reelData else {return}
        reelDetails.profileImage.image = UIImage(named: reelData.userImage!)
        reelDetails.songImage.image = UIImage(named: reelData.songImage!)
        if reelData.isLiked! {
            reelDetails.likebutton.setImage(UIImage(named: "love")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }else{
            reelDetails.likebutton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        reelDetails.likebutton.imageView?.tintColor = reelData.isLiked! ? .red : .white
        let attributedText = NSMutableAttributedString(string:"\(reelData.userName!)  ", attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        if reelData.isVerified! {
            let font = UIFont.systemFont(ofSize: 14, weight: .bold)
            let verifiyImg = UIImage(named:"verify")?.withRenderingMode(.alwaysTemplate)
                let verifiedImage = NSTextAttachment()
                verifiedImage.image = verifiyImg?.withTintColor(.white)
                verifiedImage.bounds = CGRect(x: 0, y: (font.capHeight - 13).rounded() / 2, width: 13, height: 13)
                verifiedImage.setImageHeight(height: 13)
                let imgString = NSAttributedString(attachment: verifiedImage)
                attributedText.append(imgString)
        }
        reelDetails.userName.attributedText = attributedText
    }
}
