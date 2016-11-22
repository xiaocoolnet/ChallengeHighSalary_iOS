//
//  CHSMiCheckPasswordViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiCheckPasswordViewController: UIViewController, UITextFieldDelegate {

    // 原密码输入框
    let originalPwdTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
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
        
        self.title = "验证密码"
        
        // MARK: 原密码 背景
        let originalPwdBgView = UIView(frame: CGRect(x: 0, y: kHeightScale*105+44+20, width: screenSize.width, height: kHeightScale*50))
        originalPwdBgView.backgroundColor = UIColor.white
        self.view.addSubview(originalPwdBgView)
        
        // 原密码 图标
        let originalPwdImg = UIImageView(frame: CGRect(
            x: 0,
            y: originalPwdBgView.frame.size.height/3.0,
            width: kWidthScale*50,
            height: originalPwdBgView.frame.size.height/3.0))
        originalPwdImg.image = UIImage(named: "ic_密码_灰")
        originalPwdImg.contentMode = .scaleAspectFit
        originalPwdBgView.addSubview(originalPwdImg)
        
        drawLine(originalPwdBgView, color: UIColor.lightGray, fromPoint: CGPoint(x: kWidthScale*50, y: originalPwdBgView.frame.size.height/4.0), toPoint: CGPoint(x: kWidthScale*50, y: originalPwdBgView.frame.size.height/4.0*3), lineWidth: 1, pattern: [10,0])
        
        // 原密码输入框
        originalPwdTF.frame = CGRect(x: kWidthScale*53, y: 0, width: originalPwdBgView.frame.size.width-kWidthScale*53, height: originalPwdBgView.frame.size.height)
        originalPwdTF.borderStyle = .none
        originalPwdTF.placeholder = "请输入原密码"
        originalPwdTF.keyboardType = .default
        originalPwdTF.returnKeyType = .done
        originalPwdTF.isSecureTextEntry = true
        originalPwdTF.delegate = self
        originalPwdBgView.addSubview(originalPwdTF)
        
        // 下一步 按钮
        let nextBtn = UIButton(frame: CGRect(x: kWidthScale*10, y: originalPwdBgView.frame.maxY+kHeightScale*96, width: screenSize.width-kWidthScale*20, height: kHeightScale*45))
        nextBtn.backgroundColor = baseColor
        nextBtn.layer.cornerRadius = kHeightScale*22.5
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        nextBtn.setTitleColor(UIColor.white, for: UIControlState())
        nextBtn.setTitle("下一步", for: UIControlState())
        nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        self.view.addSubview(nextBtn)
        
    }
    
    // MARK: UITextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nextBtnClick()
        return true
    }
    
    // MARK: 下一步 按钮 点击事件
    func nextBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if originalPwdTF.text!.isEmpty {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入原密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        CHSMiNetUtil().oldpassword(originalPwdTF.text!) { (success, response) in
            if success {
                checkCodeHud.hide(true)
                self.navigationController?.pushViewController(CHSMiSetPasswordViewController(), animated: true)
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.labelText = String(describing: response!)
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
