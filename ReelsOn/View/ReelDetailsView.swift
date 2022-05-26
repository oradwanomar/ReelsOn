//
//  ReelDetailsView.swift
//  ReelsOn
//
//  Created by Omar Ahmed on 14/05/2022.
//

import UIKit
import Lottie
import MarqueeLabel

class ReelDetailsView : UIView {
    
    // MARK: Proprities

    
    lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
     let likebutton : UIButton = {
        let likeBtn = UIButton()
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        likeBtn.imageView?.tintColor = .white
        return likeBtn
    }()
    
    private let commentButton : UIButton = {
        let commentBtn = UIButton()
        commentBtn.translatesAutoresizingMaskIntoConstraints = false
        commentBtn.setImage(UIImage(systemName: "message"), for: .normal)
        commentBtn.tintColor = .white
        return commentBtn
    }()
    
    private let shareButton : UIButton = {
        let shareBtn = UIButton()
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        shareBtn.setImage(UIImage(systemName: "arrowshape.turn.up.forward"), for: .normal)
        shareBtn.tintColor = .white
        return shareBtn
    }()
    
     let moreButton : UIButton = {
        let moreBtn = UIButton()
        moreBtn.translatesAutoresizingMaskIntoConstraints = false
        moreBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreBtn.tintColor = .white
        return moreBtn
    }()
    
    private let countView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var likes : UILabel = {
        let likes = UILabel()
        likes.text = "1.2k"
        likes.tintColor = .white
        likes.font = UIFont.boldSystemFont(ofSize: 14)
        return likes
    }()
    
    var dislikes : UILabel = {
        let dislikes = UILabel()
        dislikes.text = "546"
        dislikes.tintColor = .white
        dislikes.font = UIFont.boldSystemFont(ofSize: 14)
        return dislikes
    }()
    
     var commentCountButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let renderImage = UIImage(named: "share")?.withRenderingMode(.automatic).withTintColor(.white)
        btn.setImage(renderImage, for: .normal)
        return btn
    }()
    
    lazy var equalizerView: AnimationView = {
        let v = AnimationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.animation = Animation.named("equalizer")
        v.loopMode = .loop
        v.play()
        return v
    }()
    lazy var equalizerView2: AnimationView = {
        let v = AnimationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.animation = Animation.named("equaliser")
        v.loopMode = .loop
        v.play()
        return v
    }()
    
    var songMarqueeLabel : MarqueeLabel = {
        var songLabel = MarqueeLabel()
        songLabel.translatesAutoresizingMaskIntoConstraints = false
        songLabel.textColor = .white
        songLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        songLabel.type = .continuous
        songLabel.text = "Adele - Skyfull, James bond film song"
        songLabel.animationCurve = .linear
        songLabel.fadeLength = 10
        songLabel.leadingBuffer = 0
        songLabel.trailingBuffer = 15
        return songLabel
    }()
    
     let caption : UILabel = {
        var caption = UILabel()
        caption.translatesAutoresizingMaskIntoConstraints = false
        caption.textColor = .white
        caption.text = "When the song is hot 😱 "
        caption.font = UIFont.preferredFont(forTextStyle: .footnote)
        return caption
    }()
    
    private let profileView : UIView = {
        let pv = UIView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
     let userName : UILabel = {
        var usernameLabel = UILabel()
        usernameLabel.text = "@omarradwan037"
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.textColor = .white
        usernameLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        return usernameLabel
    }()
    
     let profileImage : UIImageView = {
        let profileImg = UIImageView()
        profileImg.backgroundColor = .white
        profileImg.translatesAutoresizingMaskIntoConstraints = false
        profileImg.layer.cornerRadius = 15
        profileImg.image = UIImage(named: "1")
        profileImg.clipsToBounds = true
        return profileImg
    }()
    
     let songImage : UIImageView = {
        let songImg = UIImageView()
        songImg.backgroundColor = .white
        songImg.translatesAutoresizingMaskIntoConstraints = false
        songImg.layer.cornerRadius = 10
        songImg.image = UIImage(named: "1")
        songImg.clipsToBounds = true
        return songImg
    }()
    
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpContsrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [UIColor.clear.cgColor,UIColor.black.withAlphaComponent(0.7).cgColor]
    }
    
    // MARK: Helper
    
  
    
    func setUpViews(){
        addSubview(stackView)
        [likebutton,commentButton,shareButton,moreButton].forEach {
            stackView.addArrangedSubview($0)
        }
        addSubview(countView)
        [commentCountButton,songImage].forEach{countView.addSubview($0)}
        [equalizerView,songMarqueeLabel,caption,profileView].forEach {addSubview($0)}
        [profileImage,userName].forEach{profileView.addSubview($0)}
        songImage.addSubview(equalizerView2)
    }
    
    func setUpContsrains(){
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 35),
            stackView.widthAnchor.constraint(equalToConstant: 165),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            countView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),
            countView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            countView.heightAnchor.constraint(equalToConstant: 100),
            
            commentCountButton.bottomAnchor.constraint(equalTo: songImage.topAnchor, constant: -20),
            commentCountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            songImage.bottomAnchor.constraint(equalTo: countView.bottomAnchor, constant: -25),
            songImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            songImage.widthAnchor.constraint(equalToConstant: 30),
            songImage.heightAnchor.constraint(equalToConstant: 30),
            
            
            equalizerView2.leadingAnchor.constraint(equalTo: songImage.leadingAnchor),
            equalizerView2.bottomAnchor.constraint(equalTo: songImage.bottomAnchor),
            equalizerView2.widthAnchor.constraint(equalToConstant: 30),
            equalizerView2.heightAnchor.constraint(equalToConstant: 30),
            
            equalizerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            equalizerView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -5),
            equalizerView.widthAnchor.constraint(equalToConstant: 35),
            equalizerView.heightAnchor.constraint(equalToConstant: 35),
            
            songMarqueeLabel.leadingAnchor.constraint(equalTo: equalizerView.trailingAnchor, constant: -4),
            songMarqueeLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -15),
            songMarqueeLabel.widthAnchor.constraint(equalToConstant: 180),
            
            caption.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            caption.bottomAnchor.constraint(equalTo: songMarqueeLabel.topAnchor, constant: -20),
            caption.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            profileView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileView.bottomAnchor.constraint(equalTo: caption.topAnchor, constant: -10),
            profileView.heightAnchor.constraint(equalToConstant: 35),
            
            profileImage.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 30),
            profileImage.heightAnchor.constraint(equalToConstant: 30),
            
            userName.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10)
            
            
        ])
    }
    
   
    
    
    
}
