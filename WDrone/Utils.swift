//
//  Utils.swift
//  SmartHospital
//
//  Created by 김도안 on 2018. 7. 23..
//  Copyright © 2018년 김도안. All rights reserved.
//

import Security
import Alamofire
import UIKit


extension UIViewController {
    func alert(_ message: String, completion: (()->Void)? = nil) {
        // 메인 스레드에서 실행되도록
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?() // completion 매개변수의 값이 nil이 아닐 때에만 실행되도록
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
}
