//
//  CSButton.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 12..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit

public enum CSButtonType {
    case bgWhite
    case bgClear
    case bgBlack
}

class CSButton: UIButton {
    convenience init(type: CSButtonType) {
        self.init()
        
        switch type {
        case .bgWhite :
            self.layer.borderColor = UIColor.white.cgColor;
            self.layer.borderWidth = 2;
            self.layer.cornerRadius = 10;
            self.layer.backgroundColor = UIColor.white.cgColor;
            self.titleLabel?.font = UIFont.init(name: "BMJUA", size: 20);
            self.setTitleColor(.black, for: .normal);
        case .bgClear:
            self.layer.borderColor = UIColor.white.cgColor;
            self.layer.borderWidth = 2;
            self.layer.cornerRadius = 10;
            self.titleLabel?.font = UIFont.init(name: "BMJUA", size: 20);
            self.setTitleColor(.white, for: .normal);
        case .bgBlack:
            self.layer.borderColor = UIColor.black.cgColor;
            self.layer.borderWidth = 2;
            self.layer.cornerRadius = 10;
            self.titleLabel?.font = UIFont.init(name: "BMJUA", size: 20);
            self.setTitleColor(.black, for: .normal);
        }
    }
}
