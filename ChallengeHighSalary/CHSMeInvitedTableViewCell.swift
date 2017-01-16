//
//  CHSMeInvitedTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/9.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMeInvitedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobLab: UILabel!
    @IBOutlet weak var clickBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var companyLab: UILabel!
    
    var InvitationInfo:InvitationData? {
        didSet {
            self.jobLab.text = "邀请您"+(InvitationInfo?.jobtype ?? "")!+"职位"
            self.imgView.sd_setImage(with: URL(string: kImagePrefix+(InvitationInfo?.photo ?? "")!), placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
            self.nameLab.text = InvitationInfo?.realname ?? ""
            self.companyLab.text = InvitationInfo?.address ?? ""
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
