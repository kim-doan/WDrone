//
//  UserInfoVO.swift
//  SmartHospital
//
//  Created by 김도안 on 2018. 7. 26..
//  Copyright © 2018년 김도안. All rights reserved.
//

import Foundation

class ProductInfoVO {
    static let sharedInstance = ProductInfoVO();
    
    private var _id : String = "";
    private var _name : String = "";
    private var _amount : Int = 0;
    private var _input : String = "";
    private var _output : String = "";
    
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
    
    var amount : Int {
        get {
            return _amount;
        }
        set(newVal) {
            _amount = newVal;
        }
    }
    
    var input : String {
        get {
            return _input;
        }
        set(newVal) {
            _input = newVal;
        }
    }
    
    var output : String {
        get {
            return _output;
        }
        set(newVal) {
            _output = newVal;
        }
    }
}
