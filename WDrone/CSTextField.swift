//
//  CSTextField.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 12..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit

public enum type:Int {
    case id = 0
    case password = 1
    case conPassword = 2
    case phone = 3
    case name = 4
}
class CSTextField: UITextField {
    
    var type:type = .id {
        didSet {
            switch self.type.rawValue {
                case 0:
                    self.font = UIFont.systemFont(ofSize: 15);
                    self.textColor = UIColor.white;
                    self.tintColor = UIColor.white;
                    self.adjustsFontSizeToFitWidth = true; // 폰트 자동 조정
                    self.autocapitalizationType = .none; // 자동 대문자 끄기
                    
                    self.frame = CGRect(x: 0, y: 100, width: 300, height: 40);
                    self.placeholder = " 아이디";
                    // placeholder 색상
                    guard let idholder = self.placeholder, !idholder.isEmpty else {return};
                    self.attributedPlaceholder = NSAttributedString(string: idholder, attributes: [.foregroundColor: UIColor.white])
                    //아래에만 밑줄
                    let lineColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
                    let borderLine = UIView();
                    let height = 2.0;
                    self.borderStyle = UITextField.BorderStyle.none;
                    self.backgroundColor = UIColor.clear;
                    borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height);
                    borderLine.backgroundColor = lineColor;
                    self.addSubview(borderLine);
                    break;
                case 1:
                    self.font = UIFont.systemFont(ofSize: 15);
                    self.textColor = UIColor.white;
                    self.tintColor = UIColor.white;
                    self.adjustsFontSizeToFitWidth = true; // 폰트 자동 조정
                    self.autocapitalizationType = .none; // 자동 대문자 끄기
                    self.isSecureTextEntry = true;
                    
                    self.frame = CGRect(x: 0, y: 100, width: 300, height: 40);
                    self.placeholder = " 비밀번호";
                    // placeholder 색상
                    guard let idholder = self.placeholder, !idholder.isEmpty else {return};
                    self.attributedPlaceholder = NSAttributedString(string: idholder, attributes: [.foregroundColor: UIColor.white])
                    //아래에만 밑줄
                    let lineColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
                    let borderLine = UIView();
                    let height = 2.0;
                    self.borderStyle = UITextField.BorderStyle.none;
                    self.backgroundColor = UIColor.clear;
                    borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height);
                    borderLine.backgroundColor = lineColor;
                    self.addSubview(borderLine);
                    break;
                case 2:
                    self.font = UIFont.systemFont(ofSize: 15);
                    self.textColor = UIColor.white;
                    self.tintColor = UIColor.white;
                    self.adjustsFontSizeToFitWidth = true; // 폰트 자동 조정
                    self.autocapitalizationType = .none; // 자동 대문자 끄기
                    self.isSecureTextEntry = true;
                    
                    self.frame = CGRect(x: 0, y: 100, width: 300, height: 40);
                    self.placeholder = " 비밀번호 확인";
                    // placeholder 색상
                    guard let idholder = self.placeholder, !idholder.isEmpty else {return};
                    self.attributedPlaceholder = NSAttributedString(string: idholder, attributes: [.foregroundColor: UIColor.white])
                    //아래에만 밑줄
                    let lineColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
                    let borderLine = UIView();
                    let height = 2.0;
                    self.borderStyle = UITextField.BorderStyle.none;
                    self.backgroundColor = UIColor.clear;
                    borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height);
                    borderLine.backgroundColor = lineColor;
                    self.addSubview(borderLine);
                    break;
                case 3:
                    self.keyboardType = UIKeyboardType.phonePad
                    self.font = UIFont.systemFont(ofSize: 15);
                    self.textColor = UIColor.white;
                    self.tintColor = UIColor.white;
                    self.adjustsFontSizeToFitWidth = true; // 폰트 자동 조정
                    self.autocapitalizationType = .none; // 자동 대문자 끄기
                    
                    self.frame = CGRect(x: 0, y: 100, width: 300, height: 40);
                    self.placeholder = " 휴대폰 번호";
                    // placeholder 색상
                    guard let idholder = self.placeholder, !idholder.isEmpty else {return};
                    self.attributedPlaceholder = NSAttributedString(string: idholder, attributes: [.foregroundColor: UIColor.white])
                    //아래에만 밑줄
                    let lineColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
                    let borderLine = UIView();
                    let height = 2.0;
                    self.borderStyle = UITextField.BorderStyle.none;
                    self.backgroundColor = UIColor.clear;
                    borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height);
                    borderLine.backgroundColor = lineColor;
                    self.addSubview(borderLine);
                    break;
                case 4:
                    self.font = UIFont.systemFont(ofSize: 15);
                    self.textColor = UIColor.white;
                    self.tintColor = UIColor.white;
                    self.adjustsFontSizeToFitWidth = true; // 폰트 자동 조정
                    self.autocapitalizationType = .none; // 자동 대문자 끄기
                    
                    self.frame = CGRect(x: 0, y: 100, width: 300, height: 40);
                    self.placeholder = " 이름";
                    // placeholder 색상
                    guard let idholder = self.placeholder, !idholder.isEmpty else {return};
                    self.attributedPlaceholder = NSAttributedString(string: idholder, attributes: [.foregroundColor: UIColor.white])
                    //아래에만 밑줄
                    let lineColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0);
                    let borderLine = UIView();
                    let height = 2.0;
                    self.borderStyle = UITextField.BorderStyle.none;
                    self.backgroundColor = UIColor.clear;
                    borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height);
                    borderLine.backgroundColor = lineColor;
                    self.addSubview(borderLine);
                    break;
            default:
                break;
            }
        }
    }

}
