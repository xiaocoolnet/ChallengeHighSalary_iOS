//
//  CHSMiCheckPasswordViewController.swift
//  Challenge_high_salary
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
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
        
        self.title = "验证密码"
        
        // MARK: 原密码 背景
        let originalPwdBgView = UIView(frame: CGRectMake(kWidthScale*10, kHeightScale*105+44+20, screenSize.width-kWidthScale*20, kHeightScale*50))
        originalPwdBgView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(originalPwdBgView)
        
        // 原密码 图标
        let originalPwdImg = UIImageView(frame: CGRectMake(
            0,
            0,
            kWidthScale*38,
            originalPwdBgView.frame.size.height))
        originalPwdImg.backgroundColor = UIColor.grayColor()
        originalPwdBgView.addSubview(originalPwdImg)
        
        // 原密码输入框
        originalPwdTF.frame = CGRectMake(kWidthScale*40, 0, originalPwdBgView.frame.size.width-kWidthScale*40, originalPwdBgView.frame.size.height)
        originalPwdTF.borderStyle = .None
        originalPwdTF.placeholder = "请输入原密码"
        originalPwdTF.keyboardType = .Default
        originalPwdTF.returnKeyType = .Done
        originalPwdTF.delegate = self
        originalPwdBgView.addSubview(originalPwdTF)
        
        // 直线
        let lineView = UIView(frame: CGRectMake(kWidthScale*10, CGRectGetMaxY(originalPwdBgView.frame)+1, screenSize.width-kWidthScale*20, 1))
//        lineView.layer.cornerRadius = 6
        lineView.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.view.addSubview(lineView)
        
        
        // 下一步 按钮
        let nextBtn = UIButton(frame: CGRectMake(kWidthScale*10, CGRectGetMaxY(originalPwdBgView.frame)+kHeightScale*96, screenSize.width-kWidthScale*20, kHeightScale*45))
        nextBtn.backgroundColor = baseColor
        nextBtn.layer.cornerRadius = 8
        nextBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        nextBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        nextBtn.setTitle("下一步", forState: .Normal)
        nextBtn.addTarget(self, action: #selector(nextBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(nextBtn)
        
    }
    
    // MARK: UITextField delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nextBtnClick()
        return true
    }
    
    // MARK: 下一步 按钮 点击事件
    func nextBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if originalPwdTF.text!.isEmpty {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入原密码"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        CHSMiNetUtil().oldpassword(originalPwdTF.text!) { (success, response) in
            if success {
                checkCodeHud.hide(true)
                self.navigationController?.pushViewController(CHSMiSetPasswordViewController(), animated: true)
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
