//
//  LoRegisterViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/9.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoRegisterViewController: UIViewController, UITextFieldDelegate {

    
    let lightGrayColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    
    // 电话号码输入框
    let telTF = UITextField()
    // 获取验证码 按钮
    let getCheckCodeBtn = UIButton()
    // 验证码输入框
    let checkCodeTF = UITextField()
    // 新密码输入框
    let pwdTF = UITextField()
    
    //  倒计时功能
    var processHandle:TimerHandle?
    var finishHandle:TimerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1.验证码倒计时
        getCheckCodeCountdown()
        // 2.设置子视图
        self.setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = lightGrayColor
        self.title = "账号注册"
        
        // 输入背景视图
        let inputBgView = UIView(frame: CGRectMake(0, 64+kHeightScale*16, screenSize.width, kHeightScale*167))
        inputBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(inputBgView)
        
        let subHeight = (inputBgView.frame.size.height-2)/3.0
        
        // 电话前缀
        let telLab = UILabel(frame: CGRectMake(
            kHeightScale*12,
            0,
            kWidthScale*78,
            subHeight))
        telLab.text = "+86"
        telLab.textAlignment = .Left
        inputBgView.addSubview(telLab)
        
        // 电话前缀右边虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(CGRectGetMaxX(telLab.frame), CGRectGetMinY(telLab.frame)+5), toPoint: CGPointMake(CGRectGetMaxX(telLab.frame), subHeight-5), lineWidth: 1)
        
        // 电话号码输入框
        telTF.frame = CGRectMake(CGRectGetMaxX(telLab.frame)+5, 0, kWidthScale*185, subHeight)
        telTF.placeholder = "请输入手机号"
        telTF.keyboardType = .NumberPad
        telTF.returnKeyType = .Next
        telTF.delegate = self
        inputBgView.addSubview(telTF)
        
        // 获取验证码 按钮
        getCheckCodeBtn.frame = CGRectMake(
            screenSize.width-kWidthScale*(96+11),
            kHeightScale*10,
            kWidthScale*96,
            kHeightScale*36)
        getCheckCodeBtn.backgroundColor = baseColor
        getCheckCodeBtn.layer.cornerRadius = 8
        getCheckCodeBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        getCheckCodeBtn.setTitle("获取验证码", forState: .Normal)
        getCheckCodeBtn.addTarget(self, action: #selector(getCheckCodeBtnClick), forControlEvents: .TouchUpInside)
        inputBgView.addSubview(getCheckCodeBtn)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(0, CGRectGetMaxY(telLab.frame)), toPoint: CGPointMake(CGRectGetMaxX(telTF.frame), CGRectGetMaxY(telLab.frame)), lineWidth: 1)
        
        // 验证码 Label
        let checkCodeLab = UILabel(frame: CGRectMake(
            kHeightScale*12,
            CGRectGetMaxY(telLab.frame)+1,
            kWidthScale*78,
            subHeight))
        checkCodeLab.text = "验证码"
        checkCodeLab.textAlignment = .Left
        inputBgView.addSubview(checkCodeLab)
        
        // 验证码输入框
        checkCodeTF.frame = CGRectMake(
            CGRectGetMaxX(telLab.frame)+5,
            CGRectGetMaxY(telLab.frame)+1,
            screenSize.width-kWidthScale*11-CGRectGetMaxX(telLab.frame)+5,
            subHeight)
        checkCodeTF.placeholder = "请输入验证码"
        checkCodeTF.keyboardType = .NumberPad
        checkCodeTF.returnKeyType = .Next
        checkCodeTF.delegate = self
        inputBgView.addSubview(checkCodeTF)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(0, CGRectGetMaxY(checkCodeLab.frame)), toPoint: CGPointMake(CGRectGetMaxX(telTF.frame), CGRectGetMaxY(checkCodeLab.frame)), lineWidth: 1)
        
        // 新密码 Label
        let pwdLab = UILabel(frame: CGRectMake(
            kHeightScale*12,
            CGRectGetMaxY(checkCodeLab.frame)+1,
            kWidthScale*78,
            subHeight))
        pwdLab.text = "密码"
        pwdLab.textAlignment = .Left
        inputBgView.addSubview(pwdLab)
        
        // 新密码输入框
        pwdTF.frame = CGRectMake(
            CGRectGetMaxX(telLab.frame)+5,
            CGRectGetMaxY(checkCodeLab.frame)+1,
            screenSize.width-kWidthScale*11-CGRectGetMaxX(checkCodeLab.frame)+5,
            subHeight)
        pwdTF.placeholder = "请输入密码"
        pwdTF.keyboardType = .Default
        pwdTF.delegate = self
        inputBgView.addSubview(pwdTF)
        
        // 注册按钮
        let registerBtn = UIButton(frame: CGRectMake(kWidthScale*10, CGRectGetMaxY(inputBgView.frame)+kHeightScale*49, kWidthScale*355, kHeightScale*42))
        registerBtn.backgroundColor = baseColor
        registerBtn.layer.cornerRadius = 8
        registerBtn.setTitle("注册", forState: .Normal)
        registerBtn.addTarget(self, action: #selector(registerBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(registerBtn)
        
        // 用户协议 按钮
        let agreementBtn = UIButton(frame: CGRectMake(
            kWidthScale*275,
            CGRectGetMaxY(registerBtn.frame)+kHeightScale*15,
            kWidthScale*90,
            kHeightScale*42))
        agreementBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        agreementBtn.contentHorizontalAlignment = .Right
        agreementBtn.setTitle("用户协议", forState: .Normal)
        agreementBtn.setTitleColor(baseColor, forState: .Normal)
        agreementBtn.addTarget(self, action: #selector(agreementBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(agreementBtn)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == telTF {
            checkCodeTF.becomeFirstResponder()
            if self.getCheckCodeBtn.userInteractionEnabled {
                getCheckCodeBtnClick()
            }
        }else if textField == checkCodeTF {
            pwdTF.becomeFirstResponder()
        }else if textField == pwdTF {
            registerBtnClick()
        }
        return true
    }
    
    //  倒计时功能
    func getCheckCodeCountdown(){
        processHandle = {[unowned self] (timeInterVal) in
            dispatch_async(dispatch_get_main_queue(), {
                self.getCheckCodeBtn.userInteractionEnabled = false
                let btnTitle = String(timeInterVal) + "秒后重新获取"
                self.getCheckCodeBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
                
                self.getCheckCodeBtn.setTitle(btnTitle, forState: .Normal)
                
                
                
            })
        }
        
        finishHandle = {[unowned self] (timeInterVal) in
            dispatch_async(dispatch_get_main_queue(), {
                self.getCheckCodeBtn.userInteractionEnabled = true
                self.getCheckCodeBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
                self.getCheckCodeBtn.setTitle("重新获取验证码", forState: .Normal)
            })
        }
        TimeManager.shareManager.taskDic["register"]?.FHandle = finishHandle
        TimeManager.shareManager.taskDic["register"]?.PHandle = processHandle
    }
    
    // MARK: 获取验证码按钮点击事件
    func getCheckCodeBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断手机号是否为空
        if telTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if !isPhoneNumber(telTF.text!) {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "手机号输入有误"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        LoginNetUtil().checkphone(telTF.text!) { (success, response) in
            
            if success {
                
                dispatch_async(dispatch_get_main_queue(), { 
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = response as! String
                    checkCodeHud.hide(true, afterDelay: 1)
                    TimeManager.shareManager.taskDic["register"]?.leftTime = 0
                })
            }else{
                
                
                LoginNetUtil().SendMobileCode(self.telTF.text!) { (success, response) in
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        
                        if success {
                            
                            // 手机号没注册,验证码传到手机,执行倒计时操作
                            TimeManager.shareManager.begainTimerWithKey("register", timeInterval: 30, process: self.processHandle!, finish: self.finishHandle!)
                            checkCodeHud.hide(true)
                            print("success")
                        }else{
                            
                            print("no success")
                            checkCodeHud.mode = .Text
                            checkCodeHud.labelText = "获取验证码失败"
                            checkCodeHud.hide(true, afterDelay: 1)
                            
                            TimeManager.shareManager.taskDic["register"]?.leftTime = 0
                            
                        }
                    })
                }
            }
        }
        
    }
    
    // MAKE: 注册按钮点击事件
    func registerBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断手机号是否为空
        if telTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if !isPhoneNumber(telTF.text!) {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "手机号输入有误"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if checkCodeTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入验证码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if pwdTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        LoginNetUtil().AppRegister(telTF.text!, password: pwdTF.text!, code: checkCodeTF.text!) { (success, response) in
            if success {

                checkCodeHud.hide(false)
                
                self.navigationController?.pushViewController(LoReChooseIdentityViewController(), animated: true)
            }else{
                
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "注册失败"
                checkCodeHud.detailsLabelText = response as! String
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
    }
    
    // MAKE: 用户协议按钮点击事件
    func agreementBtnClick() {
        //        self.navigationController?.pushViewController(WeHomeViewController(), animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TimeManager.shareManager.taskDic["register"]?.FHandle = nil
        TimeManager.shareManager.taskDic["register"]?.PHandle = nil
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
