//
//  CHSMiPhoneBindingViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiPhoneBindingViewController: UIViewController, UITextFieldDelegate {
    
    let rootScrollView = TPKeyboardAvoidingScrollView()
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "手机绑定"
        
        self.rootScrollView.frame = self.view.bounds
        self.rootScrollView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.rootScrollView.isScrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        // MARK: 当前手机号 Label
        let currentPhoneLab = UILabel(frame: CGRect(x: 0, y: kHeightScale*40+44+20, width: screenSize.width, height: kHeightScale*15))
        currentPhoneLab.textColor = UIColor(red: 156/255.0, green: 156/255.0, blue: 156/255.0, alpha: 1)
        currentPhoneLab.textAlignment = .center
        currentPhoneLab.font = UIFont.systemFont(ofSize: 14)
        currentPhoneLab.text = "当前手机号"
        self.rootScrollView.addSubview(currentPhoneLab)
        
        // MARK: 手机号
        let phoneLab = UILabel(frame: CGRect(x: 0, y: kHeightScale*65+44+20, width: screenSize.width, height: kHeightScale*15))
        phoneLab.textColor = UIColor.black
        phoneLab.textAlignment = .center
        phoneLab.font = UIFont.boldSystemFont(ofSize: 16)
        
        let phoneNum = CHSUserInfo.currentUserInfo.phoneNumber
        
        let startIdx = phoneNum.index(phoneNum.startIndex, offsetBy: 3)
        let endIdx = phoneNum.index(phoneNum.endIndex, offsetBy: -4)

        let range = startIdx ..< endIdx
        
        phoneLab.text = phoneNum.replacingCharacters(in: range, with: "****")
        
        self.rootScrollView.addSubview(phoneLab)
        
        // MARK: 新手机号 背景
        let newPhoneBgView = UIView(frame: CGRect(x: kWidthScale*10, y: kHeightScale*105+44+20, width: screenSize.width-kWidthScale*20, height: kHeightScale*50))
        newPhoneBgView.layer.cornerRadius = 6
        newPhoneBgView.backgroundColor = UIColor.white
        self.rootScrollView.addSubview(newPhoneBgView)
        
        // 电话前缀
//        let telLab = UIButton(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: kWidthScale*58,
//            height: newPhoneBgView.frame.size.height))
        let telLab = ImageBtn(frame: CGRect(
            x: 0,
            y: 0,
            width: kWidthScale*58,
            height: newPhoneBgView.frame.size.height))!
        telLab.resetdata("+86", #imageLiteral(resourceName: "ic_xialajiantou"))
        telLab.lb_titleColor = baseColor
//        telLab.setTitleColor(baseColor, for: UIControlState())
//        telLab.setTitle("+86", for: UIControlState())
//        telLab.setImage(UIImage(named: "ic_下拉箭头"), for: UIControlState())
//        exchangeBtnImageAndTitle(telLab, margin: 2)
        newPhoneBgView.addSubview(telLab)
        
        // 电话前缀右边虚线
        drawDashed(newPhoneBgView, color: UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1), fromPoint: CGPoint(x: telLab.frame.maxX, y: telLab.frame.minY+5), toPoint: CGPoint(x: telLab.frame.maxX, y: newPhoneBgView.frame.size.height-5), lineWidth: 1)
        
        // 电话号码输入框
        telTF.frame = CGRect(x: telLab.frame.maxX+5, y: 0, width: screenSize.width-kWidthScale*59, height: newPhoneBgView.frame.size.height)
        telTF.placeholder = "请输入手机号"
        telTF.keyboardType = .numberPad
        telTF.returnKeyType = .next
        telTF.delegate = self
        newPhoneBgView.addSubview(telTF)
        
        // MARK: 验证码 背景
        let checkCodeBgView = UIView(frame: CGRect(x: kWidthScale*10, y: newPhoneBgView.frame.maxY+kHeightScale*20, width: screenSize.width-kWidthScale*20, height: kHeightScale*50))
        checkCodeBgView.layer.cornerRadius = 6
        checkCodeBgView.backgroundColor = UIColor.white
        self.rootScrollView.addSubview(checkCodeBgView)
        
        // 验证码 前 背景视图
        let checkCodeView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: kWidthScale*58,
            height: newPhoneBgView.frame.size.height))
