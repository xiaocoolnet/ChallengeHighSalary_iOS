//
//  LoHomeViewController.swift
//  ChallengeHighSalary
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    func setSubviews() {
//        self.view.backgroundColor = lightGrayColor
//        self.title = "挑战高薪"
        self.automaticallyAdjustsScrollViewInsets = false
        
        let rootScrollView = TPKeyboardAvoidingScrollView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        rootScrollView.bounces = false
        rootScrollView.contentSize = CGSizeMake(0, 0)
        rootScrollView.scrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        let bigBgImg = UIImageView(frame: self.view.bounds)
        bigBgImg.image = UIImage(named: "ic_登录背景")
        rootScrollView.addSubview(bigBgImg)
        
        let appNameImg = UIImageView(frame: CGRectMake(0, kHeightScale*107, screenSize.width, kHeightScale*41))
        appNameImg.contentMode = .ScaleAspectFit
        appNameImg.image = UIImage(named: "ic_appNameImg")
        rootScrollView.addSubview(appNameImg)
        
        // 电话号码 输入背景视图
        let telInputBgView = UIView(frame: CGRectMake(screenSize.width*0.1, kHeightScale*185, screenSize.width*0.8, screenSize.height*0.08))
        telInputBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        telInputBgView.layer.cornerRadius = 8
        rootScrollView.addSubview(telInputBgView)
        
        // 电话前缀
        let telLab = UILabel(frame: CGRectMake(0, 0, telInputBgView.frame.size.width*0.13, telInputBgView.frame.size.height))
        telLab.textColor = UIColor.whiteColor()
        telLab.text = "+86"
        telLab.textAlignment = .Right
        telInputBgView.addSubview(telLab)
        
        let telImg = UIImageView(frame: CGRectMake(CGRectGetMaxX(telLab.frame)+5, 0, telInputBgView.frame.size.width*0.03, telInputBgView.frame.size.height))
        telImg.image = UIImage(named: "ic_下拉箭头")
        telImg.contentMode = .ScaleAspectFit
        telInputBgView.addSubview(telImg)
        
        // 电话前缀右边虚线
        drawLine(
            telInputBgView,
            color: lightGrayColor,
            fromPoint:
            CGPointMake(telInputBgView.frame.size.width*0.2,
                telInputBgView.frame.size.height*0.2),
            toPoint:
            CGPointMake(telInputBgView.frame.size.width*0.2,
                telInputBgView.frame.size.height*0.8),
            lineWidth: 1,
            pattern: [1,0])
        
        // 电话号码输入框
        telTF.frame = CGRectMake(telInputBgView.frame.size.width*0.2+5, telImg.frame.origin.y, telInputBgView.frame.size.width*0.8-10, telImg.frame.size.height)
        telTF.textColor = UIColor.whiteColor()
        telTF.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        telTF.clearButtonMode = .WhileEditing
        telTF.text = NSUserDefaults.standardUserDefaults().stringForKey(userName_key)
        telTF.keyboardType = .NumberPad
        telTF.returnKeyType = .Next
        telTF.delegate = self
        telInputBgView.addSubview(telTF)
        
        // 输入背景视图
        let pwdInputBgView = UIView(frame: CGRectMake(screenSize.width*0.1, CGRectGetMaxY(telInputBgView.frame)+kHeightScale*20, screenSize.width*0.8, screenSize.height*0.08))
        pwdInputBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        pwdInputBgView.layer.cornerRadius = 8
        rootScrollView.addSubview(pwdInputBgView)
        
        // 密码 ImageView
        let pwdImg = UIImageView(frame: CGRectMake(0, CGRectGetHeight(pwdInputBgView.frame)*0.34, pwdInputBgView.frame.size.width*0.2, CGRectGetHeight(pwdInputBgView.frame)*0.33))
        pwdImg.image = UIImage(named: "ic_密码")
        pwdImg.contentMode = .ScaleAspectFit
        pwdInputBgView.addSubview(pwdImg)
        
        // 密码 右边虚线
        drawLine(
            pwdInputBgView,
            color: lightGrayColor,
            fromPoint:
            CGPointMake(CGRectGetMaxX(pwdImg.frame),
                pwdInputBgView.frame.size.height*0.2),
            toPoint:
            CGPointMake(CGRectGetMaxX(pwdImg.frame),
                pwdInputBgView.frame.size.height*0.8),
            lineWidth: 1,
            pattern: [1,0])

        // 密码输入框
        pwdTF.frame = CGRectMake(CGRectGetMaxX(pwdImg.frame)+5, 0, CGRectGetMaxX(pwdInputBgView.frame)-CGRectGetMaxX(pwdImg.frame)+5, pwdInputBgView.frame.size.height)
        pwdTF.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
        pwdTF.textColor = UIColor.whiteColor()
        pwdTF.keyboardType = .Default
        pwdTF.secureTextEntry = true
        pwdTF.delegate = self
        pwdInputBgView.addSubview(pwdTF)
        
        // 忘记密码按钮
        //CGRectGetMaxY(inputBgView.frame)+screenSize.height*0.075
        let forgetPwdBtn = UIButton(frame: CGRectMake(
            0,
            CGRectGetMaxY(pwdInputBgView.frame)+screenSize.height*0.026,
            screenSize.width*0.176,
            screenSize.height*0.027))
        forgetPwdBtn.setTitle("忘记密码？", forState: .Normal)
        forgetPwdBtn.setTitleColor(baseColor, forState: .Normal)
        forgetPwdBtn.addTarget(self, action: #selector(forgetPwdBtnClick), forControlEvents: .TouchUpInside)
        forgetPwdBtn.center.x = self.view.center.x
        rootScrollView.addSubview(forgetPwdBtn)
        forgetPwdBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // 没有账号 Label
        let noAccountLab = UILabel(frame: CGRectMake(
            screenSize.width*0.233,
            CGRectGetMaxY(forgetPwdBtn.frame)+screenSize.height*0.0335,
            0,
            0))
        noAccountLab.textColor = UIColor.whiteColor()
        noAccountLab.font = UIFont.systemFontOfSize(14)
        noAccountLab.text = "您还没有挑战高薪账号？"
        noAccountLab.textAlignment = .Right
//        noAccountLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        noAccountLab.sizeToFit()
        rootScrollView.addSubview(noAccountLab)
//        noAccountLab.adjustsFontSizeToFitWidth = true
        
        
        // 立即注册按钮
        let registerBtn = UIButton(frame: CGRectMake(
            CGRectGetMaxX(noAccountLab.frame),
            0,
            screenSize.width-CGRectGetMaxX(noAccountLab.frame),
            noAccountLab.frame.size.height))
        registerBtn.setTitle("立即注册", forState: .Normal)
        registerBtn.titleLabel!.font = UIFont.systemFontOfSize(14)
        registerBtn.setTitleColor(baseColor, forState: .Normal)
        registerBtn.addTarget(self, action: #selector(registerPwdBtnClick), forControlEvents: .TouchUpInside)
        registerBtn.sizeToFit()
        registerBtn.center.y = noAccountLab.center.y
        rootScrollView.addSubview(registerBtn)
//        registerBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // 登录按钮
        let loginBtn = UIButton(frame: CGRectMake(0, CGRectGetMaxY(registerBtn.frame)+screenSize.height*0.045, screenSize.width*0.8, screenSize.height*0.0645))
        loginBtn.backgroundColor = baseColor
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("登录", forState: .Normal)
        loginBtn.addTarget(self, action: #selector(loginBtnClick), forControlEvents: .TouchUpInside)
        loginBtn.center.x = self.view.center.x
        rootScrollView.addSubview(loginBtn)
        
        // or Label
        let orLab = UILabel()
        orLab.text = "or"
        orLab.textAlignment = .Center
        orLab.sizeToFit()
        orLab.center.x = self.view.center.x
        orLab.frame.origin.y = screenSize.height*0.787
        orLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        rootScrollView.addSubview(orLab)
        
        // or前 线
        let frontOrLine = UIView(frame: CGRectMake(
            orLab.frame.origin.x-screenSize.width*0.024-screenSize.width*0.4,
            0,
            screenSize.width*0.4,
            1))
        frontOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        frontOrLine.center.y = orLab.center.y
        rootScrollView.addSubview(frontOrLine)
        
        // or后 线
        let behindOrLine = UIView(frame: CGRectMake(
            CGRectGetMaxX(orLab.frame)+screenSize.width*0.024,
            0,
            screenSize.width*0.4,
            1))
        behindOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        behindOrLine.center.y = orLab.center.y
        rootScrollView.addSubview(behindOrLine)
        
        let threeNameArray = ["QQ","微信","新浪微博"]
        let threeImageNameArray = ["ic_qq","ic_weixin","ic_weibo"]
        
        for i in 0 ... 2 {
            
            let threeLoginBtn = UIButton(frame: CGRectMake(CGFloat(i)*screenSize.width/3.0, CGRectGetMaxY(orLab.frame), screenSize.width/3.0, screenSize.height-CGRectGetMaxY(orLab.frame)))
//            threeLoginBtn.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
            rootScrollView.addSubview(threeLoginBtn)
            
            let threeImg = UIImageView(frame: CGRectMake(
                threeLoginBtn.frame.size.width*0.3,
                threeLoginBtn.frame.size.height*0.2,
                threeLoginBtn.frame.size.width*0.4,
                threeLoginBtn.frame.size.width*0.4))
            threeImg.layer.cornerRadius = CGRectGetWidth(threeImg.frame)/2.0
//            threeImg.backgroundColor = UIColor.grayColor()
            threeImg.image = UIImage(named: threeImageNameArray[i])
            threeLoginBtn.addSubview(threeImg)
            
            let threeLab = UILabel(frame: CGRectMake(
                threeImg.frame.origin.x,
                CGRectGetMaxY(threeImg.frame)+screenSize.height*0.025,
                threeImg.frame.size.width,
                threeLoginBtn.frame.size.height-CGRectGetMaxY(threeImg.frame)-screenSize.height*0.05))
            threeLab.textColor = UIColor.whiteColor()
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
                    NSUserDefaults.standardUserDefaults().setValue(phone, forKey: userName_key)

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
