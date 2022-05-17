//
//  ReelCollectionViewCell.swift
//  ReelsOn
//
//  Created by Omar Ahmed on 14/05/2022.
//

import UIKit
import AVKit

class ReelCollectionViewCell: UICollectionViewCell {
        
    var reelData : ReelData? {
        didSet {
            reelDetails.userName.text = reelData?.userName
        }
    }
    
    private let reelDetails : ReelDetailsView = {
        let reelDetails = ReelDetailsView()
        reelDetails.translatesAutoresizingMaskIntoConstraints = false
        return reelDetails
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reelDetails)
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
            reelDetails.leadingAnchor.constraint(equalTo: leadingAnchor),
            reelDetails.trailingAnchor.constraint(equalTo: trailingAnchor),
            reelDetails.bottomAnchor.constraint(equalTo: bottomAnchor),
            reelDetails.heightAnchor.constraint(equalToConstant: 240),
        ])
    }
}
