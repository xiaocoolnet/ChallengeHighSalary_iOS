//
//  CHSChCompanyPositionTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChCompanyPositionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var salaryLab: UILabel!
    
    @IBOutlet weak var cityLab: UILabel!
    
    @IBOutlet weak var experienceLab: UILabel!
    
    @IBOutlet weak var educationLab: UILabel!
    
    @IBOutlet weak var work_propertyLab: UILabel!
    
    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var realNameAndPositionLab: UILabel!
    
    var company_infoJob: JobInfoDataModel? {
        didSet {
            self.titleLab.text = company_infoJob!.title ?? ""
            self.salaryLab.text = "￥ "+(company_infoJob!.salary! ?? "")
            self.cityLab.text = company_infoJob!.city!.componentsSeparatedByString("-").last ?? ""
            self.experienceLab.text = company_infoJob!.experience ?? ""
            self.educationLab.text = company_infoJob!.education ?? ""
            self.work_propertyLab.text = company_infoJob?.work_property ?? ""
            self.logoImg.sd_setImageWithURL(NSURL(string: kImagePrefix+(company_infoJob?.photo ?? "")!), placeholderImage: nil)
            self.realNameAndPositionLab.text = (company_infoJob?.realname ?? "")!+" "+(company_infoJob?.myjob ?? "")!
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
