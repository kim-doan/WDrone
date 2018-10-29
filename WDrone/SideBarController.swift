//
//  SideBarController.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 18..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit
import Alamofire

class SideBarController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let userinfo: UserInfoVO = UserInfoVO.sharedInstance
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var alertButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var helloLabel: UILabel!
    
    var deviceLabel: UILabel!
    var deviceImage: UIImageView!
    var alertImage: UIImageView!
    var plusImage: UIImageView!
    var realView: UIView!
    var realView2: UIView!
    let scanBtn = CSButton(type: .bgBlack)
    let scanBtn2 = CSButton(type: .bgBlack)
    
    override func viewDidLoad() {
        super.viewDidLoad();
        sideMenus()
        
        self.helloLabel.text = userinfo.name + "님 안녕하세요.";
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        scanBtn.frame = CGRect(x: 0, y: 0, width: 300, height: 40);
        scanBtn.setTitle("검색 시작", for: UIControl.State.normal)
        scanBtn.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 + 320);
        scanBtn.addTarget(self, action: #selector(scanBtnAction(_:)), for: .touchUpInside);
        self.view.addSubview(scanBtn)
        CSLoader.instance.hideLoader()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell")!;
        
        switch indexPath.row {
        case 0:
            //테이블 뷰 공백위해 UIView 생성
            realView = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 210));
            realView.backgroundColor = UIColor.gray;
            realView.layer.cornerRadius = 8;
            realView.clipsToBounds = true;
            //UIView 안에 기기 이름 Label 추가
            self.deviceLabel = UILabel();
            self.deviceLabel.frame = CGRect(x: 20, y: 10, width: 100, height: 30);
            self.deviceLabel.font = UIFont.systemFont(ofSize: 14);
            self.deviceLabel.textColor = UIColor.white;
            realView.addSubview(deviceLabel);
            // 기기 이미지 추가
            let bg = UIImage(named: "drone2");
            self.deviceImage = UIImageView(image: bg);
            
            self.deviceImage.frame.size = CGSize(width: self.deviceImage.frame.size.width, height: self.deviceImage.frame.size.height);
            self.deviceImage.center = CGPoint(x: realView.frame.width / 2, y: 105);
            realView.addSubview(deviceImage);
            //상태 라벨 추가
            self.deviceLabel = UILabel();
            self.deviceLabel.frame = CGRect(x: 300, y: 10, width: 100, height: 30);
            self.deviceLabel.text = "정상";
            self.deviceLabel.font = UIFont.systemFont(ofSize: 14);
            self.deviceLabel.textColor = UIColor.white;
            realView.addSubview(deviceLabel);
            
            
            cell.backgroundColor = UIColor.clear;
            cell.addSubview(realView);
            
        case 1:
            //테이블 뷰 공백위해 UIView 생성
            realView2 = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 210));
            realView2.backgroundColor = UIColor.darkGray;
            realView2.layer.cornerRadius = 8;
            realView2.clipsToBounds = true;
            cell.addSubview(realView2);
            
            // 기기 이미지 추가
            let bg = UIImage(named: "add");
            self.plusImage = UIImageView(image: bg);
            
            self.plusImage.frame.size = CGSize(width: self.plusImage.frame.size.width, height: self.plusImage.frame.size.height);
            self.plusImage.center = CGPoint(x: realView.frame.width / 2, y: 105);
            realView2.addSubview(plusImage);
        default:
            ()
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220;
    }
    
    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return 375;
    }
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController()?.rightViewRevealWidth = 160
            
            alertButton.target = revealViewController()
            alertButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @objc func scanBtnAction(_ sender: Any) {
        let param: Parameters = [
            "stat" : "1"
        ]
        let alamo = Alamofire.request("http://35.194.119.42:8080/drone", method: .post, parameters: param, encoding: URLEncoding.httpBody);
        
        alamo.responseString() { response in
            print("post=\(response.result.value!)");
            
            if response.result.value! == "1" {
                print("작동 성공");
                let uvc = self.storyboard!.instantiateViewController(withIdentifier: "RFIDRead") // 1
                uvc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve // 2
                self.present(uvc, animated: true) // 3
            } else {
                print("작동 실패");
            }
        }
    }
}
