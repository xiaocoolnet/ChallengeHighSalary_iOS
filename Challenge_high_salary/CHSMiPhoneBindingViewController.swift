//
//  CHSMiPhoneBindingViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiPhoneBindingViewController: UIViewController, UITextFieldDelegate {
    
    // 电话号码输入框
    let telTF = UITextField()
    // 获取验证码 按钮
    let getCheckCodeBtn = UIButton()
    // 验证码输入框
    let checkCodeTF = UITextField()
    
    //  倒计时功能
    var processHandle:TimerHandle?
    var finishHandle:TimerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.getCheckCodeCountdown()
        self.setSubviews()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "手机绑定"
        
        // MARK: 当前手机号 Label
        let currentPhoneLab = UILabel(frame: CGRectMake(0, kHeightScale*40+44+20, screenSize.width, kHeightScale*15))
        currentPhoneLab.textColor = UIColor(red: 156/255.0, green: 156/255.0, blue: 156/255.0, alpha: 1)
        currentPhoneLab.textAlignment = .Center
        currentPhoneLab.font = UIFont.systemFontOfSize(14)
        currentPhoneLab.text = "当前手机号"
        self.view.addSubview(currentPhoneLab)
        
        // MARK: 手机号
        let phoneLab = UILabel(frame: CGRectMake(0, kHeightScale*65+44+20, screenSize.width, kHeightScale*15))
        phoneLab.textColor = UIColor.blackColor()
        phoneLab.textAlignment = .Center
        phoneLab.font = UIFont.boldSystemFontOfSize(16)
        phoneLab.text = "159****2525"
        self.view.addSubview(phoneLab)
        
        // MARK: 新手机号 背景
        let newPhoneBgView = UIView(frame: CGRectMake(kWidthScale*10, kHeightScale*105+44+20, screenSize.width-kWidthScale*20, kHeightScale*50))
        newPhoneBgView.layer.cornerRadius = 6
        newPhoneBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(newPhoneBgView)
        
        // 电话前缀
        let telLab = UILabel(frame: CGRectMake(
            0,
            0,
            kWidthScale*58,
            newPhoneBgView.frame.size.height))
        telLab.text = "+86"
        telLab.textAlignment = .Center
        newPhoneBgView.addSubview(telLab)
        
        // 电话前缀右边虚线
        drawDashed(newPhoneBgView, color: UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1), fromPoint: CGPointMake(CGRectGetMaxX(telLab.frame), CGRectGetMinY(telLab.frame)+5), toPoint: CGPointMake(CGRectGetMaxX(telLab.frame), newPhoneBgView.frame.size.height-5), lineWidth: 1)
        
        // 电话号码输入框
        telTF.frame = CGRectMake(CGRectGetMaxX(telLab.frame)+5, 0, screenSize.width-kWidthScale*59, newPhoneBgView.frame.size.height)
        telTF.placeholder = "请输入手机号"
        telTF.keyboardType = .NumberPad
        telTF.returnKeyType = .Next
        telTF.delegate = self
        newPhoneBgView.addSubview(telTF)
        
        // MARK: 验证码 背景
        let checkCodeBgView = UIView(frame: CGRectMake(kWidthScale*10, CGRectGetMaxY(newPhoneBgView.frame)+kHeightScale*20, screenSize.width-kWidthScale*20, kHeightScale*50))
        checkCodeBgView.layer.cornerRadius = 6
        checkCodeBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(checkCodeBgView)
        
        // 验证码 ImageView
        let checkCodeImg = UIImageView(frame: CGRectMake(
            0,
            0,
            kWidthScale*58,
            newPhoneBgView.frame.size.height))
        checkCodeImg.backgroundColor = UIColor.grayColor()
        checkCodeBgView.addSubview(checkCodeImg)
        
        // 验证码右边虚线
        drawDashed(checkCodeBgView, color: UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1), fromPoint: CGPointMake(CGRectGetMaxX(checkCodeImg.frame), CGRectGetMinY(checkCodeImg.frame)+5), toPoint: CGPointMake(CGRectGetMaxX(checkCodeImg.frame), checkCodeBgView.frame.size.height-5), lineWidth: 1)
        
        // 验证码输入框
        checkCodeTF.frame = CGRectMake(
            CGRectGetMaxX(telLab.frame)+5,
            0,
            newPhoneBgView.frame.size.width-kWidthScale*110-CGRectGetMaxX(telLab.frame)+5,
            newPhoneBgView.frame.size.height)
        checkCodeTF.placeholder = "验证码"
        checkCodeTF.keyboardType = .NumberPad
        checkCodeTF.returnKeyType = .Done
        checkCodeTF.delegate = self
        checkCodeBgView.addSubview(checkCodeTF)
        
        // 获取验证码 按钮
        getCheckCodeBtn.frame = CGRectMake(
            newPhoneBgView.frame.size.width-kWidthScale*(96+14),
            kHeightScale*10,
            kWidthScale*96,
            kHeightScale*30)
        //        getCheckCodeBtn.backgroundColor = baseColor
        getCheckCodeBtn.layer.cornerRadius = 15
        getCheckCodeBtn.layer.borderColor = baseColor.CGColor
        getCheckCodeBtn.layer.borderWidth = 1
        getCheckCodeBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        getCheckCodeBtn.setTitleColor(baseColor, forState: .Normal)
        getCheckCodeBtn.setTitle("获取验证码", forState: .Normal)
        getCheckCodeBtn.addTarget(self, action: #selector(getCheckCodeBtnClick), forControlEvents: .TouchUpInside)
        checkCodeBgView.addSubview(getCheckCodeBtn)
        
        // 确认更换 按钮
        let sureChangeBtn = UIButton(frame: CGRectMake(kWidthScale*10, CGRectGetMaxY(checkCodeBgView.frame)+kHeightScale*96, screenSize.width-kWidthScale*20, kHeightScale*45))
        sureChangeBtn.backgroundColor = baseColor
        sureChangeBtn.layer.cornerRadius = 8
        sureChangeBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        sureChangeBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureChangeBtn.setTitle("确认更换", forState: .Normal)
        sureChangeBtn.addTarget(self, action: #selector(sureChangeBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(sureChangeBtn)
        
        // 提示 Label
        let tipLab = UILabel(frame: CGRectMake(
            0,
            CGRectGetMaxY(sureChangeBtn.frame)+kHeightScale*15,
            screenSize.width,
            kHeightScale*15))
        tipLab.font = UIFont.systemFontOfSize(12)
        tipLab.textColor = UIColor(red: 161/255.0, green: 161/255.0, blue: 161/255.0, alpha: 1)
        tipLab.text = "修改手机号后，可以使用新的手机号登录"
        tipLab.textAlignment = .Center
        self.view.addSubview(tipLab)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == telTF {
            checkCodeTF.becomeFirstResponder()
            if self.getCheckCodeBtn.userInteractionEnabled {
                getCheckCodeBtnClick()
            }
        }else if textField == checkCodeTF {
            sureChangeBtnClick()
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
        TimeManager.shareManager.taskDic["changePhone"]?.FHandle = finishHandle
        TimeManager.shareManager.taskDic["changePhone"]?.PHandle = processHandle
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
                    TimeManager.shareManager.taskDic["changePhone"]?.leftTime = 0
                    
                })
            }else{
                
                
                LoginNetUtil().SendMobileCode(self.telTF.text!) { (success, response) in
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        if success {
                            
                            // 手机号没注册,验证码传到手机,执行倒计时操作
                            TimeManager.shareManager.begainTimerWithKey("changePhone", timeInterval: 30, process: self.processHandle!, finish: self.finishHandle!)
                            checkCodeHud.hide(true)
                            print("success")
                        }else{
                            
                            print("no success")
                            checkCodeHud.mode = .Text
                            checkCodeHud.labelText = "获取验证码失败"
                            checkCodeHud.hide(true, afterDelay: 1)
                            
                            TimeManager.shareManager.taskDic["changePhone"]?.leftTime = 0
                            
                        }
                    })
                }
            }
        }
    }
    
    // MARK:- 确认更换按钮点击事件
    func sureChangeBtnClick() {
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断手机号是否为空
        if telTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if !isPhoneNumber(telTF.text!) {// 判断手机号格式是否正确
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "手机号输入有误"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if checkCodeTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入验证码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        CHSMiNetUtil().updateUserPhone(telTF.text!, code: checkCodeTF.text!) { (success, response) in
            if success {
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "更换手机号成功"
                checkCodeHud.hide(true, afterDelay: 1)
                
                let time: NSTimeInterval = 1.0
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                
                dispatch_after(delay, dispatch_get_main_queue()) {
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }else{
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = String(response!)
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TimeManager.shareManager.taskDic["changePhone"]?.FHandle = nil
        TimeManager.shareManager.taskDic["changePhone"]?.PHandle = nil
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
