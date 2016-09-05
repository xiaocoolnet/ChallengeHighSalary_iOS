//
//  LoHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoHomeViewController: UIViewController {

    let lightGrayColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    func setSubviews() {
        self.view.backgroundColor = lightGrayColor
        self.title = "挑战高薪"
        
        // 输入背景视图
        let inputBgView = UIView()
        inputBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(inputBgView)

        inputBgView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).inset(64+screenSize.height*0.024)
            make.left.equalTo(self.view).inset(0)
            make.right.equalTo(self.view).inset(0)
            make.height.equalTo(self.view).multipliedBy(0.165)
        }
        inputBgView.layoutIfNeeded()
        
        // 电话前缀
        let telLab = UILabel()
        telLab.text = "+86"
        telLab.textAlignment = .Center
        inputBgView.addSubview(telLab)
        
        telLab.snp_makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.width.equalTo(inputBgView).multipliedBy(0.2)
            make.height.equalTo(inputBgView).multipliedBy(0.5)
        }
        telLab.layoutIfNeeded()
        
        // 电话前缀右边虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(CGRectGetMaxX(telLab.frame), CGRectGetMinY(telLab.frame)+5), toPoint: CGPointMake(CGRectGetMaxX(telLab.frame), CGRectGetMaxY(telLab.frame)-5), lineWidth: 1)
        
        // 电话号码输入框
        let telTF = UITextField()
        telTF.placeholder = "请输入手机号"
        inputBgView.addSubview(telTF)
        
        telTF.snp_makeConstraints { (make) in
            make.left.equalTo(telLab.snp_right).offset(5)
            make.top.bottom.equalTo(telLab)
            make.right.equalTo(inputBgView)
        }
        telTF.layoutIfNeeded()
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(0, CGRectGetMaxY(telLab.frame)), toPoint: CGPointMake(CGRectGetMaxX(telTF.frame), CGRectGetMaxY(telLab.frame)), lineWidth: 1)
        
        // 密码 Label
        let pwdLab = UILabel()
        pwdLab.text = "密码"
        pwdLab.textAlignment = .Center
        inputBgView.addSubview(pwdLab)
        
        pwdLab.snp_makeConstraints { (make) in
            make.left.right.equalTo(telLab)
            make.top.equalTo(telLab.snp_bottom).offset(1)
            make.bottom.equalTo(inputBgView)
        }
        pwdLab.layoutIfNeeded()

        // 密码输入框
        let pwdTF = UITextField()
        pwdTF.placeholder = "请输入密码"
        inputBgView.addSubview(pwdTF)
        
        pwdTF.snp_makeConstraints { (make) in
            make.left.equalTo(pwdLab.snp_right).offset(5)
            make.top.bottom.equalTo(pwdLab)
            make.right.equalTo(inputBgView)
        }
        pwdTF.layoutIfNeeded()
        
        // 登录按钮
        let loginBtn = UIButton()
        loginBtn.backgroundColor = baseColor
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("登录", forState: .Normal)
        loginBtn.addTarget(self, action: #selector(loginBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(loginBtn)
        
        loginBtn.snp_makeConstraints { (make) in
            make.top.equalTo(inputBgView.snp_bottom).offset(screenSize.height*0.075)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.95)
            make.height.equalTo(self.view).multipliedBy(0.0645)
        }
        loginBtn.layoutIfNeeded()
        
        // 忘记密码按钮
        let forgetPwdBtn = UIButton()
        forgetPwdBtn.setTitle("忘记密码？", forState: .Normal)
        forgetPwdBtn.setTitleColor(baseColor, forState: .Normal)
        self.view.addSubview(forgetPwdBtn)
        
        forgetPwdBtn.snp_makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp_bottom).offset(screenSize.height*0.045)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.176)
            make.height.equalTo(self.view).multipliedBy(0.027)
        }
        forgetPwdBtn.layoutIfNeeded()
        forgetPwdBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // 没有账号 Label
        let noAccountLab = UILabel()
        noAccountLab.text = "您还没有挑战高薪账号？"
        noAccountLab.textAlignment = .Right
        noAccountLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
