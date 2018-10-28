//
//  Util.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 15..
//  Copyright © 2018년 김도안. All rights reserved.
//

import Foundation
class Util : UIViewController {
    // MARK: 다이얼로그 관련 모듈
    // Alert Dialog
    class func showAlert(viewController: UIViewController?,title: String, msg: String, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)?){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        alertController.addAction(defaultAction)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
