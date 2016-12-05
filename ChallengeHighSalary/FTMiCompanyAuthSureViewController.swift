//
//  FTMiCompanyAuthSureViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/12/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

enum companyAuthType: Int {
    case gongpai = 0
    case yingyezhizhao
    case Default
}

class FTMiCompanyAuthSureViewController: UIViewController {

    var authImage = UIImage()
    var tipAttrStr = NSMutableAttributedString()
    var tip2AttrStr = NSMutableAttributedString()

    var authType = companyAuthType.Default {
        didSet {
            switch authType {
            case companyAuthType.gongpai:
                
                let tipStr = NSString(string: "请确保您的姓名、公司全称、公司简称与您的工牌完全一致,否则审核将被驳回")
                
                tipAttrStr = NSMutableAttributedString(string: tipStr as String, attributes: [NSForegroundColorAttributeName:UIColor.darkGray,NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
                tipAttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(5, NSString(string: "姓名、公司全称、公司简称").length))
                
                let tip2Str = NSString(string: "您认证的材料：工牌")
                
                tip2AttrStr = NSMutableAttributedString(string: tip2Str as String, attributes: [NSForegroundColorAttributeName:UIColor.darkGray,NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
                tip2AttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(7, 2))
                
            case companyAuthType.yingyezhizhao:
                
                let tipStr = NSString(string: "请确保您的公司全称与营业执照完全一致且您的姓名与公司简称为真实信息,否则审核将被驳回")
                
                tipAttrStr = NSMutableAttributedString(string: tipStr as String, attributes: [NSForegroundColorAttributeName:UIColor.darkGray,NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
                tipAttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(5, 4))
                tipAttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(21, 2))
                tipAttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(24, 4))

                let tip2Str = NSString(string: "您认证的材料：营业执照")
                
                tip2AttrStr = NSMutableAttributedString(string: tip2Str as String, attributes: [NSForegroundColorAttributeName:UIColor.darkGray,NSFontAttributeName:UIFont.systemFont(ofSize: 14)])
                tip2AttrStr.addAttributes([NSForegroundColorAttributeName:baseColor], range: NSMakeRange(7, 4))

            default:
                break
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    // MARK:- popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.title = "提交证明材料"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        
        // 提示
        let tipLab = UILabel(frame: CGRect(x: 30, y: 64, width: screenSize.width-60, height: kHeightScale*80))
        tipLab.numberOfLines = 0
        tipLab.textAlignment = .center
        tipLab.attributedText = tipAttrStr
        self.view.addSubview(tipLab)
        
        // MARK: 个人信息
        let personalBgView = UIView(frame: CGRect(x: 15, y: tipLab.frame.maxY, width: screenSize.width-30, height: kHeightScale*125))
        personalBgView.layer.cornerRadius = 8
        personalBgView.backgroundColor = UIColor.white
        self.view.addSubview(personalBgView)
        
        let headerImg = UIImageView(frame: CGRect(x: 15, y: personalBgView.frame.height/2.0-25, width: 50, height: 50))
        headerImg.layer.cornerRadius = 25
        headerImg.clipsToBounds = true
        headerImg.sd_setImage(with: URL(string: kImagePrefix + CHSUserInfo.currentUserInfo.avatar)!, placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))
        personalBgView.addSubview(headerImg)
        
        let noteLab1 = UILabel(frame: CGRect(x: headerImg.frame.maxX+10, y: headerImg.frame.minY, width: personalBgView.frame.width-35-15-(headerImg.frame.maxX)-20, height: 25))
        noteLab1.font = UIFont.systemFont(ofSize: 16)
        noteLab1.textColor = UIColor.darkGray
        noteLab1.text = "\(CHSUserInfo.currentUserInfo.realName) | \(CHSUserInfo.currentUserInfo.myjob)"
        personalBgView.addSubview(noteLab1)
        
        let noteLab2 = UILabel(frame: CGRect(x: headerImg.frame.maxX+10, y: noteLab1.frame.maxY, width: personalBgView.frame.width-35-15-(headerImg.frame.maxX)-20, height: 25))
        noteLab2.font = UIFont.systemFont(ofSize: 15)
        noteLab2.textColor = UIColor.gray
        noteLab2.text = CHSUserInfo.currentUserInfo.company
        personalBgView.addSubview(noteLab2)
        
        let editBtn = UIButton(frame: CGRect(x: personalBgView.frame.width-35-15, y: personalBgView.frame.height/2.0-17.5, width: 35, height: 35))
        editBtn.layer.cornerRadius = 17.5
        editBtn.backgroundColor = baseColor
        editBtn.addTarget(self, action: #selector(editBtnClick), for: .touchUpInside)
        personalBgView.addSubview(editBtn)
        
        // 提示 2
        let tip2Lab = UILabel(frame: CGRect(x: 30, y: personalBgView.frame.maxY, width: screenSize.width-60, height: kHeightScale*60))
        tip2Lab.textAlignment = .center
        tip2Lab.attributedText = tip2AttrStr
        self.view.addSubview(tip2Lab)
        
        // MARK: 图片
        let pictureBgView = UIView(frame: CGRect(x: 30, y: tip2Lab.frame.maxY, width: screenSize.width-60, height: kHeightScale*240))
        pictureBgView.layer.cornerRadius = 8
        pictureBgView.backgroundColor = UIColor.white
        self.view.addSubview(pictureBgView)
        
        let authImg = UIImageView(frame: CGRect(x: 30, y: 30, width: pictureBgView.frame.width-60, height: pictureBgView.frame.height-60))
        authImg.contentMode = .scaleAspectFit
        authImg.clipsToBounds = true
        authImg.image = authImage
        pictureBgView.addSubview(authImg)
        
        let reBtn = UIButton(frame: CGRect(x: 0, y: 0, width: calculateWidth("重新上传", size: 15, height: 30)+16, height: 30))
        reBtn.backgroundColor = baseColor
        reBtn.layer.cornerRadius = 8
        reBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        reBtn.setTitle("重新上传", for: .normal)
        
        var subHeight:CGFloat = 0
        var subWidth:CGFloat = 0
        if authImage.size.width/authImage.size.height > authImg.frame.size.width/authImg.frame.size.height {
            
            subWidth = authImg.frame.size.width
            subHeight = subWidth*(authImage.size.height/authImage.size.width)

        }else{
            
            subHeight = authImg.frame.size.height
            subWidth = subHeight*(authImage.size.width/authImage.size.height)

        }
        
        reBtn.frame.origin = CGPoint(x: (pictureBgView.frame.width-subWidth)/2.0+subWidth-reBtn.frame.width*0.6, y: (pictureBgView.frame.height-subHeight)/2-reBtn.frame.height/2)
        pictureBgView.addSubview(reBtn)
        
        // MARK: 提交审核 按钮
        let sureBtn = UIButton(frame: CGRect(x: 0, y: pictureBgView.frame.maxY+20, width: screenSize.width*0.4, height: 30))
        sureBtn.backgroundColor = baseColor
        sureBtn.layer.cornerRadius = 15
        sureBtn.setTitle("提交审核", for: .normal)
        sureBtn.center.x = self.view.center.x
        self.view.addSubview(sureBtn)
        
        // 提示 3
        let tip3Lab = UILabel(frame: CGRect(x: 0, y: sureBtn.frame.maxY+8, width: 0, height: 0))
        tip3Lab.textColor = UIColor.lightGray
        tip3Lab.font = UIFont.systemFont(ofSize: 13)
        tip3Lab.text = "（你的信息仅用于认证，不对其他人公开）"
        tip3Lab.sizeToFit()
        tip3Lab.center.x = self.view.center.x
        self.view.addSubview(tip3Lab)
    }
    
    // MARK: - 编辑按钮点击事件
    func editBtnClick() {
        self.navigationController?.pushViewController(FTMiCompanyAuthInfoViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
