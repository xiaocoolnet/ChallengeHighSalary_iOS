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
            
            if chatListData?.send_uid == CHSUserInfo.currentUserInfo.userid {
                
                let url = NSURL(string: kImagePrefix+(chatListData?.send_face ?? "")!)
                headerImg.sd_setImage(with: url as URL!, placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
                
                headerImg.frame.origin.x = screenSize.width-8-headerImg.frame.size.width
                
                let contentHeight = calculateHeight((chatListData?.content ?? "")!, size: 16, width: screenSize.width-8-40-8-8-40-8)
                let contentWidth = calculateWidth((chatListData?.content ?? "")!, size: 16, height: contentHeight)
                chatContentLab.frame.origin.x = headerImg.frame.minX-8-(contentWidth+8+8)
                chatContentLab.frame.size = CGSize(width: contentWidth+8+8, height: contentHeight+8+8)
                
                chatContentLab.text = chatListData?.content
                chatContentLab.layer.cornerRadius = 8
                chatContentLab.layer.backgroundColor = UIColor.white.cgColor
                
                btn.frame = chatContentLab.frame

            }else{
                
                let url = NSURL(string: kImagePrefix+(chatListData?.receive_face ?? "")!)
                headerImg.sd_setImage(with: url as URL!, placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
                headerImg.frame.origin.x = 8

                
                let contentHeight = calculateHeight((chatListData?.content ?? "")!, size: 16, width: screenSize.width-8-40-8-8-40-8)
                let contentWidth = calculateWidth((chatListData?.content ?? "")!, size: 16, height: contentHeight)
                chatContentLab.frame.origin.x = headerImg.frame.maxX + 8
                chatContentLab.frame.size = CGSize(width: contentWidth+8+8, height: contentHeight+8+8)
                
                chatContentLab.text = chatListData?.content
                chatContentLab.layer.cornerRadius = 8
                chatContentLab.layer.backgroundColor = baseColor.cgColor
                
                btn.frame = chatContentLab.frame

            }
        }
    }
    fileprivate let headerImg = UIImageView()
    fileprivate let chatContentLab = UILabel()
    let btn = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headerImg.frame = CGRect(x: 8, y: 8, width: 40, height: 40)
        headerImg.layer.cornerRadius = 20
        headerImg.clipsToBounds = true
        self.contentView.addSubview(headerImg)
        
        chatContentLab.frame = CGRect(x: headerImg.frame.maxX + 8, y: 10, width: screenSize.width-8-40-8-8-40-8, height: 0)
        chatContentLab.numberOfLines = 0
        chatContentLab.font = UIFont.systemFont(ofSize: 16)
        chatContentLab.textAlignment = .center
        self.contentView.addSubview(chatContentLab)
        
        btn.frame = chatContentLab.frame
        btn.backgroundColor = UIColor.clear
        self.contentView.addSubview(btn)
        
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
