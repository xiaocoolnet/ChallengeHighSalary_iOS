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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setSubviews() {
//        self.view.backgroundColor = lightGrayColor
//        self.title = "挑战高薪"
        self.automaticallyAdjustsScrollViewInsets = false
        
        let rootScrollView = TPKeyboardAvoidingScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        rootScrollView.bounces = false
        rootScrollView.contentSize = CGSize(width: 0, height: 0)
        rootScrollView.isScrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        let bigBgImg = UIImageView(frame: self.view.bounds)
        bigBgImg.image = UIImage(named: "ic_登录背景")
        rootScrollView.addSubview(bigBgImg)
        
        let appNameImg = UIImageView(frame: CGRect(x: 0, y: kHeightScale*107, width: screenSize.width, height: kHeightScale*41))
        appNameImg.contentMode = .scaleAspectFit
        appNameImg.image = UIImage(named: "ic_appNameImg")
        rootScrollView.addSubview(appNameImg)
        
        // 电话号码 输入背景视图
        let telInputBgView = UIView(frame: CGRect(x: screenSize.width*0.1, y: kHeightScale*185, width: screenSize.width*0.8, height: screenSize.height*0.08))
        telInputBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        telInputBgView.layer.cornerRadius = 8
        rootScrollView.addSubview(telInputBgView)
        
        // 电话前缀
        let telLab = UILabel(frame: CGRect(x: 0, y: 0, width: telInputBgView.frame.size.width*0.13, height: telInputBgView.frame.size.height))
        telLab.textColor = UIColor.white
        telLab.text = "+86"
        telLab.textAlignment = .right
        telInputBgView.addSubview(telLab)
        
        let telImg = UIImageView(frame: CGRect(x: telLab.frame.maxX+5, y: 0, width: telInputBgView.frame.size.width*0.03, height: telInputBgView.frame.size.height))
        telImg.image = UIImage(named: "ic_下拉箭头")
        telImg.contentMode = .scaleAspectFit
        telInputBgView.addSubview(telImg)
        
        // 电话前缀右边虚线
        drawLine(
            telInputBgView,
            color: lightGrayColor,
            fromPoint:
            CGPoint(x: telInputBgView.frame.size.width*0.2,
                y: telInputBgView.frame.size.height*0.2),
            toPoint:
            CGPoint(x: telInputBgView.frame.size.width*0.2,
                y: telInputBgView.frame.size.height*0.8),
            lineWidth: 1,
            pattern: [1,0])
        
        // 电话号码输入框
        telTF.frame = CGRect(x: telInputBgView.frame.size.width*0.2+5, y: telImg.frame.origin.y, width: telInputBgView.frame.size.width*0.8-10, height: telImg.frame.size.height)
        telTF.textColor = UIColor.white
        telTF.attributedPlaceholder = NSAttributedString(string: "请输入手机号", attributes: [NSForegroundColorAttributeName:UIColor.white])
        telTF.clearButtonMode = .whileEditing
        telTF.text = UserDefaults.standard.string(forKey: userName_key)
        telTF.keyboardType = .numberPad
        telTF.returnKeyType = .next
        telTF.delegate = self
        telInputBgView.addSubview(telTF)
        
        // 输入背景视图
        let pwdInputBgView = UIView(frame: CGRect(x: screenSize.width*0.1, y: telInputBgView.frame.maxY+kHeightScale*20, width: screenSize.width*0.8, height: screenSize.height*0.08))
        pwdInputBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        pwdInputBgView.layer.cornerRadius = 8
        rootScrollView.addSubview(pwdInputBgView)
        
        // 密码 ImageView
        let pwdImg = UIImageView(frame: CGRect(x: 0, y: pwdInputBgView.frame.height*0.34, width: pwdInputBgView.frame.size.width*0.2, height: pwdInputBgView.frame.height*0.33))
        pwdImg.image = UIImage(named: "ic_密码")
        pwdImg.contentMode = .scaleAspectFit
        pwdInputBgView.addSubview(pwdImg)
        
        // 密码 右边虚线
        drawLine(
            pwdInputBgView,
            color: lightGrayColor,
            fromPoint:
            CGPoint(x: pwdImg.frame.maxX,
                y: pwdInputBgView.frame.size.height*0.2),
            toPoint:
            CGPoint(x: pwdImg.frame.maxX,
                y: pwdInputBgView.frame.size.height*0.8),
            lineWidth: 1,
            pattern: [1,0])

        // 密码输入框
        pwdTF.frame = CGRect(x: pwdImg.frame.maxX+5, y: 0, width: pwdInputBgView.frame.maxX-pwdImg.frame.maxX+5, height: pwdInputBgView.frame.size.height)
        pwdTF.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [NSForegroundColorAttributeName:UIColor.white])
        pwdTF.textColor = UIColor.white
        pwdTF.keyboardType = .default
        pwdTF.isSecureTextEntry = true
        pwdTF.delegate = self
        pwdInputBgView.addSubview(pwdTF)
        
        // 忘记密码按钮
        //CGRectGetMaxY(inputBgView.frame)+screenSize.height*0.075
        let forgetPwdBtn = UIButton(frame: CGRect(
            x: 0,
            y: pwdInputBgView.frame.maxY+screenSize.height*0.026,
            width: screenSize.width*0.176,
            height: screenSize.height*0.027))
        forgetPwdBtn.setTitle("忘记密码？", for: UIControlState())
        forgetPwdBtn.setTitleColor(baseColor, for: UIControlState())
        forgetPwdBtn.addTarget(self, action: #selector(forgetPwdBtnClick), for: .touchUpInside)
        forgetPwdBtn.center.x = self.view.center.x
        rootScrollView.addSubview(forgetPwdBtn)
        forgetPwdBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // 没有账号 Label
        let noAccountLab = UILabel(frame: CGRect(
            x: screenSize.width*0.233,
            y: forgetPwdBtn.frame.maxY+screenSize.height*0.0335,
            width: 0,
            height: 0))
        noAccountLab.textColor = UIColor.white
        noAccountLab.font = UIFont.systemFont(ofSize: 14)
        noAccountLab.text = "您还没有挑战高薪账号？"
        noAccountLab.textAlignment = .right
//        noAccountLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        noAccountLab.sizeToFit()
        rootScrollView.addSubview(noAccountLab)
//        noAccountLab.adjustsFontSizeToFitWidth = true
        
        
        // 立即注册按钮
        let registerBtn = UIButton(frame: CGRect(
            x: noAccountLab.frame.maxX,
            y: 0,
            width: screenSize.width-noAccountLab.frame.maxX,
            height: noAccountLab.frame.size.height))
        registerBtn.setTitle("立即注册", for: UIControlState())
        registerBtn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        registerBtn.setTitleColor(baseColor, for: UIControlState())
        registerBtn.addTarget(self, action: #selector(registerPwdBtnClick), for: .touchUpInside)
        registerBtn.sizeToFit()
        registerBtn.center.y = noAccountLab.center.y
        rootScrollView.addSubview(registerBtn)
//        registerBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // 登录按钮
        let loginBtn = UIButton(frame: CGRect(x: 0, y: registerBtn.frame.maxY+screenSize.height*0.045, width: screenSize.width*0.8, height: screenSize.height*0.0645))
        loginBtn.backgroundColor = baseColor
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("登录", for: UIControlState())
        loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        loginBtn.center.x = self.view.center.x
        rootScrollView.addSubview(loginBtn)
        
        // or Label
        let orLab = UILabel()
        orLab.text = "or"
        orLab.textAlignment = .center
        orLab.sizeToFit()
        orLab.center.x = self.view.center.x
        orLab.frame.origin.y = screenSize.height*0.787
        orLab.textColor = UIColor(red: 152/255.0, green: 151/255.0, blue: 152/255.0, alpha: 1)
        rootScrollView.addSubview(orLab)
        
        // or前 线
        let frontOrLine = UIView(frame: CGRect(
            x: orLab.frame.origin.x-screenSize.width*0.024-screenSize.width*0.4,
            y: 0,
            width: screenSize.width*0.4,
            height: 1))
        frontOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        frontOrLine.center.y = orLab.center.y
        rootScrollView.addSubview(frontOrLine)
        
        // or后 线
        let behindOrLine = UIView(frame: CGRect(
            x: orLab.frame.maxX+screenSize.width*0.024,
            y: 0,
            width: screenSize.width*0.4,
            height: 1))
        behindOrLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
        behindOrLine.center.y = orLab.center.y
        rootScrollView.addSubview(behindOrLine)
        
        let threeNameArray = ["QQ","微信","新浪微博"]
        let threeImageNameArray = ["ic_qq","ic_weixin","ic_weibo"]
        
        for i in 0 ... 2 {
            
            let threeLoginBtn = UIButton(frame: CGRect(x: CGFloat(i)*screenSize.width/3.0, y: orLab.frame.maxY, width: screenSize.width/3.0, height: screenSize.height-orLab.frame.maxY))
//            threeLoginBtn.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
            rootScrollView.addSubview(threeLoginBtn)
            
            let threeImg = UIImageView(frame: CGRect(
                x: threeLoginBtn.frame.size.width*0.3,
                y: threeLoginBtn.frame.size.height*0.2,
                width: threeLoginBtn.frame.size.width*0.4,
                height: threeLoginBtn.frame.size.width*0.4))
            threeImg.layer.cornerRadius = threeImg.frame.width/2.0
//            threeImg.backgroundColor = UIColor.grayColor()
            threeImg.image = UIImage(named: threeImageNameArray[i])
            threeLoginBtn.addSubview(threeImg)
            
            let threeLab = UILabel(frame: CGRect(
                x: threeImg.frame.origin.x,
                y: threeImg.frame.maxY+screenSize.height*0.025,
                width: threeImg.frame.size.width,
                height: threeLoginBtn.frame.size.height-threeImg.frame.maxY-screenSize.height*0.05))
            threeLab.textColor = UIColor.white
            threeLoginBtn.addSubview(threeLab)
            
            threeLab.textAlignment = .center
            threeLab.text = threeNameArray[i]
            threeLab.font = UIFont.systemFont(ofSize: 12)
            threeLab.adjustsFontSizeToFitWidth = true
            
            
//            frame: CGRectMake(CGRectGetMinX(threeImg.frame), CGRectGetMaxY(threeImg.frame), CGRectGetWidth(threeImg.frame), )
        }

        autoLogin()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == telTF {
            pwdTF.becomeFirstResponder()
        }else if textField == pwdTF {
            loginBtnClick()
        }
        return true
    }
    
    // MARK: 登录按钮点击事件
    func loginBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断 手机号 密码 是否为空
        if telTF.text!.isEmpty {

            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if pwdTF.text!.isEmpty {

            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        LoginMethod(telTF.text!, password: pwdTF.text!, hud: checkCodeHud)
    }
    
    // MARK: 自动登录
    func autoLogin() {
        
        let logInfo = UserDefaults.standard.object(forKey: logInfo_key) as? Dictionary<String,String>
        
        if logInfo != nil {
            let usernameStr = logInfo![userName_key]
            let passwordStr = logInfo![userPwd_key]
            telTF.text = usernameStr
            pwdTF.text = passwordStr
            
            let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
            checkCodeHud.removeFromSuperViewOnHide = true
            
            LoginMethod(telTF.text!, password: pwdTF.text!, hud: checkCodeHud)
        }
    }
    // MARK: 登录方法
    func LoginMethod(_ phone: String, password:String, hud: MBProgressHUD){
        
        
        
        LoginNetUtil().applogin(phone, password: password) { (success, response) in
            
            DispatchQueue.main.async(execute: {
                
                if success {
                    
                    hud.hide(true)
                    UserDefaults.standard.set([userName_key:phone,userPwd_key:password], forKey: logInfo_key)
                    UserDefaults.standard.setValue(phone, forKey: userName_key)

                    self.navigationController?.pushViewController(WeHomeViewController(), animated: true)
                }else{
                    
                    hud.mode = .text
                    hud.labelFont = UIFont.systemFont(ofSize: 14)
                    hud.labelText = "登录失败"
                    hud.detailsLabelFont = UIFont.systemFont(ofSize: 16)
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
