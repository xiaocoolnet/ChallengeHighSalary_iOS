//
//  ChChFindEmployerTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/6.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChFindEmployerTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImg: UIImageView!
    
    @IBOutlet weak var company_nameLab: UILabel!
    
    @IBOutlet weak var jobsCountBtn: UIButton!
    
    @IBOutlet weak var industry_financing_countLab: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
    var companyInfo:Company_infoDataModel? {
        didSet {
            self.logoImg.sd_setImage(with: URL(string: kImagePrefix+(companyInfo?.logo)!), placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
            self.company_nameLab.text = companyInfo?.company_name
            self.jobsCountBtn.setTitle("\((companyInfo?.jobs?.count ?? 0)!)", for: UIControlState())
            self.industry_financing_countLab.text = "\((companyInfo?.industry ?? "")!) | \((companyInfo?.financing ?? "")!) | \((companyInfo?.count ?? "")!)"
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
