//
//  WeHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/2.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class WeHomeViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        // Do any additional setup after loading the view.
        
        // 挑战高薪 头部
        let topBgImg = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: screenSize.width,
            height: screenSize.height*0.4185))
        topBgImg.image = UIImage(named: "ic_身份选择_背景")
        self.view.addSubview(topBgImg)
        
        let textImg = UIImageView(image: UIImage(named: "ic_appNameImg"))
        textImg.center = topBgImg.center
        self.view.addSubview(textImg)
        
        let margin:CGFloat = 8

        // 抢人才按钮
        let forTalentBtn = UIButton(frame: CGRect(
            x: 0,
            y: screenSize.height*0.5,
            width: screenSize.width*0.858,
            height: screenSize.height*0.066))
        forTalentBtn.backgroundColor = baseColor
        forTalentBtn.layer.cornerRadius = 8
        forTalentBtn.setTitleColor(UIColor.white, for: UIControlState())
        forTalentBtn.setImage(UIImage(named: "ic_身份选择_抢人才"), for: UIControlState())
        forTalentBtn.setTitle("抢人才", for: UIControlState())
        forTalentBtn.addTarget(self, action: #selector(forTalentBtnClick), for: .touchUpInside)
        forTalentBtn.center.x = self.view.center.x
        forTalentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        forTalentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(forTalentBtn)
        
        // 挑战高薪 按钮
        let cHSalaryBtn = UIButton(frame: CGRect(
            x: 0,
            y: screenSize.height*0.6,
            width: screenSize.width*0.858,
            height: screenSize.height*0.066))
        cHSalaryBtn.backgroundColor = baseColor
        cHSalaryBtn.layer.cornerRadius = 8
        cHSalaryBtn.setTitleColor(UIColor.white, for: UIControlState())
        cHSalaryBtn.setImage(UIImage(named: "ic_身份选择_挑战高薪"), for: UIControlState())
        cHSalaryBtn.setTitle("挑战高薪", for: UIControlState())
        cHSalaryBtn.addTarget(self, action: #selector(chSalaryBtnClick), for: .touchUpInside)
        cHSalaryBtn.center.x = self.view.center.x
        cHSalaryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        cHSalaryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(cHSalaryBtn)
        
        // 退出登录 按钮
        let logOutBtn = UIButton(frame: CGRect(
            x: 0,
            y: screenSize.height*0.934,
            width: screenSize.width,
            height: screenSize.height*0.066))
        logOutBtn.backgroundColor = UIColor.white
        logOutBtn.setTitleColor(baseColor, for: UIControlState())
        logOutBtn.setImage(UIImage(named: "ic_身份选择_退出"), for: UIControlState())
        logOutBtn.setTitle("退出登录", for: UIControlState())
        logOutBtn.addTarget(self, action: #selector(logOutBtnClick), for: .touchUpInside)
        logOutBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        logOutBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        self.view.addSubview(logOutBtn)
    }
    
    // MARK: 找人才 按钮 点击事件
    func forTalentBtnClick() {
        
        self.navigationController?.pushViewController(LoReFTPersonalInfoViewController(), animated: true)

//        if CHSUserInfo.currentUserInfo.usertype == "2" || CHSUserInfo.currentUserInfo.usertype == "3" {
//            
//
//            
//            // 找人才 过渡界面
//            let welLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
//            welLab.backgroundColor = baseColor
//            welLab.numberOfLines = 0
//            welLab.textColor = UIColor.white
//            welLab.font = UIFont.boldSystemFont(ofSize: 20)
//            welLab.adjustsFontSizeToFitWidth = true
//            welLab.textAlignment = .center
//            welLab.text = "机不可失失不再来，快抢人才！"
//            self.view.addSubview(welLab)
//            
//            let toVC = FTWelcomeViewController()
//            toVC.view.frame.origin.x = -screenSize.width
////            toVC.viewControllers![0].view.frame.origin.x = -screenSize.width
//            self.view.addSubview(toVC.view)
//            
//            let time: TimeInterval = 1.0
//            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//            
//            DispatchQueue.main.asyncAfter(deadline: delay) {
//                
//                UIView.animate(withDuration: 1, animations: {
//                    toVC.view.frame.origin.x = 0
////                    toVC.viewControllers![0].view.frame.origin.x = 0
//                    
//                }, completion: { (finished) in
//                    if finished {
//                        self.present(toVC, animated: false, completion: nil)
//                    }
//                })
//            }
////            let toVC = FTRoHomeViewController()
////            toVC.view.frame.origin.x = -screenSize.width
////            toVC.viewControllers![0].view.frame.origin.x = -screenSize.width
////            self.view.addSubview(toVC.view)
////            
////            let time: TimeInterval = 1.0
////            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
////            
////            DispatchQueue.main.asyncAfter(deadline: delay) {
////                
////                UIView.animate(withDuration: 1, animations: {
////                    toVC.view.frame.origin.x = 0
////                    toVC.viewControllers![0].view.frame.origin.x = 0
////                    
////                }, completion: { (finished) in
////                    if finished {
////                        self.present(toVC, animated: false, completion: nil)
////                    }
////                }) 
////            }
//        }else{
//            self.navigationController?.pushViewController(LoReFTPersonalInfoViewController(), animated: true)
//            
//        }
    }
    
    // MARK: 挑战高薪 按钮 点击事件
    func chSalaryBtnClick() {
        
        self.navigationController?.pushViewController(LoReCHSPersonalInfoViewController(), animated: true)

//        if CHSUserInfo.currentUserInfo.usertype == "1" || CHSUserInfo.currentUserInfo.usertype == "3" {
//            
//            // 挑战高薪 过渡界面
//            let welLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
//            welLab.backgroundColor = baseColor
//            welLab.numberOfLines = 0
//            welLab.textColor = UIColor.white
//            welLab.font = UIFont.boldSystemFont(ofSize: 20)
//            welLab.adjustsFontSizeToFitWidth = true
//            welLab.textAlignment = .center
//            welLab.text = "千万不要低估了自己\n也不要高估了那些拿到高薪的人~！\n查看职位还有可能获得奖金哦！"
//            self.view.addSubview(welLab)
//            
//            let toVC = CHSWelcomeViewController()
//            toVC.view.frame.origin.x = -screenSize.width
////            toVC.viewControllers![0].view.frame.origin.x = -screenSize.width
//            self.view.addSubview(toVC.view)
//            
//            let time: TimeInterval = 1.0
//            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//            
//            DispatchQueue.main.asyncAfter(deadline: delay) {
//                
//                UIView.animate(withDuration: 1, animations: {
//                    toVC.view.frame.origin.x = 0
////                    toVC.viewControllers![0].view.frame.origin.x = 0
//                    
//                }, completion: { (finished) in
//                    if finished {
//                        self.present(toVC, animated: false, completion: nil)
//                    }
//                })
//            }
////            let toVC = CHRoHomeViewController()
////            toVC.view.frame.origin.x = -screenSize.width
////            toVC.viewControllers![0].view.frame.origin.x = -screenSize.width
////            self.view.addSubview(toVC.view)
////            
////            let time: TimeInterval = 1.0
////            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
////            
////            DispatchQueue.main.asyncAfter(deadline: delay) {
////                
////                UIView.animate(withDuration: 1, animations: {
////                    toVC.view.frame.origin.x = 0
////                    toVC.viewControllers![0].view.frame.origin.x = 0
////                    
////                }, completion: { (finished) in
////                    if finished {
////                        self.present(toVC, animated: false, completion: nil)
////                    }
////                }) 
////            }
//        }else{
//            self.navigationController?.pushViewController(LoReCHSPersonalInfoViewController(), animated: true)
//
//        }
    }
    
    // MARK: 退出 按钮 点击事件
    func logOutBtnClick() {
        
        let signOutAlert = UIAlertController(title: "", message: "确定退出登录？", preferredStyle: .alert)
        self.present(signOutAlert, animated: true, completion: nil)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        signOutAlert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .default, handler: { (sureAction) in
            
            UserDefaults.standard.set(false, forKey: isLogin_key)
            UserDefaults.standard.removeObject(forKey: logInfo_key)
            //                self.presentViewController(UINavigationController(rootViewController: LoHomeViewController()), animated: true, completion: nil)
            
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LoHomeViewController())
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
