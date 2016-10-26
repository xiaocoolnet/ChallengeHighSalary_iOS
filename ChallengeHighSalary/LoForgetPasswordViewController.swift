//
//  LoForgetPasswordViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/9.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoForgetPasswordViewController: UIViewController, UITextFieldDelegate {

    let lightGrayColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
    
    // 电话号码输入框
    let telTF = UITextField()
    // 验证码输入框
    let checkCodeTF = UITextField()
    // 获取验证码 按钮
    let getCheckCodeBtn = UIButton()
    // 新密码输入框
    let newPwdTF = UITextField()
    // 确认密码输入框
    let surePwdTF = UITextField()
    
    //  倒计时功能
    var processHandle:TimerHandle?
    var finishHandle:TimerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getCheckCodeCountdown()
        
        self.setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "ic_clear"), forBarMetrics: .Compact)
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = lightGrayColor
        self.title = "忘记密码"
                
        let rootScrollView = TPKeyboardAvoidingScrollView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
        rootScrollView.bounces = false
        rootScrollView.contentSize = CGSizeMake(0, 0)
        rootScrollView.scrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        let bigBgImg = UIImageView(frame: self.view.bounds)
        bigBgImg.image = UIImage(named: "ic_登录背景_模糊")
        rootScrollView.addSubview(bigBgImg)
        
        // 输入背景视图
        let inputBgView = UIView(frame: CGRectMake(screenSize.width*0.1, kHeightScale*114, screenSize.width*0.8, kHeightScale*227))
        inputBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        rootScrollView.addSubview(inputBgView)
        
        let subHeight = (inputBgView.frame.size.height-3)/4.0
        
        // 电话前缀
        let telLab = UILabel(frame: CGRectMake(
            kHeightScale*12,
            0,
            kWidthScale*78,
            subHeight))
        telLab.textColor = UIColor.whiteColor()
        telLab.text = "+86"
        telLab.textAlignment = .Center
        inputBgView.addSubview(telLab)
        
        // 电话前缀右边虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(CGRectGetMaxX(telLab.frame), CGRectGetMinY(telLab.frame)+5), toPoint: CGPointMake(CGRectGetMaxX(telLab.frame), subHeight-5), lineWidth: 1)
        
        // 电话号码输入框
        telTF.frame = CGRectMake(CGRectGetMaxX(telLab.frame)+5, 0, inputBgView.frame.size.width-kWidthScale*174, subHeight)
        telTF.placeholder = "请输入手机号"
        telTF.keyboardType = .NumberPad
        telTF.returnKeyType = .Next
        telTF.delegate = self
        inputBgView.addSubview(telTF)
        
        // 获取验证码 按钮
        getCheckCodeBtn.frame = CGRectMake(inputBgView.frame.size.width-kWidthScale*(96+11), kHeightScale*10, kWidthScale*96, kHeightScale*36)
        getCheckCodeBtn.backgroundColor = UIColor.clearColor()
        getCheckCodeBtn.layer.cornerRadius = 8
        getCheckCodeBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        getCheckCodeBtn.setTitleColor(baseColor, forState: .Normal)
        getCheckCodeBtn.setTitle("获取验证码", forState: .Normal)
        getCheckCodeBtn.addTarget(self, action: #selector(getCheckCodeBtnClick), forControlEvents: .TouchUpInside)
        inputBgView.addSubview(getCheckCodeBtn)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(0, CGRectGetMaxY(telLab.frame)), toPoint: CGPointMake(inputBgView.frame.size.width, CGRectGetMaxY(telLab.frame)), lineWidth: 1)
        
        // 验证码 Label
        let checkCodeLab = UILabel(frame: CGRectMake(
            kHeightScale*12,
            CGRectGetMaxY(telLab.frame)+1,
            kWidthScale*78,
            subHeight))
        checkCodeLab.textColor = UIColor.whiteColor()
        checkCodeLab.text = "验证码"
        checkCodeLab.textAlignment = .Center
        inputBgView.addSubview(checkCodeLab)
        
        // 验证码输入框
        checkCodeTF.frame = CGRectMake(
            CGRectGetMaxX(telLab.frame)+5,
            CGRectGetMaxY(telLab.frame)+1,
            inputBgView.frame.size.width-kWidthScale*11-CGRectGetMaxX(telLab.frame)+5,
            subHeight)
        checkCodeTF.placeholder = "请输入验证码"
        checkCodeTF.keyboardType = .NumberPad
        checkCodeTF.returnKeyType = .Next
        checkCodeTF.delegate = self
        inputBgView.addSubview(checkCodeTF)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(0, CGRectGetMaxY(checkCodeLab.frame)), toPoint: CGPointMake(inputBgView.frame.size.width, CGRectGetMaxY(checkCodeLab.frame)), lineWidth: 1)
        
        // 新密码 Label
        let newPwdLab = UILabel(frame: CGRectMake(
            kHeightScale*12,
            CGRectGetMaxY(checkCodeLab.frame)+1,
            kWidthScale*78,
            subHeight))
        newPwdLab.textColor = UIColor.whiteColor()
        newPwdLab.text = "新密码"
        newPwdLab.textAlignment = .Center
        inputBgView.addSubview(newPwdLab)
        
        // 新密码输入框
        newPwdTF.frame = CGRectMake(
            CGRectGetMaxX(telLab.frame)+5,
            CGRectGetMaxY(checkCodeLab.frame)+1,
            inputBgView.frame.size.width-kWidthScale*11-CGRectGetMaxX(checkCodeLab.frame)+5,
            subHeight)
        newPwdTF.placeholder = "请输入新密码"
        newPwdTF.keyboardType = .Default
        newPwdTF.delegate = self
        inputBgView.addSubview(newPwdTF)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPointMake(0, CGRectGetMaxY(newPwdLab.frame)), toPoint: CGPointMake(inputBgView.frame.size.width, CGRectGetMaxY(newPwdLab.frame)), lineWidth: 1)
        
        // 确认密码 Label
        let surePwdLab = UILabel(frame: CGRectMake(
            kHeightScale*12,
            CGRectGetMaxY(newPwdLab.frame)+1,
            kWidthScale*78,
            subHeight))
        surePwdLab.textColor = UIColor.whiteColor()
        surePwdLab.text = "确认密码"
        surePwdLab.textAlignment = .Center
        inputBgView.addSubview(surePwdLab)
        
        // 确认密码输入框
        surePwdTF.frame = CGRectMake(
            CGRectGetMaxX(telLab.frame)+5,
            CGRectGetMaxY(newPwdLab.frame)+1,
            inputBgView.frame.size.width-kWidthScale*11-CGRectGetMaxX(checkCodeLab.frame)+5,
            subHeight)
        surePwdTF.placeholder = "请输入确认密码"
        surePwdTF.keyboardType = .Default
        surePwdTF.delegate = self
        inputBgView.addSubview(surePwdTF)
        
        // 完成按钮
        let doneBtn = UIButton(frame: CGRectMake(screenSize.width*0.1, CGRectGetMaxY(inputBgView.frame)+kHeightScale*49, screenSize.width*0.8, kHeightScale*42))
        doneBtn.backgroundColor = baseColor
        doneBtn.layer.cornerRadius = 8
        doneBtn.setTitle("完成", forState: .Normal)
        doneBtn.addTarget(self, action: #selector(doneBtnClick), forControlEvents: .TouchUpInside)
        rootScrollView.addSubview(doneBtn)

        // 用户协议 按钮
        let agreementBtn = UIButton(frame: CGRectMake(
            kWidthScale*275,
            CGRectGetMaxY(doneBtn.frame)+kHeightScale*15,
            kWidthScale*90,
            kHeightScale*42))
        agreementBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        agreementBtn.contentHorizontalAlignment = .Right
        agreementBtn.setTitle("用户协议", forState: .Normal)
        agreementBtn.setTitleColor(baseColor, forState: .Normal)
        agreementBtn.addTarget(self, action: #selector(agreementBtnClick), forControlEvents: .TouchUpInside)
        rootScrollView.addSubview(agreementBtn)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == telTF {
            checkCodeTF.becomeFirstResponder()
            if self.getCheckCodeBtn.userInteractionEnabled {
                getCheckCodeBtnClick()
            }
        }else if textField == checkCodeTF {
            newPwdTF.becomeFirstResponder()
        }else if textField == newPwdTF {
            surePwdTF.becomeFirstResponder()
        }else if textField == surePwdTF {
            doneBtnClick()
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
        TimeManager.shareManager.taskDic["forgetPassword"]?.FHandle = finishHandle
        TimeManager.shareManager.taskDic["forgetPassword"]?.PHandle = processHandle
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
        
        LoginNetUtil().checkphone(self.telTF.text!) { (success, response) in
            if success {
                
                LoginNetUtil().SendMobileCode(self.telTF.text!) { (success, response) in
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if success {
                            
                            // 验证码传到手机,执行倒计时操作
                            TimeManager.shareManager.begainTimerWithKey("forgetPassword", timeInterval: 30, process: self.processHandle!, finish: self.finishHandle!)
                            checkCodeHud.hide(true)
                            print("success")
                        }else{
                            
                            print("no success")
                            checkCodeHud.labelText = "获取验证码失败"
                            checkCodeHud.hide(true, afterDelay: 1)
                            
                            TimeManager.shareManager.taskDic["forgetPassword"]?.leftTime = 0
                            
                        }
                    })
                }
            }else{
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "手机号尚未注册"
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
        
    }
    
    // MAKE: 完成按钮点击事件
    func doneBtnClick() {
        
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
        }else if newPwdTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入新密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if surePwdTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入确认密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if newPwdTF.text! != surePwdTF.text! {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "两次密码输入不一致"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        LoginNetUtil().forgetpwd(self.telTF.text!, code: self.checkCodeTF.text!, password: self.newPwdTF.text!, handle: { (success, response) in
            
                dispatch_async(dispatch_get_main_queue(), {
                    if success {
                        
                        print("success")
                        
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelText = "密码修改成功"
                        checkCodeHud.hide(true, afterDelay: 1)
                        
                        let time: NSTimeInterval = 1.0
                        
                        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                        
                        dispatch_after(delay, dispatch_get_main_queue()) {
                            
                           self.navigationController?.popViewControllerAnimated(true)
                            
                        }
                        
                        checkCodeHud.hide(true)
                    }else{
                        
                        print("no success")
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelFont = UIFont.systemFontOfSize(14)
                        checkCodeHud.labelText = "修改密码失败"
                        checkCodeHud.detailsLabelFont = UIFont.systemFontOfSize(16)
                        checkCodeHud.detailsLabelText = response as! String
                        checkCodeHud.hide(true, afterDelay: 1)
                    }
                })
        })
    }
    
    // MAKE: 用户协议按钮点击事件
    func agreementBtnClick() {
        //        self.navigationController?.pushViewController(WeHomeViewController(), animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TimeManager.shareManager.taskDic["forgetPassword"]?.FHandle = nil
        TimeManager.shareManager.taskDic["forgetPassword"]?.PHandle = nil
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
