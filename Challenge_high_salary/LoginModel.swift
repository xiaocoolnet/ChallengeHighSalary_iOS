//
//  LoginModel.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/14.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

@objc(CheckphoneModel)
class CheckphoneModel: D3Model {
    
    var status: String = ""
    
    var data: String = ""
    
}

@objc(CheckCodeModel)
class CheckCodeModel: D3Model {

    var status: String = ""

    var data: CheckCodeData?
    
}

@objc(CheckCodeData)
class CheckCodeData: D3Model {

    var code: Int = 0

}

@objc(LoginModel)
class LoginModel: D3Model {
    
    
    var status: String = ""

    var data: LoginData?
    
    
}

@objc(LoginData)
class LoginData: D3Model {

    var userid: String = ""

    var score: String = ""

    var usertype: String = ""

    var phone: String = ""

    var event: String = ""

    var devicestate: String = ""

    var password: String = ""
    
    var sex: String = ""

    var realname: String = ""

    var work_life: String = ""

    var weixin: String = ""

    var company: String = ""

    var weibo: String = ""

    var city: String = ""

    var qq: String = ""

    var email: String = ""

    var photo: String = ""

    var myjob: String = ""
}



