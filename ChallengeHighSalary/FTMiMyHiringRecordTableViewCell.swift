//
//  FTMiMyHiringRecordTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyHiringRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var positionLab: UILabel!
    
    @IBOutlet weak var salaryLab: UILabel!
    
    @IBOutlet weak var addressLab: UILabel!
    
    @IBOutlet weak var expLab: UILabel!
    
    @IBOutlet weak var degreeLab: UILabel!
    
    @IBOutlet weak var workPropertyLab: UILabel!
    
    var jobInfoDataModel:JobInfoDataModel? {
        didSet {
            self.positionLab.text = jobInfoDataModel?.myjob
            self.salaryLab.text = "￥ \((jobInfoDataModel?.salary ?? "0")!)K"
            self.addressLab.text = jobInfoDataModel?.city?.components(separatedBy: "-").first
            self.expLab.text = jobInfoDataModel?.experience
            self.degreeLab.text = jobInfoDataModel?.education
            self.workPropertyLab.text = jobInfoDataModel?.work_property
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
