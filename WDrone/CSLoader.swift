//
//  CSLoader.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 29..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit

class CSLoader: UIView {
    static let instance = CSLoader();
    
    var viewColor : UIColor = .white
    var setAlpha : CGFloat = 0.5
    var gifName : String = "loader"
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: UIScreen.main.bounds)
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: gifName)
        return gifImage
    }()
    
    @objc func showLoader() {
        self.addSubview(transparentView)
        self.transparentView.addSubview(gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }
    
    @objc func hideLoader() {
        self.transparentView.removeFromSuperview()
    }
}