//        noAccountLab.backgroundColor = UIColor.redColor()
        self.view.addSubview(noAccountLab)
        
        noAccountLab.snp_makeConstraints { (make) in
            make.right.equalTo(self.view).multipliedBy(0.613)
            make.top.equalTo(forgetPwdBtn.snp_bottom).offset(screenSize.height*0.0335)
            make.width.equalTo(self.view).multipliedBy(0.380)
            make.height.equalTo(self.view).multipliedBy(0.027)
        }
        noAccountLab.layoutIfNeeded()
        noAccountLab.adjustsFontSizeToFitWidth = true
        
        
        // 立即注册按钮
        let registerBtn = UIButton()
        registerBtn.setTitle("立即注册", forState: .Normal)
        registerBtn.setTitleColor(baseColor, forState: .Normal)
//        registerBtn.backgroundColor = UIColor.greenColor()
        self.view.addSubview(registerBtn)
        
        registerBtn.snp_makeConstraints { (make) in
            make.top.equalTo(noAccountLab)
            make.left.equalTo(noAccountLab.snp_right)
            make.width.equalTo(self.view).multipliedBy(0.163)
            make.height.equalTo(noAccountLab)
        }
        registerBtn.layoutIfNeeded()
        registerBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // or Label
        let orLab = UILabel()
        orLab.text = "or"
        orLab.textAlignment = .Center
        orLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        //        noAccountLab.backgroundColor = UIColor.redColor()
        self.view.addSubview(orLab)
        
        orLab.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(screenSize.height*0.787)
        }
        orLab.layoutIfNeeded()
        orLab.adjustsFontSizeToFitWidth = true
        
        // or前 线
        let frontOrLine = UIView()
        frontOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        self.view.addSubview(frontOrLine)
        
        frontOrLine.snp_makeConstraints { (make) in
            make.right.equalTo(orLab.snp_left).offset(-screenSize.width*0.024)
            make.width.equalTo(self.view).multipliedBy(0.4)
            make.centerY.equalTo(orLab)
            make.height.equalTo(1)
        }
        frontOrLine.layoutIfNeeded()
        
        // or后 线
        let behindOrLine = UIView()
        behindOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        self.view.addSubview(behindOrLine)
        
        behindOrLine.snp_makeConstraints { (make) in
            make.left.equalTo(orLab.snp_right).offset(screenSize.width*0.024)
            make.width.equalTo(self.view).multipliedBy(0.4)
            make.centerY.equalTo(orLab)
            make.height.equalTo(1)
        }
        behindOrLine.layoutIfNeeded()
        
        let threeNameArray = ["QQ","微信","新浪微博"]
        
        for i in 0 ... 2 {
            
            let threeLoginBtn = UIButton(frame: CGRectMake(CGFloat(i)*screenSize.width/3.0, CGRectGetMaxY(orLab.frame), screenSize.width/3.0, screenSize.height-CGRectGetMaxY(orLab.frame)))
//            threeLoginBtn.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
            self.view.addSubview(threeLoginBtn)
            
            let threeImg = UIImageView()
            threeImg.backgroundColor = UIColor.lightGrayColor()
            threeLoginBtn.addSubview(threeImg)
            
            threeImg.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(threeLoginBtn).inset(threeLoginBtn.frame.size.height*0.2)
//                make.left.equalTo(threeLoginBtn).inset(threeLoginBtn.frame.size.width*0.24)
                make.centerX.equalTo(threeLoginBtn)
                make.width.height.equalTo(threeLoginBtn.snp_width).multipliedBy(0.4)
            })
            threeImg.layoutIfNeeded()
            threeImg.layer.cornerRadius = CGRectGetWidth(threeImg.frame)/2.0
            
            let threeLab = UILabel()
            threeLab.textColor = UIColor.darkGrayColor()
            threeLoginBtn.addSubview(threeLab)
            
            threeLab.snp_makeConstraints(closure: { (make) in
                make.left.width.equalTo(threeImg)
                make.top.equalTo(threeImg.snp_bottom).offset(screenSize.height*0.025)
                make.bottom.equalTo(self.view).inset(screenSize.height*0.025)
            })
            threeLab.layoutIfNeeded()
            
            threeLab.textAlignment = .Center
            threeLab.text = threeNameArray[i]
            threeLab.font = UIFont.systemFontOfSize(12)
            threeLab.adjustsFontSizeToFitWidth = true
            
            
//            frame: CGRectMake(CGRectGetMinX(threeImg.frame), CGRectGetMaxY(threeImg.frame), CGRectGetWidth(threeImg.frame), )
        }

    }
    
    // MAKE: 登录按钮点击事件
    func loginBtnClick() {
        self.navigationController?.pushViewController(WeHomeViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
