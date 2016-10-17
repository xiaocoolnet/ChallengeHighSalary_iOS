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

    var jobs: [Company_infoJobsModel]?

    var count = ""

    var companyid = ""

    var industry = ""

    var logo = ""

    var company_web = ""
    

}

@objc(Company_infoJobsModel)
class Company_infoJobsModel: D3Model {

    var jobtype = ""

    var userid = ""

    var salary = ""

    var skill = ""

    var title = ""

    var jobid = ""

    var address = ""

    var city = ""

    var education = ""

    var description_job = ""

    var create_time = ""

    var experience = ""

}

