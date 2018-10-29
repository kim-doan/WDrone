//
//  ProductManagementVC.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 29..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit

class ProductManagementVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)));
        self.navigationItem.leftBarButtonItem = backBtn;
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
