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
    func presentActionSheet()
}

class ReelCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Properties
    
    var avQueuePlayer : AVQueuePlayer?
    var avplayerLayer : AVPlayerLayer?
    var delegate :reelCellDelegate?
    var isMuted = false
    
        
    var reelData : ReelData? {
        didSet {
            setUpReelData()
        }
    }
    
    let playerView : UIView = {
        let pv = UIView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.isUserInteractionEnabled = true
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
        
        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubletap.numberOfTapsRequired = 2
        addGestureRecognizer(doubletap)
        
        let onetap = UITapGestureRecognizer(target: self, action: #selector(muteTap(_:)))
        addGestureRecognizer(onetap)
        
        
        onetap.require(toFail: doubletap) // singleTap doesn't effect on doubleTap
        
        reelDetails.moreButton.addTarget(self, action: #selector(showAlertSheet), for: .touchUpInside)
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
    
    
    
    @objc func doubleTap(_ gesture : UIGestureRecognizer){
        guard let gestureView = gesture.view else {return}
        let size = gestureView.frame.width / 4
        let heart = UIImageView(image: UIImage(systemName: "heart.fill"))
        heart.tintColor = .white
        heart.frame = CGRect(x: (gestureView.frame.width-size - 25)/2,
                             y: (gestureView.frame.height-size)/2,
                             width: size + 25,
                             height: size)
        gestureView.addSubview(heart)
        self.reelData?.isLiked = true
        
        UIView.animate(withDuration: 1.4) {
                heart.alpha = 0
            } completion: { done in
                if done {heart.removeFromSuperview()
                }
            }

        
    }
    
    @objc func muteTap(_ gesture:UIGestureRecognizer){
        isMuted = !isMuted
        guard let gestureView = gesture.view else {return}
        let size = gestureView.frame.width / 4
        let mute = UIImageView(image: UIImage(named: "mute"))
        mute.tintColor = .white
        mute.frame = CGRect(x: (gestureView.frame.width-size)/2,
                             y: (gestureView.frame.height-size)/2,
                             width: size,
                             height: size)
        
        let unmute = UIImageView(image: UIImage(named: "unmute"))
        unmute.tintColor = .white
        unmute.frame = CGRect(x: (gestureView.frame.width-size)/2,
                             y: (gestureView.frame.height-size)/2,
                             width: size,
                             height: size)
                
        if isMuted {
            gestureView.addSubview(mute)
            avQueuePlayer?.isMuted = true
            UIView.animate(withDuration: 0.7) {
                mute.alpha = 0
            } completion: { done in
                if done {mute.removeFromSuperview()
                }
            }
            
        }else {
            gestureView.addSubview(unmute)
            avQueuePlayer?.isMuted = false
            
            UIView.animate(withDuration: 0.7) {
                unmute.alpha = 0
            } completion: { done in
                if done {unmute.removeFromSuperview()
                }
            }
        }
    }
    
    @objc func longPressAction(_ gesture : UILongPressGestureRecognizer){
        if gesture.state == .began {
            avQueuePlayer?.pause()
            delegate?.hideWhenLongTouchBegan()
            UIView.animate(withDuration: 0.4){
                DispatchQueue.main.async {
                    self.reelDetails.alpha = 0

                }
            }
        }
        if gesture.state == .ended {
            avQueuePlayer?.play()
            delegate?.showWhenLongTouchEnded()
            UIView.animate(withDuration: 0.4){
                DispatchQueue.main.async {
                    self.reelDetails.alpha = 1

                }
            }
        }
    }
    
    @objc func showAlertSheet(){
        delegate?.presentActionSheet()
    }

    
    func setUpReelData(){
        guard let reelData = reelData else {return}
        reelDetails.profileImage.image = UIImage(named: reelData.userImage!)
        reelDetails.songImage.image = UIImage(named: reelData.songImage!)
        reelDetails.caption.text = reelData.caption
        reelDetails.songMarqueeLabel.text = reelData.songTitle
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
