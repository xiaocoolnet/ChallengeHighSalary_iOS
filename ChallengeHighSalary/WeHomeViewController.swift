//
//  WeHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/2.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class WeHomeViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
        
        self.navigationController?.interactivePopGestureRecognizer?.enabled = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        // Do any additional setup after loading the view.
        
        // 挑战高薪 头部
        let topBgImg = UIImageView(frame: CGRectMake(
            0,
            0,
            screenSize.width,
            screenSize.height*0.4185))
        topBgImg.image = UIImage(named: "ic_身份选择_背景")
        self.view.addSubview(topBgImg)
        
        let textImg = UIImageView(image: UIImage(named: "ic_appNameImg"))
        textImg.center = topBgImg.center
        self.view.addSubview(textImg)
        
        let margin:CGFloat = 8

        // 抢人才按钮
        let forTalentBtn = UIButton(frame: CGRectMake(
            0,
            screenSize.height*0.5,
            screenSize.width*0.858,
            screenSize.height*0.066))
        forTalentBtn.backgroundColor = baseColor
        forTalentBtn.layer.cornerRadius = 8
        forTalentBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        forTalentBtn.setImage(UIImage(named: "ic_身份选择_抢人才"), forState: .Normal)
        forTalentBtn.setTitle("抢人才", forState: .Normal)
        forTalentBtn.addTarget(self, action: #selector(forTalentBtnClick), forControlEvents: .TouchUpInside)
        forTalentBtn.center.x = self.view.center.x
        forTalentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        forTalentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(forTalentBtn)
        
        // 挑战高薪 按钮
        let cHSalaryBtn = UIButton(frame: CGRectMake(
            0,
            screenSize.height*0.6,
            screenSize.width*0.858,
            screenSize.height*0.066))
        cHSalaryBtn.backgroundColor = baseColor
        cHSalaryBtn.layer.cornerRadius = 8
        cHSalaryBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cHSalaryBtn.setImage(UIImage(named: "ic_身份选择_挑战高薪"), forState: .Normal)
        cHSalaryBtn.setTitle("挑战高薪", forState: .Normal)
        cHSalaryBtn.addTarget(self, action: #selector(chSalaryBtnClick), forControlEvents: .TouchUpInside)
        cHSalaryBtn.center.x = self.view.center.x
        cHSalaryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        cHSalaryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(cHSalaryBtn)
        
        // 退出登录 按钮
        let logOutBtn = UIButton(frame: CGRectMake(
            0,
            screenSize.height*0.934,
            screenSize.width,
            screenSize.height*0.066))
        logOutBtn.backgroundColor = UIColor.whiteColor()
        logOutBtn.setTitleColor(baseColor, forState: .Normal)
        logOutBtn.setImage(UIImage(named: "ic_身份选择_退出"), forState: .Normal)
        logOutBtn.setTitle("退出登录", forState: .Normal)
        logOutBtn.addTarget(self, action: #selector(logOutBtnClick), forControlEvents: .TouchUpInside)
        logOutBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        logOutBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(logOutBtn)
    }
    
    // MARK: 找人才 按钮 点击事件
    func forTalentBtnClick() {
        
        if CHSUserInfo.currentUserInfo.usertype == "2" || CHSUserInfo.currentUserInfo.usertype == "3" {
            
            let isAutoLogin = EMClient.sharedClient().options.isAutoLogin ?? false
            if (!isAutoLogin) {
                // TODO: 正式环境放到服务器注册
                let userName = String(NSString(string: CHSUserInfo.currentUserInfo.userid).integerValue*10+1)
                
                EMClient.sharedClient().loginWithUsername(userName, password: "999") { (str, error) in
                    
                    if ((error == nil)) {
                        print("登录成功 \(str)")
                        
                        EMClient.sharedClient().options.isAutoLogin = true
                        
                    }else{
                        print("\(error) \(str)")
                    }
                }
            }
            
            // 找人才 过渡界面
            let welLab = UILabel(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
            welLab.backgroundColor = baseColor
            welLab.numberOfLines = 0
            welLab.textColor = UIColor.whiteColor()
            welLab.font = UIFont.boldSystemFontOfSize(20)
            welLab.adjustsFontSizeToFitWidth = true
            welLab.textAlignment = .Center
            welLab.text = "机不可失失不再来，快抢人才！"
            self.view.addSubview(welLab)
            
            
            let toVC = FTRoHomeViewController()
            toVC.view.frame.origin.x = -screenSize.width
            toVC.viewControllers![0].view.frame.origin.x = -screenSize.width
            self.view.addSubview(toVC.view)
            
            let time: NSTimeInterval = 1.0
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            
            dispatch_after(delay, dispatch_get_main_queue()) {
                
                UIView.animateWithDuration(1, animations: {
                    toVC.view.frame.origin.x = 0
                    toVC.viewControllers![0].view.frame.origin.x = 0
                    
                }) { (finished) in
                    if finished {
                        self.presentViewController(toVC, animated: false, completion: nil)
                    }
                }
            }
        }else{
            self.navigationController?.pushViewController(LoReFTPersonalInfoViewController(), animated: true)
            
        }
    }
    
    // MARK: 挑战高薪 按钮 点击事件
    func chSalaryBtnClick() {
        
        if CHSUserInfo.currentUserInfo.usertype == "1" || CHSUserInfo.currentUserInfo.usertype == "3" {
            
            let isAutoLogin = EMClient.sharedClient().options.isAutoLogin ?? false
            if (!isAutoLogin) {
                // TODO: 正式环境放到服务器注册
                let userName = String(NSString(string: CHSUserInfo.currentUserInfo.userid).integerValue*10+1)
                
                EMClient.sharedClient().loginWithUsername(userName, password: "999") { (str, error) in
                    
                    if ((error == nil)) {
                        print("登录成功 \(str)")
                        
                        EMClient.sharedClient().options.isAutoLogin = true
                        
                    }else{
                        print("\(error) \(str)")
                    }
                }
            }
            
            // 挑战高薪 过渡界面
            let welLab = UILabel(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
            welLab.backgroundColor = baseColor
            welLab.numberOfLines = 0
            welLab.textColor = UIColor.whiteColor()
            welLab.font = UIFont.boldSystemFontOfSize(20)
            welLab.adjustsFontSizeToFitWidth = true
            welLab.textAlignment = .Center
            welLab.text = "千万不要低估了自己\n也不要高估了那些拿到高薪的人~！\n查看职位还有可能获得奖金哦！"
            self.view.addSubview(welLab)
            
            
            let toVC = CHRoHomeViewController()
            toVC.view.frame.origin.x = -screenSize.width
            toVC.viewControllers![0].view.frame.origin.x = -screenSize.width
            self.view.addSubview(toVC.view)
            
            let time: NSTimeInterval = 1.0
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            
            dispatch_after(delay, dispatch_get_main_queue()) {
                
                UIView.animateWithDuration(1, animations: {
                    toVC.view.frame.origin.x = 0
                    toVC.viewControllers![0].view.frame.origin.x = 0
                    
                }) { (finished) in
                    if finished {
                        self.presentViewController(toVC, animated: false, completion: nil)
                    }
                }
            }
        }else{
            self.navigationController?.pushViewController(LoReCHSPersonalInfoViewController(), animated: true)

        }
    }
    
    // MARK: 退出 按钮 点击事件
    func logOutBtnClick() {
        
        let signOutAlert = UIAlertController(title: "", message: "确定退出登录？", preferredStyle: .Alert)
        self.presentViewController(signOutAlert, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        signOutAlert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .Default, handler: { (sureAction) in
            
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: isLogin_key)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(logInfo_key)
            //                self.presentViewController(UINavigationController(rootViewController: LoHomeViewController()), animated: true, completion: nil)
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = UINavigationController(rootViewController: LoHomeViewController())
        })
        signOutAlert.addAction(sureAction)
        
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
