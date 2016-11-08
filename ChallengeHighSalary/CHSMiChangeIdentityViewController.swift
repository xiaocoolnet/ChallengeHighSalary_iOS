//
//  CHSMiChangeIdentityViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSMiChangeIdentityViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
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
        topBgImg.image = UIImage(named: "ic_切换身份_背景")
        self.view.addSubview(topBgImg)
        
        let textImg = UIImageView(image: UIImage(named: "ic_appNameImg"))
        textImg.center = topBgImg.center
        self.view.addSubview(textImg)
        
        let backBtn = UIButton(frame: CGRect(x: 8, y: 28, width: kHeightScale*25, height: kHeightScale*25))
        //        backBtn.backgroundColor = baseColor
        backBtn.setImage(UIImage(named: "ic_返回_white"), for: UIControlState())
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let margin:CGFloat = 8
        
        // 抢人才按钮
        let forTalentBtn = UIButton(frame: CGRect(
            x: 0,
            y: screenSize.height*0.5,
            width: screenSize.width*0.858,
            height: screenSize.height*0.066))
        forTalentBtn.backgroundColor = UIColor.white
        forTalentBtn.layer.cornerRadius = screenSize.height*0.033
        forTalentBtn.layer.borderColor = baseColor.cgColor
        forTalentBtn.layer.borderWidth = 1
        forTalentBtn.setTitleColor(baseColor, for: UIControlState())
        forTalentBtn.setImage(UIImage(named: "ic_切换身份_招人_green"), for: UIControlState())
        forTalentBtn.setTitle("我要招人", for: UIControlState())
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
        cHSalaryBtn.layer.cornerRadius = screenSize.height*0.033
        cHSalaryBtn.setTitleColor(UIColor.white, for: UIControlState())
        cHSalaryBtn.setImage(UIImage(named: "ic_切换身份_求职_white"), for: UIControlState())
        cHSalaryBtn.setTitle("我要求职", for: UIControlState())
        cHSalaryBtn.center.x = self.view.center.x
        cHSalaryBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2.0, 0, margin/2.0)
        cHSalaryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2.0, 0, -margin/2.0)
        cHSalaryBtn.isUserInteractionEnabled = false
        self.view.addSubview(cHSalaryBtn)
        
    }
    
    // MARK:- backBtn 点击事件
    func backBtnClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 找人才 按钮 点击事件
    func forTalentBtnClick() {
        
        if CHSUserInfo.currentUserInfo.usertype == "2" || CHSUserInfo.currentUserInfo.usertype == "3" {
            
            // 找人才 过渡界面
            let welLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
            welLab.backgroundColor = baseColor
            welLab.numberOfLines = 0
            welLab.textColor = UIColor.white
            welLab.font = UIFont.boldSystemFont(ofSize: 20)
            welLab.adjustsFontSizeToFitWidth = true
            welLab.textAlignment = .center
            welLab.text = "机不可失失不再来，快抢人才！"
            self.view.addSubview(welLab)
            
            
            let toVC = FTRoHomeViewController()
            toVC.view.frame.origin.x = -screenSize.width
            toVC.viewControllers![0].view.frame.origin.x = -screenSize.width
            self.view.addSubview(toVC.view)
            
            let time: TimeInterval = 1.0
            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                UIView.animate(withDuration: 1, animations: {
                    toVC.view.frame.origin.x = 0
                    toVC.viewControllers![0].view.frame.origin.x = 0
                    
                }, completion: { (finished) in
                    if finished {
                        UIApplication.shared.keyWindow?.rootViewController = toVC
                    }
                }) 
            }
        }else{
            self.navigationController?.pushViewController(LoReFTPersonalInfoViewController(), animated: true)
            
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
