//
//  CHSMiSetPasswordViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/20.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiSetPasswordViewController: UIViewController {

    // 新密码输入框
    let newPwdTF = UITextField()
    // 确认密码输入框
    let sureNewPwdTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
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
            kWidthScale*90,
            newPwdBgView.frame.size.height))
        newPwdLab.font = UIFont.systemFontOfSize(15)
        newPwdLab.text = "新密码"
        newPwdLab.textAlignment = .Left
        newPwdBgView.addSubview(newPwdLab)
        
        // 新密码输入框
        newPwdTF.frame = CGRectMake(kWidthScale*110, 0, screenSize.width-kWidthScale*kWidthScale*130, newPwdBgView.frame.size.height)
        newPwdTF.font = UIFont.systemFontOfSize(14)
        newPwdTF.placeholder = "请设置登录密码"
        newPwdBgView.addSubview(newPwdTF)
        
        // MARK: 确认密码 背景
        let surePwdBgView = UIView(frame: CGRectMake(0, CGRectGetMaxY(newPwdBgView.frame), screenSize.width, kHeightScale*50))
        surePwdBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(surePwdBgView)
        
        // 确认密码 label
        let surePwdLab = UILabel(frame: CGRectMake(
            kWidthScale*20,
            0,
            kWidthScale*90,
            newPwdBgView.frame.size.height))
        surePwdLab.font = UIFont.systemFontOfSize(15)
        surePwdLab.text = "确认密码"
        surePwdLab.textAlignment = .Left
        surePwdBgView.addSubview(surePwdLab)
        
        // 确认密码 输入框
        sureNewPwdTF.frame = CGRectMake(
            kWidthScale*110,
            0,
            screenSize.width-kWidthScale*kWidthScale*130,
            newPwdBgView.frame.size.height)
        sureNewPwdTF.font = UIFont.systemFontOfSize(14)
        sureNewPwdTF.placeholder = "再次输入密码"
        surePwdBgView.addSubview(sureNewPwdTF)
        
        // 修改密码 按钮
        let changePwdBtn = UIButton(frame: CGRectMake(kWidthScale*10, CGRectGetMaxY(surePwdBgView.frame)+kHeightScale*95, screenSize.width-kWidthScale*20, kHeightScale*45))
        changePwdBtn.backgroundColor = baseColor
        changePwdBtn.layer.cornerRadius = 8
        changePwdBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        changePwdBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        changePwdBtn.setTitle("修改密码", forState: .Normal)
        changePwdBtn.addTarget(self, action: #selector(changePwdBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(changePwdBtn)
        
    }
    
    func changePwdBtnClick() {
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[(self.navigationController?.viewControllers.endIndex)!-3])!, animated: true)
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
