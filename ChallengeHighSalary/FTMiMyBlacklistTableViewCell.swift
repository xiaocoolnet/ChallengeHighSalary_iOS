//
//  FTMiMyBlacklistTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyBlacklistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var jobtypeLab: UILabel!
    
    @IBOutlet weak var cityLab: UILabel!
    
    @IBOutlet weak var work_lifeLab: UILabel!
    
    @IBOutlet weak var degreeLab: UILabel!
    
    @IBOutlet weak var work_propertyLab: UILabel!
    
    @IBOutlet weak var cancelBlacklistBtn: UIButton!
    
    var blackListResumeData:MyResumeData? {
        didSet {
            self.nameLab.text = blackListResumeData?.realname
            self.jobtypeLab.text = blackListResumeData?.work?.first?.jobtype
            self.cityLab.text = blackListResumeData?.city
            self.work_lifeLab.text = blackListResumeData?.work_life
            self.degreeLab.text = blackListResumeData?.education?.first?.degree
            self.work_propertyLab.text = blackListResumeData?.work_property
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cancelBlacklistBtn.layer.borderColor = baseColor.cgColor
        cancelBlacklistBtn.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
