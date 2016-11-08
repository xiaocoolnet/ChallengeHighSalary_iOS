//
//  LoginModel.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/14.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import HandyJSON

class CheckphoneModel: HandyJSON {
    
    var status: String = ""
    
    var data: String = ""
    
    required init() {}

}

class CheckCodeModel: HandyJSON {

    var status: String = ""

    var data: CheckCodeData?
    
    required init() {}

}

class CheckCodeData: HandyJSON {

    var code: Int = 0

    required init() {}

}

class LoginModel: HandyJSON {
    
    
    var status: String = ""

    var data: LoginData?
    
    required init() {}

}

class LoginData: HandyJSON {

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
    
    required init() {}

}



