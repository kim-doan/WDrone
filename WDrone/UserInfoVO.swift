//
//  UserInfoVO.swift
//  SmartHospital
//
//  Created by 김도안 on 2018. 7. 26..
//  Copyright © 2018년 김도안. All rights reserved.
//

import Foundation

class UserInfoVO {
    static let sharedInstance = UserInfoVO();
    
    private var _id : String = "";
    private var _name : String = "";
    private var _phone : String = "";
    private var _grade : String = "";
    
    var id : String {
        get {
            return _id;
        }
        set(newVal) {
            _id = newVal;
        }
    }
    
    var name : String {
        get {
            return _name;
        }
        set(newVal) {
            _name = newVal;
        }
    }
    
    var phone : String {
        get {
            return _phone;
        }
        set(newVal) {
            _phone = newVal;
        }
    }
    
    var grade : String {
        get {
            return _grade;
        }
        set(newVal) {
            _grade = newVal;
        }
    }
}
