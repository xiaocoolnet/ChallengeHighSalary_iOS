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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "ic_clear"), for: .default)
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = lightGrayColor
        self.title = "账号注册"
                
        let rootScrollView = TPKeyboardAvoidingScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        rootScrollView.bounces = false
        rootScrollView.contentSize = CGSize(width: 0, height: 0)
        rootScrollView.isScrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        let bigBgImg = UIImageView(frame: self.view.bounds)
        bigBgImg.image = UIImage(named: "ic_登录背景_模糊")
        rootScrollView.addSubview(bigBgImg)
        
        // 输入背景视图
        let inputBgView = UIView(frame: CGRect(x: 0, y: kHeightScale*114, width: screenSize.width, height: kHeightScale*167))
        inputBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        rootScrollView.addSubview(inputBgView)
        
        let subHeight = (inputBgView.frame.size.height-2)/3.0
        
        // 电话前缀
        let telLab = UILabel(frame: CGRect(
            x: kHeightScale*12,
            y: 0,
            width: kWidthScale*78,
            height: subHeight))
        telLab.textColor = UIColor.white
        telLab.text = "+86"
        telLab.textAlignment = .left
        inputBgView.addSubview(telLab)
        
        // 电话前缀右边虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPoint(x: telLab.frame.maxX, y: telLab.frame.minY+5), toPoint: CGPoint(x: telLab.frame.maxX, y: subHeight-5), lineWidth: 1)
        
        // 电话号码输入框
        telTF.frame = CGRect(x: telLab.frame.maxX+5, y: 0, width: kWidthScale*185, height: subHeight)
        telTF.placeholder = "请输入手机号"
        telTF.keyboardType = .numberPad
        telTF.returnKeyType = .next
        telTF.delegate = self
        inputBgView.addSubview(telTF)
        
        // 获取验证码 按钮
        getCheckCodeBtn.frame = CGRect(
            x: screenSize.width-kWidthScale*(96+11),
            y: kHeightScale*10,
            width: kWidthScale*96,
            height: kHeightScale*36)
        getCheckCodeBtn.backgroundColor = UIColor.clear
        getCheckCodeBtn.layer.cornerRadius = 8
        getCheckCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        getCheckCodeBtn.setTitleColor(baseColor, for: UIControlState())
        getCheckCodeBtn.setTitle("获取验证码", for: UIControlState())
        getCheckCodeBtn.addTarget(self, action: #selector(getCheckCodeBtnClick), for: .touchUpInside)
        inputBgView.addSubview(getCheckCodeBtn)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPoint(x: 0, y: telLab.frame.maxY), toPoint: CGPoint(x: screenSize.width, y: telLab.frame.maxY), lineWidth: 1)
        
        // 验证码 Label
        let checkCodeLab = UILabel(frame: CGRect(
            x: kHeightScale*12,
            y: telLab.frame.maxY+1,
            width: kWidthScale*78,
            height: subHeight))
        checkCodeLab.textColor = UIColor.white
        checkCodeLab.text = "验证码"
        checkCodeLab.textAlignment = .left
        inputBgView.addSubview(checkCodeLab)
        
        // 验证码输入框
        checkCodeTF.frame = CGRect(
            x: telLab.frame.maxX+5,
            y: telLab.frame.maxY+1,
            width: screenSize.width-kWidthScale*11-telLab.frame.maxX+5,
            height: subHeight)
        checkCodeTF.placeholder = "请输入验证码"
        checkCodeTF.keyboardType = .numberPad
        checkCodeTF.returnKeyType = .next
        checkCodeTF.delegate = self
        inputBgView.addSubview(checkCodeTF)
        
        // 中间虚线
        drawDashed(inputBgView, color: lightGrayColor, fromPoint: CGPoint(x: 0, y: checkCodeLab.frame.maxY), toPoint: CGPoint(x: screenSize.width, y: checkCodeLab.frame.maxY), lineWidth: 1)
        
        // 新密码 Label
        let pwdLab = UILabel(frame: CGRect(
            x: kHeightScale*12,
            y: checkCodeLab.frame.maxY+1,
            width: kWidthScale*78,
            height: subHeight))
        pwdLab.textColor = UIColor.white
        pwdLab.text = "密码"
        pwdLab.textAlignment = .left
        inputBgView.addSubview(pwdLab)
        
        // 新密码输入框
        pwdTF.frame = CGRect(
            x: telLab.frame.maxX+5,
            y: checkCodeLab.frame.maxY+1,
            width: screenSize.width-kWidthScale*11-checkCodeLab.frame.maxX+5,
            height: subHeight)
        pwdTF.placeholder = "请输入密码"
        pwdTF.keyboardType = .default
        pwdTF.delegate = self
        inputBgView.addSubview(pwdTF)
        
        // 注册按钮
        let registerBtn = UIButton(frame: CGRect(x: kWidthScale*10, y: inputBgView.frame.maxY+kHeightScale*49, width: kWidthScale*355, height: kHeightScale*42))
        registerBtn.backgroundColor = baseColor
        registerBtn.layer.cornerRadius = 8
        registerBtn.setTitle("注册", for: UIControlState())
        registerBtn.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        rootScrollView.addSubview(registerBtn)
        
        // 用户协议 按钮
        let agreementBtn = UIButton(frame: CGRect(
            x: kWidthScale*275,
            y: registerBtn.frame.maxY+kHeightScale*15,
            width: kWidthScale*90,
            height: kHeightScale*42))
        agreementBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        agreementBtn.contentHorizontalAlignment = .right
        agreementBtn.setTitle("用户协议", for: UIControlState())
        agreementBtn.setTitleColor(baseColor, for: UIControlState())
        agreementBtn.addTarget(self, action: #selector(agreementBtnClick), for: .touchUpInside)
        rootScrollView.addSubview(agreementBtn)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == telTF {
            checkCodeTF.becomeFirstResponder()
            if self.getCheckCodeBtn.isUserInteractionEnabled {
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
            DispatchQueue.main.async(execute: {
                self.getCheckCodeBtn.isUserInteractionEnabled = false
                let btnTitle = String(timeInterVal) + "秒后重新获取"
                self.getCheckCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                
                self.getCheckCodeBtn.setTitle(btnTitle, for: UIControlState())
                
                
                
            })
        }
        
        finishHandle = {[unowned self] (timeInterVal) in
            DispatchQueue.main.async(execute: {
                self.getCheckCodeBtn.isUserInteractionEnabled = true
                self.getCheckCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                self.getCheckCodeBtn.setTitle("重新获取验证码", for: UIControlState())
            })
        }
        TimeManager.shareManager.taskDic["register"]?.FHandle = finishHandle
        TimeManager.shareManager.taskDic["register"]?.PHandle = processHandle
    }
    
    // MARK: 获取验证码按钮点击事件
    func getCheckCodeBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断手机号是否为空
        if telTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if !isPhoneNumber(telTF.text!) {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "手机号输入有误"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        LoginNetUtil().checkphone(telTF.text!) { (success, response) in
            
            if success {
                
                DispatchQueue.main.async(execute: { 
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.labelText = response as! String
                    checkCodeHud.hide(true, afterDelay: 1)
                    TimeManager.shareManager.taskDic["register"]?.leftTime = 0
                })
            }else{
                
                
                LoginNetUtil().SendMobileCode(self.telTF.text!) { (success, response) in
                    
                    DispatchQueue.main.async(execute: { 
                        
                        if success {
                            
                            // 手机号没注册,验证码传到手机,执行倒计时操作
                            TimeManager.shareManager.begainTimerWithKey("register", timeInterval: 30, process: self.processHandle!, finish: self.finishHandle!)
                            checkCodeHud.hide(true)
                            print("success")
                        }else{
                            
                            print("no success")
                            checkCodeHud.mode = .text
                            checkCodeHud.labelText = "获取验证码失败"
                            checkCodeHud.hide(true, afterDelay: 1)
                            
                            TimeManager.shareManager.taskDic["register"]?.leftTime = 0
                            
                        }
                    })
                }
            }
        }
        
    }
    
    // MARK: 注册按钮点击事件
    func registerBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断手机号是否为空
        if telTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if !isPhoneNumber(telTF.text!) {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "手机号输入有误"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if checkCodeTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入验证码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if pwdTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        
        LoginNetUtil().AppRegister(telTF.text!, password: pwdTF.text!, code: checkCodeTF.text!) { (success, response) in
            if success {

                checkCodeHud.hide(false)
                
                self.navigationController?.pushViewController(LoReChooseIdentityViewController(), animated: true)
            }else{
                
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "注册失败"
                checkCodeHud.detailsLabelText = response as! String
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
    }
    
    // MARK: 用户协议按钮点击事件
    func agreementBtnClick() {
        //        self.navigationController?.pushViewController(WeHomeViewController(), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
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
