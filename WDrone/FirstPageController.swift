//
//  ViewController.swift
//  SmartHospital
//
//  Created by 김도안 on 2018. 7. 16..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit
import Alamofire
class FirstPageController : UIViewController {
    
    @IBOutlet weak var gifView: UIImageView!
    
    var regView = CSRegView(frame: CGRect(x: 50, y: 50, width: 350, height: 400));
    
    let regBtn = CSButton(type: .bgClear)
    let loginBtn = CSButton(type: .bgWhite)
    let connectBtn = CSButton(type: .bgClear)
    let connectBtn2 = CSButton(type: .bgClear)
    let idField = CSTextField()
    let passField = CSTextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifView.loadGif(name: "first_bg")
        gifView.isUserInteractionEnabled = true
        gifView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gifViewTapped(_:)))) // 빈화면 클릭
        
        //회원가입 버튼
        regBtn.frame = CGRect(x: 39, y: 691, width: 300, height: 40);
        regBtn.setTitle("회원가입", for: UIControl.State.normal)
        regBtn.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 + 350);
        regBtn.addTarget(self, action: #selector(regBtnAction(_:)), for: .touchUpInside);
        self.view.addSubview(regBtn)
        
        //로그인 버튼
        loginBtn.frame = CGRect(x: 50, y: 100, width: 300, height: 40);
        loginBtn.setTitle("로그인", for: UIControl.State.normal)
        loginBtn.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 + 300);
        loginBtn.addTarget(self, action: #selector(loginBtnAction(_:)), for: .touchUpInside);
        self.view.addSubview(loginBtn)
        
        //접속 버튼 (아이디 체킹)
        connectBtn.frame = CGRect(x: 50, y: 100, width: 300, height: 40);
        connectBtn.setTitle("접속", for: UIControl.State.normal)
        connectBtn.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 + 500);
        connectBtn.addTarget(self, action: #selector(idCheckAction(_:)), for: .touchUpInside);
        self.view.addSubview(connectBtn)
        
        //접속 버튼
        connectBtn2.frame = CGRect(x: 50, y: 100, width: 300, height: 40);
        connectBtn2.setTitle("로그인", for: UIControl.State.normal)
        connectBtn2.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 + 500);
        connectBtn2.addTarget(self, action: #selector(connectAction(_:)), for: .touchUpInside);
        self.view.addSubview(connectBtn2)
        //아이디 필드
        idField.type = .id
        idField.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 + 500);
        self.view.addSubview(idField);
        
        //패스워드 필드
        passField.type = .password
        passField.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 + 500);
        self.view.addSubview(passField);
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true); // 화면 터치시 키보드 내림
    }
    
    @objc func loginBtnAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            self.idField.center.y = self.view.frame.height / 2 - 50;
            self.connectBtn.center.y = self.view.frame.height / 2;
        }, completion: nil)
        self.loginBtn.center.y = self.view.frame.height + 30; // 로그인 버튼 숨기기
        self.regBtn.center.y = self.view.frame.height + 30; // 회원가입 버튼 숨기기
        self.idField.becomeFirstResponder(); // 키보드 보이기
    }
    
    @objc func idCheckAction(_ sender: UIButton) {
        let param: Parameters = [
            "id" : self.idField.text!
        ]
        let alamo = Alamofire.request("http://35.194.119.42:8080/searchAccount", method: .post, parameters: param, encoding: URLEncoding.httpBody);
        
        alamo.responseString() { response in
            print("post=\(response.result.value!)");
            
            if response.result.value! == "1" {
                self.connectBtn.center.y = self.view.frame.height / 2 + 500;
                self.connectBtn2.center.y = self.view.frame.height / 2 + 40;
                self.passField.center.y = self.view.frame.height / 2 - 12;
                self.passField.becomeFirstResponder(); // 키보드 보이기
            } else {
                
            }
        }
    }
    
    @objc func connectAction(_ sender: UIButton) { //로그인
        let param: Parameters = [
            "id" : self.idField.text!,
            "password" : self.passField.text!
        ]
        let alamo = Alamofire.request("http://35.194.119.42:8080/login", method: .post, parameters: param, encoding: URLEncoding.httpBody);
        
        alamo.responseString() { response in
            print("connect post=\(response.result.value!)");
            
            //post 토큰 나누기
            let infoToken = response.result.value!;
            let tokenArr = infoToken.components(separatedBy: "&");
            var tokenString = Array<String>();
            var i : Int = 0;
            for _ in i..<tokenArr.count {
                tokenString.append(tokenArr[i]);
            }
            //유저정보 vo에 삽입
            //            let userinfo = UserInfoVO();
            let userinfo: UserInfoVO = UserInfoVO.sharedInstance
            
            if tokenArr[0] == "1" { // header가 1이라면
                userinfo.id = tokenArr[1]; // 아이디
                userinfo.name = tokenArr[2]; // 이름
                userinfo.phone = tokenArr[3]; // 휴대폰
                userinfo.grade = tokenArr[4]; // 직급
                let uvc = self.storyboard!.instantiateViewController(withIdentifier: "MainPage") // 1
                uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve // 2
                self.present(uvc, animated: true) // 3
                print("userinfo \(userinfo.name)");
            } else {
                self.alert("로그인에 실패하였습니다.");
                return;
            }
        }
    }
    
    @objc func regBtnAction(_ sender: UIButton) {
            self.regView.center = CGPoint(x: self.gifView.frame.size.width / 2, y: self.gifView.frame.size.height / 2 - 80);
            self.gifView.addSubview(self.regView)
    }
    
    @objc func gifViewTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: {
        self.idField.center.y = self.view.frame.height / 2 + 500
        self.passField.center.y = self.view.frame.height / 2 + 500
        self.connectBtn.center.y = self.view.frame.height / 2 + 500
        self.connectBtn2.center.y = self.view.frame.height / 2 + 500
        self.loginBtn.center.y = self.view.frame.height / 2 + 300
        self.regBtn.center.y = self.view.frame.height / 2 + 350
        }, completion: nil)
    }
}

