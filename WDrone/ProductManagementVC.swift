//
//  ProductManagementVC.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 29..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit
import Alamofire

class ProductManagementVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)));
        self.navigationItem.leftBarButtonItem = backBtn;
        
        let alamo = Alamofire.request("http://35.194.119.42:8080/productList", method: .get, encoding: URLEncoding.httpBody);
        
        alamo.responseString() { response in
            print("post=\(response.result.value!)");
            
            if response.result.value! != "nil" { // 들어온 값이 "nil"이 아니면 값을 받는다 // nil == 데이터없음
//                //post 토큰 나누기
//                let infoToken = response.result.value!;
//                let tokenArr = infoToken.components(separatedBy: "&");
//                var tokenString = Array<String>();
//                var i : Int = 0;
//                for _ in i..<tokenArr.count {
//                    tokenString.append(tokenArr[i]);
//                }
//                let productinfo = ProductInfoVO();
//
//                if tokenArr[0] == "1" { // header가 1이라면
//                    productinfo.id = tokenArr[1]; // 아이디
//                    productinfo.name = tokenArr[2]; // 이름
//                    productinfo.amount = Int(tokenArr[3])!; // 수량
//                    productinfo.input = tokenArr[4]; // 반입날짜
//                    productinfo.output = tokenArr[5]; // 반출날짜
//
//                    print(productinfo.id);
//                    // 앱 델리게이트 객체를 읽어온 다음, productlist 배열에 productinfo 객체를 추가한다.
//                    self.appDelegate.productlist.append(productinfo);
//                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.productlist_m.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.appDelegate.productlist_m[indexPath.row]
        let cellId = "productCellWithImage"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ProductCell_m
        
        cell.productId?.text = row.id;
        cell.productName?.text = row.name;
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: row.input)
        let date2 = formatter.date(from: row.output)
        cell.productInput?.text = formatter.string(from: date!)
        cell.productOutput?.text = formatter.string(from: date2!)
        
        return cell;
    }
    
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true);
    }
}
