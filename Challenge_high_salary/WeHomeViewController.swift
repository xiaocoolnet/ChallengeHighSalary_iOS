//
//  WeHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/2.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class WeHomeViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        // Do any additional setup after loading the view.
        
        // 挑战高薪 头部
        let topLab = UILabel()
        topLab.text = "挑战高薪"
        topLab.font = UIFont.systemFontOfSize(24)
        topLab.textAlignment = .Center
        topLab.backgroundColor = baseColor
        topLab.textColor = UIColor.whiteColor()
        self.view.addSubview(topLab)
        
        topLab.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.4185)
        }
        
        // 抢人才按钮
        let forTalentBtn = UIButton()
        forTalentBtn.backgroundColor = baseColor
        forTalentBtn.layer.cornerRadius = 8
        forTalentBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        forTalentBtn.setImage(UIImage(named: "1"), forState: .Normal)
        forTalentBtn.setTitle("抢人才", forState: .Normal)
        forTalentBtn.addTarget(self, action: #selector(forTalentBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(forTalentBtn)
        
        forTalentBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).inset(screenSize.height*0.5)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.858)
            make.height.equalTo(self.view).multipliedBy(0.066)
        }
        
        // 挑战高薪 按钮
        let cHSalaryBtn = UIButton()
        cHSalaryBtn.backgroundColor = baseColor
        cHSalaryBtn.layer.cornerRadius = 8
        cHSalaryBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cHSalaryBtn.setImage(UIImage(named: "1"), forState: .Normal)
        cHSalaryBtn.setTitle("挑战高薪", forState: .Normal)
        cHSalaryBtn.addTarget(self, action: #selector(chSalaryBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(cHSalaryBtn)
        
        cHSalaryBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).inset(screenSize.height*0.6)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.858)
            make.height.equalTo(self.view).multipliedBy(0.066)
        }
        
        // 退出登录 按钮
        let signOutBtn = UIButton()
        signOutBtn.backgroundColor = UIColor.whiteColor()
        signOutBtn.setTitleColor(baseColor, forState: .Normal)
        signOutBtn.setImage(UIImage(named: "1"), forState: .Normal)
        signOutBtn.setTitle("退出登录", forState: .Normal)
        self.view.addSubview(signOutBtn)
        
        signOutBtn.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.066)
        }
    }
    
    // MARK: 找人才 按钮 点击事件
    func forTalentBtnClick() {
        
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
        
        UIView.animateWithDuration(2, animations: {
            toVC.view.frame.origin.x = 0
            toVC.viewControllers![0].view.frame.origin.x = 0
            
        }) { (finished) in
            if finished {
                self.presentViewController(toVC, animated: false, completion: nil)
            }
        }
    }
    
    // MARK: 挑战高薪 按钮 点击事件
    func chSalaryBtnClick() {
        
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
        
        UIView.animateWithDuration(2, animations: {
            toVC.view.frame.origin.x = 0
            toVC.viewControllers![0].view.frame.origin.x = 0

            }) { (finished) in
                if finished {
                    self.presentViewController(toVC, animated: false, completion: nil)
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
