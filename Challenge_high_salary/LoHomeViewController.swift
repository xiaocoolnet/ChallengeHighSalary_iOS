//
//  LoHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoHomeViewController: UIViewController, UITextFieldDelegate {

    let lightGrayColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    
    let telTF = UITextField()
    let pwdTF = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    func setSubviews() {
        self.view.backgroundColor = lightGrayColor
        self.title = "挑战高薪"
        
        // 输入背景视图
        let inputBgView = UIView(frame: CGRectMake(0, 64+screenSize.height*0.024, screenSize.width, screenSize.height*0.165))
        inputBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(inputBgView)
        
        // 电话前缀
        let telLab = UILabel(frame: CGRectMake(0, 0, inputBgView.frame.size.width*0.2, inputBgView.frame.size.height*0.5))
        telLab.text = "+86"
        telLab.textAlignment = .Center
        inputBgView.addSubview(telLab)
        
        // 电话前缀右边虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(CGRectGetMaxX(telLab.frame), CGRectGetMinY(telLab.frame)+5), toPoint: CGPointMake(CGRectGetMaxX(telLab.frame), CGRectGetMaxY(telLab.frame)-5), lineWidth: 1)
        
        // 电话号码输入框
        telTF.frame = CGRectMake(CGRectGetMaxX(telLab.frame)+5, telLab.frame.origin.y, CGRectGetMaxX(inputBgView.frame)-CGRectGetMaxX(telLab.frame)+5, telLab.frame.size.height)
        telTF.placeholder = "请输入手机号"
        telTF.text = CHSUserInfo.currentUserInfo.phoneNumber
        telTF.keyboardType = .NumberPad
        telTF.returnKeyType = .Next
        telTF.delegate = self
        inputBgView.addSubview(telTF)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(0, CGRectGetMaxY(telLab.frame)), toPoint: CGPointMake(CGRectGetMaxX(telTF.frame), CGRectGetMaxY(telLab.frame)), lineWidth: 1)
        
        // 密码 Label
        let pwdLab = UILabel(frame: CGRectMake(telLab.frame.origin.x, CGRectGetMaxY(telLab.frame)+1, telLab.frame.size.width, CGRectGetHeight(telLab.frame)-1))
        pwdLab.text = "密码"
        pwdLab.textAlignment = .Center
        inputBgView.addSubview(pwdLab)

        // 密码输入框
        pwdTF.frame = CGRectMake(CGRectGetMaxX(pwdLab.frame)+5, pwdLab.frame.origin.y, CGRectGetMaxX(inputBgView.frame)-CGRectGetMaxX(pwdLab.frame)+5, pwdLab.frame.size.height)
        pwdTF.placeholder = "请输入密码"
        pwdTF.keyboardType = .Default
        pwdTF.delegate = self
        inputBgView.addSubview(pwdTF)
        
        // 登录按钮
        let loginBtn = UIButton(frame: CGRectMake(0, CGRectGetMaxY(inputBgView.frame)+screenSize.height*0.075, screenSize.width*0.95, screenSize.height*0.0645))
        loginBtn.backgroundColor = baseColor
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("登录", forState: .Normal)
        loginBtn.addTarget(self, action: #selector(loginBtnClick), forControlEvents: .TouchUpInside)
        loginBtn.center.x = self.view.center.x
        self.view.addSubview(loginBtn)
        
        // 忘记密码按钮
        let forgetPwdBtn = UIButton(frame: CGRectMake(
            0,
            CGRectGetMaxY(loginBtn.frame)+screenSize.height*0.045,
            screenSize.width*0.176,
            screenSize.height*0.027))
        forgetPwdBtn.setTitle("忘记密码？", forState: .Normal)
        forgetPwdBtn.setTitleColor(baseColor, forState: .Normal)
        forgetPwdBtn.addTarget(self, action: #selector(forgetPwdBtnClick), forControlEvents: .TouchUpInside)
        forgetPwdBtn.center.x = self.view.center.x
        self.view.addSubview(forgetPwdBtn)
        forgetPwdBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // 没有账号 Label
        let noAccountLab = UILabel(frame: CGRectMake(
            screenSize.width*0.233,
            CGRectGetMaxY(forgetPwdBtn.frame)+screenSize.height*0.0335,
            screenSize.width*0.38,
            screenSize.height*0.027))
        noAccountLab.text = "您还没有挑战高薪账号？"
        noAccountLab.textAlignment = .Right
        noAccountLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        self.view.addSubview(noAccountLab)
        noAccountLab.adjustsFontSizeToFitWidth = true
        
        
        // 立即注册按钮
        let registerBtn = UIButton(frame: CGRectMake(
            CGRectGetMaxX(noAccountLab.frame),
            noAccountLab.frame.origin.y,
            screenSize.width*0.163,
            noAccountLab.frame.size.height))
        registerBtn.setTitle("立即注册", forState: .Normal)
        registerBtn.setTitleColor(baseColor, forState: .Normal)
        registerBtn.addTarget(self, action: #selector(registerPwdBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(registerBtn)
        registerBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // or Label
        let orLab = UILabel()
        orLab.text = "or"
        orLab.textAlignment = .Center
        orLab.sizeToFit()
        orLab.center.x = self.view.center.x
        orLab.frame.origin.y = screenSize.height*0.787
        orLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        self.view.addSubview(orLab)
        
        // or前 线
        let frontOrLine = UIView(frame: CGRectMake(
            orLab.frame.origin.x-screenSize.width*0.024-screenSize.width*0.4,
            0,
            screenSize.width*0.4,
            1))
        frontOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        frontOrLine.center.y = orLab.center.y
        self.view.addSubview(frontOrLine)
        
        // or后 线
        let behindOrLine = UIView(frame: CGRectMake(
            CGRectGetMaxX(orLab.frame)+screenSize.width*0.024,
            0,
            screenSize.width*0.4,
            1))
        behindOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        behindOrLine.center.y = orLab.center.y
        self.view.addSubview(behindOrLine)
        
        let threeNameArray = ["QQ","微信","新浪微博"]
        
        for i in 0 ... 2 {
            
            let threeLoginBtn = UIButton(frame: CGRectMake(CGFloat(i)*screenSize.width/3.0, CGRectGetMaxY(orLab.frame), screenSize.width/3.0, screenSize.height-CGRectGetMaxY(orLab.frame)))
//            threeLoginBtn.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
            self.view.addSubview(threeLoginBtn)
            
            let threeImg = UIImageView(frame: CGRectMake(
                threeLoginBtn.frame.size.width*0.3,
                threeLoginBtn.frame.size.height*0.2,
                threeLoginBtn.frame.size.width*0.4,
                threeLoginBtn.frame.size.width*0.4))
            threeImg.layer.cornerRadius = CGRectGetWidth(threeImg.frame)/2.0
            threeImg.backgroundColor = UIColor.grayColor()
            threeLoginBtn.addSubview(threeImg)
            
            let threeLab = UILabel(frame: CGRectMake(
                threeImg.frame.origin.x,
                CGRectGetMaxY(threeImg.frame)+screenSize.height*0.025,
                threeImg.frame.size.width,
                threeLoginBtn.frame.size.height-CGRectGetMaxY(threeImg.frame)-screenSize.height*0.05))
            threeLab.textColor = UIColor.darkGrayColor()
            threeLoginBtn.addSubview(threeLab)
            
            threeLab.textAlignment = .Center
            threeLab.text = threeNameArray[i]
            threeLab.font = UIFont.systemFontOfSize(12)
            threeLab.adjustsFontSizeToFitWidth = true
            
            
//            frame: CGRectMake(CGRectGetMinX(threeImg.frame), CGRectGetMaxY(threeImg.frame), CGRectGetWidth(threeImg.frame), )
        }

        autoLogin()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == telTF {
            pwdTF.becomeFirstResponder()
        }else if textField == pwdTF {
            loginBtnClick()
        }
        return true
    }
    
    // MARK: 登录按钮点击事件
    func loginBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断 手机号 密码 是否为空
        if telTF.text!.isEmpty {

            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if pwdTF.text!.isEmpty {

            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        LoginMethod(telTF.text!, password: pwdTF.text!, hud: checkCodeHud)
    }
    
    // MARK: 自动登录
    func autoLogin() {
        
        let logInfo = NSUserDefaults.standardUserDefaults().objectForKey(logInfo_key) as? Dictionary<String,String>
        
        if logInfo != nil {
            let usernameStr = logInfo![userName_key] ?? ""
            let passwordStr = logInfo![userPwd_key] ?? ""
            telTF.text = usernameStr
            pwdTF.text = passwordStr
            
            let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            checkCodeHud.removeFromSuperViewOnHide = true
            
            LoginMethod(telTF.text!, password: pwdTF.text!, hud: checkCodeHud)
        }
    }
    // MARK: 登录方法
    func LoginMethod(phone: String, password:String, hud: MBProgressHUD){
        
        LoginNetUtil().applogin(phone, password: password) { (success, response) in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if success {
                    
                    hud.hide(true)
                    NSUserDefaults.standardUserDefaults().setObject([userName_key:phone,userPwd_key:password], forKey: logInfo_key)

                    self.navigationController?.pushViewController(WeHomeViewController(), animated: true)
                }else{
                    
                    hud.mode = .Text
                    hud.labelFont = UIFont.systemFontOfSize(14)
                    hud.labelText = "登录失败"
                    hud.detailsLabelFont = UIFont.systemFontOfSize(16)
                    hud.detailsLabelText = response as! String
                    hud.hide(true, afterDelay: 1)
                }
            })
        }
        
    }
    
    // MARK: 忘记密码按钮点击事件
    func forgetPwdBtnClick() {
        self.navigationController?.pushViewController(LoForgetPasswordViewController(), animated: true)
    }
    
    // MARK: 立即注册按钮点击事件
    func registerPwdBtnClick() {
        self.navigationController?.pushViewController(LoRegisterViewController(), animated: true)
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
