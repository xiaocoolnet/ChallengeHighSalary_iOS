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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "修改密码"
        
        // MARK: 新密码 背景
        let newPwdBgView = UIView(frame: CGRect(x: 0, y: kHeightScale*35+44+20, width: screenSize.width, height: kHeightScale*50))
        newPwdBgView.backgroundColor = UIColor.white
        self.view.addSubview(newPwdBgView)
        
        // 新密码 label
        let newPwdLab = UILabel(frame: CGRect(
            x: kWidthScale*20,
            y: 0,
            width: kWidthScale*70,
            height: newPwdBgView.frame.size.height))
        newPwdLab.font = UIFont.systemFont(ofSize: 15)
        newPwdLab.text = "新密码"
        newPwdLab.textAlignment = .center
        newPwdBgView.addSubview(newPwdLab)
        
        // 新密码输入框
        newPwdTF.frame = CGRect(x: kWidthScale*110, y: 0, width: screenSize.width-kWidthScale*kWidthScale*130, height: newPwdBgView.frame.size.height)
        newPwdTF.font = UIFont.systemFont(ofSize: 14)
        newPwdTF.placeholder = "请设置登录密码"
        newPwdTF.keyboardType = .default
        newPwdTF.returnKeyType = .next
        newPwdTF.isSecureTextEntry = true
        newPwdTF.delegate = self
        newPwdBgView.addSubview(newPwdTF)
        
        // MARK: 确认密码 背景
        let surePwdBgView = UIView(frame: CGRect(x: 0, y: newPwdBgView.frame.maxY, width: screenSize.width, height: kHeightScale*50))
        surePwdBgView.backgroundColor = UIColor.white
        self.view.addSubview(surePwdBgView)
        
        // 确认密码 label
        let surePwdLab = UILabel(frame: CGRect(
            x: kWidthScale*20,
            y: 0,
            width: kWidthScale*70,
            height: newPwdBgView.frame.size.height))
        surePwdLab.font = UIFont.systemFont(ofSize: 15)
        surePwdLab.text = "确认密码"
        surePwdLab.textAlignment = .center
        surePwdBgView.addSubview(surePwdLab)
        
        // 确认密码 输入框
        sureNewPwdTF.frame = CGRect(
            x: kWidthScale*110,
            y: 0,
            width: screenSize.width-kWidthScale*kWidthScale*130,
            height: newPwdBgView.frame.size.height)
        sureNewPwdTF.font = UIFont.systemFont(ofSize: 14)
        sureNewPwdTF.placeholder = "再次输入密码"
        sureNewPwdTF.keyboardType = .default
        sureNewPwdTF.returnKeyType = .next
        sureNewPwdTF.isSecureTextEntry = true
        sureNewPwdTF.delegate = self
        surePwdBgView.addSubview(sureNewPwdTF)
        
        // 修改密码 按钮
        let changePwdBtn = UIButton(frame: CGRect(x: kWidthScale*10, y: surePwdBgView.frame.maxY+kHeightScale*95, width: screenSize.width-kWidthScale*20, height: kHeightScale*45))
        changePwdBtn.backgroundColor = baseColor
        changePwdBtn.layer.cornerRadius = kHeightScale*22.5
        changePwdBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        changePwdBtn.setTitleColor(UIColor.white, for: UIControlState())
        changePwdBtn.setTitle("修改密码", for: UIControlState())
        changePwdBtn.addTarget(self, action: #selector(changePwdBtnClick), for: .touchUpInside)
        self.view.addSubview(changePwdBtn)
        
    }
    
    // MARK: UITextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if newPwdTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入登录密码"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if sureNewPwdTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入确认密码"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if newPwdTF.text! != sureNewPwdTF.text! {
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "两次密码输入不一致"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }
        
        CHSMiNetUtil().changePassword(newPwdTF.text!) { (success, response) in
            if success {
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "密码修改成功"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-3])!, animated: true)
                }
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.label.text = String(describing: response!)
                checkCodeHud.hide(animated: true, afterDelay: 1)
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
