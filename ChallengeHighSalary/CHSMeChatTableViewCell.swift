//
//  CHSMeChatTableViewCell.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/11/18.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMeChatTableViewCell: UITableViewCell {

    // TODO: 模型不对
    var chatListData: ChatData? {
        didSet {
            let url = NSURL(string: kImagePrefix+(chatListData?.receive_face ?? "")!)
            headerImg.sd_setImage(with: url as URL!, placeholderImage: nil)
            
            let contentHeight = calculateHeight((chatListData?.content ?? "")!, size: 16, width: screenSize.width-8-50-8-8-50-8)
            
            chatContentLab.frame.size.height = contentHeight+8+8
            
            chatContentLab.text = chatListData?.content
        }
    }
    fileprivate let headerImg = UIImageView()
    fileprivate let chatContentLab = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headerImg.frame = CGRect(x: 8, y: 8, width: 50, height: 50)
        headerImg.layer.cornerRadius = 25
        headerImg.clipsToBounds = true
        self.contentView.addSubview(headerImg)
        
        chatContentLab.frame = CGRect(x: headerImg.frame.maxX + 8, y: 8, width: screenSize.width-8-50-8-8-50-8, height: 0)
        chatContentLab.numberOfLines = 0
        chatContentLab.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(chatContentLab)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
