//
//  CHSMiSetPasswordViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiSetPasswordViewController: UIViewController, UITextFieldDelegate {

    // 新密码输入框
    let newPwdTF = UITextField()
    // 确认密码输入框
    let sureNewPwdTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
        
        self.title = "修改密码"
        
        // MARK: 新密码 背景
        let newPwdBgView = UIView(frame: CGRectMake(0, kHeightScale*35+44+20, screenSize.width, kHeightScale*50))
        newPwdBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(newPwdBgView)
        
        // 新密码 label
        let newPwdLab = UILabel(frame: CGRectMake(
            kWidthScale*20,
            0,
            kWidthScale*70,
            newPwdBgView.frame.size.height))
        newPwdLab.font = UIFont.systemFontOfSize(15)
        newPwdLab.text = "新密码"
        newPwdLab.textAlignment = .Center
        newPwdBgView.addSubview(newPwdLab)
        
        // 新密码输入框
        newPwdTF.frame = CGRectMake(kWidthScale*110, 0, screenSize.width-kWidthScale*kWidthScale*130, newPwdBgView.frame.size.height)
        newPwdTF.font = UIFont.systemFontOfSize(14)
        newPwdTF.placeholder = "请设置登录密码"
        newPwdTF.keyboardType = .Default
        newPwdTF.returnKeyType = .Next
        newPwdTF.delegate = self
        newPwdBgView.addSubview(newPwdTF)
        
        // MARK: 确认密码 背景
        let surePwdBgView = UIView(frame: CGRectMake(0, CGRectGetMaxY(newPwdBgView.frame), screenSize.width, kHeightScale*50))
        surePwdBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(surePwdBgView)
        
        // 确认密码 label
        let surePwdLab = UILabel(frame: CGRectMake(
            kWidthScale*20,
            0,
            kWidthScale*70,
            newPwdBgView.frame.size.height))
        surePwdLab.font = UIFont.systemFontOfSize(15)
        surePwdLab.text = "确认密码"
        surePwdLab.textAlignment = .Center
        surePwdBgView.addSubview(surePwdLab)
        
        // 确认密码 输入框
        sureNewPwdTF.frame = CGRectMake(
            kWidthScale*110,
            0,
            screenSize.width-kWidthScale*kWidthScale*130,
            newPwdBgView.frame.size.height)
        sureNewPwdTF.font = UIFont.systemFontOfSize(14)
        sureNewPwdTF.placeholder = "再次输入密码"
        sureNewPwdTF.keyboardType = .Default
        sureNewPwdTF.returnKeyType = .Next
        sureNewPwdTF.delegate = self
        surePwdBgView.addSubview(sureNewPwdTF)
        
        // 修改密码 按钮
        let changePwdBtn = UIButton(frame: CGRectMake(kWidthScale*10, CGRectGetMaxY(surePwdBgView.frame)+kHeightScale*95, screenSize.width-kWidthScale*20, kHeightScale*45))
        changePwdBtn.backgroundColor = baseColor
        changePwdBtn.layer.cornerRadius = kHeightScale*22.5
        changePwdBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        changePwdBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        changePwdBtn.setTitle("修改密码", forState: .Normal)
        changePwdBtn.addTarget(self, action: #selector(changePwdBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(changePwdBtn)
        
    }
    
    // MARK: UITextField delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == newPwdTF {
            sureNewPwdTF.becomeFirstResponder()
        }else if textField == sureNewPwdTF {
            sureNewPwdTF.resignFirstResponder()
            changePwdBtnClick()
        }
        return true
    }
    
    // MARK: 修改密码 按钮 点击事件
    func changePwdBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if newPwdTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入登录密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if sureNewPwdTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入确认密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if newPwdTF.text! != sureNewPwdTF.text! {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "两次密码输入不一致"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        CHSMiNetUtil().changePassword(newPwdTF.text!) { (success, response) in
            if success {
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "密码修改成功"
                checkCodeHud.hide(true, afterDelay: 1)
                
                let time: NSTimeInterval = 1.0
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                
                dispatch_after(delay, dispatch_get_main_queue()) {
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-3])!, animated: true)
                }
            }else{
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = String(response!)
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
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
