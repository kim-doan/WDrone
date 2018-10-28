//
//  ProductListVC.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 24..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit
import Alamofire

class ProductListVC: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var timer : Timer?
    override func viewDidLoad() {
        
//        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ProductListVC.reloadProduct), userInfo: nil, repeats: true) // 1초마다 갱신
        startTimer();
    }
    
    //테이블 뷰의 셀 개수를 결정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.productlist.count
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.appDelegate.productlist[indexPath.row]
        
        print(row.id)
        
        let cellId = "memoCellWithImage"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ProductCell
        
        cell.subject?.text = row.id
        cell.contents?.text = row.name
        cell.inputdate?.text = row.input
        cell.outputdate?.text = row.output
        
        return cell;
    }
    @objc func startTimer() {
        if timer == nil {
            timer =  Timer.scheduledTimer(
                timeInterval: TimeInterval(3.0),
                target      : self,
                selector    : #selector(ProductListVC.reloadProduct),
                userInfo    : nil,
                repeats     : true)
        }
    }

    @objc func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    @objc func reloadProduct() {
        let alamo = Alamofire.request("http://35.194.119.42:8080/product", method: .get, encoding: URLEncoding.httpBody);
        
        alamo.responseString() { response in
            print("post=\(response.result.value!)");
            
            if response.result.value! != "nil" { // 들어온 값이 "nil"이 아니면 값을 받는다 // nil == 데이터없음
                //post 토큰 나누기
                let infoToken = response.result.value!;
                let tokenArr = infoToken.components(separatedBy: "&");
                var tokenString = Array<String>();
                var i : Int = 0;
                for _ in i..<tokenArr.count {
                    tokenString.append(tokenArr[i]);
                }
                let productinfo = ProductInfoVO();
                
                if tokenArr[0] == "1" { // header가 1이라면
                    productinfo.id = tokenArr[1]; // 아이디
                    productinfo.name = tokenArr[2]; // 이름
                    productinfo.amount = Int(tokenArr[3])!; // 수량
                    productinfo.input = tokenArr[4]; // 반입날짜
                    productinfo.output = tokenArr[5]; // 반출날짜
                    
                    print(productinfo.id);
                    // 앱 델리게이트 객체를 읽어온 다음, productlist 배열에 productinfo 객체를 추가한다.
                    self.appDelegate.productlist.append(productinfo);
                }
            }
        }
        
        tableView.reloadData() // 테이블 갱신
    }
    @IBAction func nextpage(_ sender: Any) {
        self.performSegue(withIdentifier: "search_cancel", sender: self)
        stopTimer()
    }
    @IBAction func stopAction(_ sender: UIBarButtonItem) {
        let param: Parameters = [
            "stat" : "0"
        ]
        let alamo = Alamofire.request("http://35.194.119.42:8080/drone", method: .post, parameters: param, encoding: URLEncoding.httpBody);
        let alamo2 = Alamofire.request("http://35.194.119.42:8080/productreload", method: .get, encoding: URLEncoding.httpBody);

        alamo.responseString() { response in
            print("post=\(response.result.value!)");

            if response.result.value! == "0" {
                self.stopTimer()
                print("작동 성공");
            } else {
                print("작동 실패");
            }
        }
        
        alamo2.responseString() { response in
            print("post=\(response.result.value!)");
            
            if response.result.value! == "0" {
                self.stopTimer()
                print("작동 실패");
            } else {
                print("작동 성공");
            }
        }
    }
}
