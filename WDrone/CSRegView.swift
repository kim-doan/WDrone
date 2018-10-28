//
//  CSRegView.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 15..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit
import Alamofire

class CSRegView: UIView {
    
    let idField = CSTextField()
    let passField = CSTextField()
    let conPassField = CSTextField()
    let phoneField = CSTextField()
    let nameField = CSTextField()
    
    let registerBtn = CSButton(type: .bgWhite)
    let exitBtn = CSButton(type: .bgWhite)
    
    // #1
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // #2
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.idField.becomeFirstResponder(); // 키보드 보이기
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6); // 배경 반투명
        self.layer.borderWidth = 1
        let myColor = UIColor.white
        self.layer.borderColor = myColor.cgColor
        self.layer.cornerRadius = 10
        
        //회원 이미지
        let imageName = "account"
        let image = UIImage(named: imageName)
        let memberImage = UIImageView(image: image!)
        memberImage.frame = CGRect(x: 10, y: 10, width: 90, height: 90)
        self.addSubview(memberImage)
        
        let message = UILabel()
        message.frame = CGRect(x: 30, y: 150, width: 200, height: 30)
        message.center = CGPoint(x: memberImage.frame.size.width / 2 + 180, y: memberImage.frame.size.height / 2);
        message.text = "회원정보를 입력해주세요"
        message.font = UIFont.init(name: "BMJUA", size: 20)
        message.textColor = UIColor.white
        self.addSubview(message)
        
        //아이디 필드
        idField.type = .id
        idField.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 - 70);
        self.addSubview(idField);
        
        //패스워드 필드
        passField.type = .password
        passField.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 - 30);
        self.addSubview(passField);
        
        //패스워드 확인 필드
        conPassField.type = .conPassword
        conPassField.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 + 10);
        self.addSubview(conPassField);
        
        //이름
        nameField.type = .name
        nameField.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 + 50);
        self.addSubview(nameField);
        
        //휴대폰 번호
        phoneField.type = .phone
        phoneField.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2 + 90);
        self.addSubview(phoneField);
        
        //회원가입 버튼
        registerBtn.frame = CGRect(x: 39, y: 691, width: 150, height: 40);
        registerBtn.setTitle("회원가입", for: UIControl.State.normal)
        registerBtn.center = CGPoint(x: self.frame.size.width / 2 - 80, y: self.frame.size.height / 2 + 160);
        registerBtn.addTarget(self, action: #selector(regBtnAction(_:)), for: .touchUpInside);
        self.addSubview(registerBtn)
        
        //회원가입 취소 버튼
        exitBtn.frame = CGRect(x: 39, y: 691, width: 150, height: 40);
        exitBtn.setTitle("취소", for: UIControl.State.normal)
        exitBtn.center = CGPoint(x: self.frame.size.width / 2 + 80, y: self.frame.size.height / 2 + 160);
        exitBtn.addTarget(self, action: #selector(exitBtnAction(_:)), for: .touchUpInside);
        self.addSubview(exitBtn)
    }
    
    @objc func regBtnAction(_ sender : UIButton) {
        let param: Parameters = [
            "id" : self.idField.text!,
            "password" : self.passField.text!,
            "name" : self.nameField.text!,
            "phone" : self.phoneField.text!
        ]
        let alamo = Alamofire.request("http://35.194.119.42:8080/register", method: .post, parameters: param, encoding: URLEncoding.httpBody);
        
        alamo.responseString() { response in
            print("post=\(response.result.value!)");
            
            if response.result.value! == "1" {
                print("회원가입 성공");
                self.removeFromSuperview()
            } else {
                print("회원가입 실패");
            }
        }
    }
    
    @objc func exitBtnAction(_ sender : UIButton) {
        self.removeFromSuperview()
    }
}
