//
//  CHSModel.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import HandyJSON

class MyResumeModel: HandyJSON {
    
    var status = ""
    
    var data: MyResumeData?
    
    required init() {}

}

class MyResumeData: HandyJSON {
    
    var education: [EducationModel]?
    
    var userid = ""
    
    var work: [WorkModel]?

    var weixin = ""

    var jobstate = ""
    
    var company = ""
    
    var advantage = ""

    var project: [ProjectModel]?

    var sex = ""
    
    var city = ""
    
    var realname = ""
    
    var position_type = ""
    
    var work_property = ""
    
    var myjob = ""
    
    var wantsalary = ""
    
    var usertype = ""
    
    var work_life = ""
    
    var email = ""
    
    var phone = ""
    
    var devicestate = ""
    
    var weibo = ""
    
    var photo = ""
    
    var password = ""
    
    var qq = ""
    
    var address = ""
    
    var categories = ""
    
    var resumes_id = ""
    
    required init() {}

}

class WorkModel: HandyJSON {
    
    var userid = ""
    
    var company_name = ""
    
    var jobtype = ""
    
    var skill = ""
    
    var content = ""
    
    var work_period = ""
    
    var create_time = ""
    
    var company_industry = ""
    
    required init() {}

}

class EducationModel: HandyJSON {
    
    var userid = ""
    
    var school = ""
    
    var major = ""
    
    var degree = ""
    
    var time = ""
    
    var experience = ""
    
    var create_time = ""
    
    required init() {}

}

class ProjectModel: HandyJSON {

    var description_project = ""

    var create_time = ""

    var userid = ""

    var start_time = ""

    var project_name = ""

    var end_time = ""

    required init() {}

}

class JobInfoModel: HandyJSON {
    
    var status: String?

    var data: [JobInfoDataModel]?
    
    required init() {}

}

class JobInfoDataModel: HandyJSON {

   
    var education: String?

    var userid: String?

    var title: String?

    var description_job: String?

    var company_web: String?

    var create_time: String?

    var company_name: String?

    var authentication: String?

    var company_score: String?

    var jobid: String?

    var count: String?

    var industry: String?

    var salary: String?

    var city: String?

    var realname: String?

    var work_property: String?

    var myjob: String?

    var welfare: String?

    var companyid: String?

    var distance: String?

    var financing: String?

    var skill: String?

    var logo: String?

    var experience: String?

    var jobtype: String?

    var address: String?
    
    var photo: String?
    
    required init() {}

}

class CompanyListModel: HandyJSON {
    
    var status = ""

    var data: [Company_infoDataModel]?
    
    required init() {}

}