//        checkCodeView.backgroundColor = UIColor.grayColor()
        checkCodeBgView.addSubview(checkCodeView)
        // 验证码 ImageView
        let checkCodeImg = UIImageView(image: UIImage(named: "ic_手机"))
        checkCodeImg.center = checkCodeView.center
        checkCodeBgView.addSubview(checkCodeImg)
        
        // 验证码右边虚线
        drawDashed(checkCodeBgView, color: UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1), fromPoint: CGPoint(x: checkCodeView.frame.maxX, y: checkCodeView.frame.minY+5), toPoint: CGPoint(x: checkCodeView.frame.maxX, y: checkCodeBgView.frame.size.height-5), lineWidth: 1)
        
        // 验证码输入框
        checkCodeTF.frame = CGRect(
            x: telLab.frame.maxX+5,
            y: 0,
            width: newPhoneBgView.frame.size.width-kWidthScale*110-telLab.frame.maxX+5,
            height: newPhoneBgView.frame.size.height)
        checkCodeTF.placeholder = "验证码"
        checkCodeTF.keyboardType = .numberPad
        checkCodeTF.returnKeyType = .done
        checkCodeTF.delegate = self
        checkCodeBgView.addSubview(checkCodeTF)
        
        // 获取验证码 按钮
        getCheckCodeBtn.frame = CGRect(
            x: newPhoneBgView.frame.size.width-kWidthScale*(96+14),
            y: kHeightScale*10,
            width: kWidthScale*96,
            height: kHeightScale*30)
        //        getCheckCodeBtn.backgroundColor = baseColor
        getCheckCodeBtn.layer.cornerRadius = kHeightScale*15
        getCheckCodeBtn.layer.borderColor = baseColor.cgColor
        getCheckCodeBtn.layer.borderWidth = 1
        getCheckCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        getCheckCodeBtn.setTitleColor(baseColor, for: UIControlState())
//        getCheckCodeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        getCheckCodeBtn.setTitle("获取验证码", for: UIControlState())
        getCheckCodeBtn.addTarget(self, action: #selector(getCheckCodeBtnClick), for: .touchUpInside)
        checkCodeBgView.addSubview(getCheckCodeBtn)
        
        // 确认更换 按钮
        let sureChangeBtn = UIButton(frame: CGRect(x: kWidthScale*10, y: checkCodeBgView.frame.maxY+kHeightScale*96, width: screenSize.width-kWidthScale*20, height: kHeightScale*45))
        sureChangeBtn.backgroundColor = baseColor
        sureChangeBtn.layer.cornerRadius = kHeightScale*22.5
        sureChangeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        sureChangeBtn.setTitleColor(UIColor.white, for: UIControlState())
        sureChangeBtn.setTitle("确认更换", for: UIControlState())
        sureChangeBtn.addTarget(self, action: #selector(sureChangeBtnClick), for: .touchUpInside)
        self.rootScrollView.addSubview(sureChangeBtn)
        
        // 提示 Label
        let tipLab = UILabel(frame: CGRect(
            x: 0,
            y: sureChangeBtn.frame.maxY+kHeightScale*15,
            width: screenSize.width,
            height: kHeightScale*15))
        tipLab.font = UIFont.systemFont(ofSize: 12)
        tipLab.textColor = UIColor(red: 161/255.0, green: 161/255.0, blue: 161/255.0, alpha: 1)
        tipLab.text = "修改手机号后，可以使用新的手机号登录"
        tipLab.textAlignment = .center
        self.rootScrollView.addSubview(tipLab)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == telTF {
            checkCodeTF.becomeFirstResponder()
            if self.getCheckCodeBtn.isUserInteractionEnabled {
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
        TimeManager.shareManager.taskDic["changePhone"]?.FHandle = finishHandle
        TimeManager.shareManager.taskDic["changePhone"]?.PHandle = processHandle
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
                    TimeManager.shareManager.taskDic["changePhone"]?.leftTime = 0
                    
                })
            }else{
                
                
                LoginNetUtil().SendMobileCode(self.telTF.text!) { (success, response) in
                    
                    DispatchQueue.main.async(execute: {
                        
                        if success {
                            
                            // 手机号没注册,验证码传到手机,执行倒计时操作
                            TimeManager.shareManager.begainTimerWithKey("changePhone", timeInterval: 30, process: self.processHandle!, finish: self.finishHandle!)
                            checkCodeHud.hide(true)
                            print("success")
                        }else{
                            
                            print("no success")
                            checkCodeHud.mode = .text
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
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        // 判断手机号是否为空
        if telTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入手机号"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if !isPhoneNumber(telTF.text!) {// 判断手机号格式是否正确
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "手机号输入有误"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if checkCodeTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入验证码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        CHSMiNetUtil().updateUserPhone(telTF.text!, code: checkCodeTF.text!) { (success, response) in
            if success {
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "更换手机号成功"
                checkCodeHud.hide(true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.labelText = String(describing: response!)
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
