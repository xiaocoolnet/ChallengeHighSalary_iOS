//
//  CHSChInterviewEvaHeaderTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChInterviewEvaHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstImgView: UIImageView!
    
    @IBOutlet weak var secImgView: UIImageView!
    
    @IBOutlet weak var thirdImgView: UIImageView!
    
    @IBOutlet weak var fourImgView: UIImageView!
    
    @IBOutlet weak var fiveImgView: UIImageView!
   
    @IBOutlet weak var companyLab: UILabel!
    
    @IBOutlet weak var interLab: UILabel!
    
    @IBOutlet weak var cultureLab: UILabel!
    
    var evaluateStartInfo:EvaluateStartData? {
        didSet {
            self.companyLab.text = evaluateStartInfo?.company
            self.interLab.text = evaluateStartInfo?.interviewer
            self.cultureLab.text = evaluateStartInfo?.description
            if evaluateStartInfo?.com_score == "1" {
                
                secImgView.image = UIImage.init(named: "ic-stargray")
                thirdImgView.image = UIImage.init(named: "ic-stargray")
                fourImgView.image = UIImage.init(named: "ic-stargray")
                fiveImgView.image = UIImage.init(named: "ic-stargray")
            }else if evaluateStartInfo?.com_score == "2"{
                
                thirdImgView.image = UIImage.init(named: "ic-stargray")
                fourImgView.image = UIImage.init(named: "ic-stargray")
                fiveImgView.image = UIImage.init(named: "ic-stargray")
            }else if evaluateStartInfo?.com_score == "3"{
                
                fourImgView.image = UIImage.init(named: "ic-stargray")
                fiveImgView.image = UIImage.init(named: "ic-stargray")
            }else if evaluateStartInfo?.com_score == "4"{
                fiveImgView.image = UIImage.init(named: "ic-stargray")
            }
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
