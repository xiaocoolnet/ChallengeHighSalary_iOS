//
//  FTModel.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/9.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

@objc(Company_infoModel)
class Company_infoModel: D3Model {

    var status = ""

    var data: Company_infoDataModel?
    
}

@objc(Company_infoDataModel)
class Company_infoDataModel: D3Model {
    
    var company_name = ""

    var financing = ""

    var jobs: [JobInfoDataModel]?

    var count = ""

    var companyid = ""

    var industry = ""

    var logo = ""

    var company_web = ""
    
   
    var company_score = ""
    
    var authentication = ""
    
    var distance = ""
    
    var creat_time = ""

    var com_introduce = ""
    
    var produte_info = ""

}

@objc(ResumeListModel)
class ResumeListModel: D3Model {
    
    var status = ""
    
    var data: [MyResumeData]?
    
    
}
class Jobs: NSObject {

    var experience: String?

    var jobtype: String?

    var realname: String?

    var userid: String?

    var skill: String?

    var salary: String?

    var title: String?

    var jobid: String?

    var address: String?

    var city: String?

    var education: String?

    var description_job: String?

    var create_time: String?

    var photo: String?

    var myjob: String?

}

