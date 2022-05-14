//
//  CustomNavigationController.swift
//  ReelsOn
//
//  Created by Omar Ahmed on 14/05/2022.
//

import Foundation
import UIKit

class CustomNavigationViewController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        bounds.size.height += statusBarHeight
        gradient.frame = bounds
        gradient.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
    }
    
}
