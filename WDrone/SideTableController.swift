//
//  SideBarViewContorller.swift
//  SmartHospital
//
//  Created by 김도안 on 2018. 7. 25..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit
class SideTableController : UITableViewController {
    let userinfo: UserInfoVO = UserInfoVO.sharedInstance // 유저정보 싱글톤
    
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var logoutView: UIView!
    let nameLabel = UILabel();
    let accountLabel = UILabel();
    let profileImage = UIImageView();
    
    //메뉴 제목 배열
    let titles = [
        "마이페이지",
        "드론조작",
        "재고관리",
        "시설물관리",
        "설정"
    ]
    
    let icons = [
        UIImage(named: "interview"),
        UIImage(named: "drone"),
        UIImage(named: "box"),
        UIImage(named: "repair"),
        UIImage(named: "settings")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        logoutLabel.center = CGPoint(x: logoutView.frame.size.width / 2 - 50, y: logoutView.frame.size.height / 2);
        self.navigationController?.navigationBar.isHidden = true; // 네비게이션 바 숨김
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70));
        headerView.backgroundColor = UIColor.lightGray;
        self.tableView.tableHeaderView = headerView;
        
        //계정 정보를 표시할 레이블 객체 정의
        self.accountLabel.frame = CGRect(x: 80, y: 30, width: 100, height: 30);
        self.accountLabel.text = userinfo.id;
        self.accountLabel.textColor = UIColor.white;
        self.accountLabel.font = UIFont.boldSystemFont(ofSize: 11);
        self.accountLabel.backgroundColor = UIColor.clear;
        headerView.addSubview(self.accountLabel);
        //이름 정보를 표시할 레이블 객체 정의
        self.nameLabel.frame = CGRect(x: 80, y: 15, width: 100, height: 30);
        self.nameLabel.text = userinfo.name;
        self.nameLabel.textColor = UIColor.white;
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15);
        self.nameLabel.backgroundColor = UIColor.clear;
        headerView.addSubview(self.nameLabel);
        //이미지 정보
        let defaultProfile = UIImage(named: "account");
        self.profileImage.image = defaultProfile;
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50);
        //이미지를 둥글게
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2);
        self.profileImage.layer.borderWidth = 0;
        self.profileImage.layer.masksToBounds = true;
        view.addSubview(self.profileImage);
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //재사용 큐로부터 테이블 셀을 꺼내 온다.
        let id = "menucell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id);
        // 재사용 큐에 menucell키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다.
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: id);
        }
        
        // 타이틀에 매치
        cell?.textLabel?.text = self.titles[indexPath.row];
        cell?.imageView?.image = self.icons[indexPath.row];
        cell?.imageView?.frame = CGRect (x: 0, y: 0, width: 30, height: 30)
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14);
        cell?.textLabel?.font = UIFont.init(name: "BMJUA", size: 14);
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Mypage");
            self.present(uv!, animated: true) {
                self.revealViewController().revealToggle(self);
            }
        }
    }
}
