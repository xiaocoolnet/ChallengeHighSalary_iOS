//
//  FTRoHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTRoHomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let talentNVC = UINavigationController(rootViewController: FTTaHomeViewController())
        talentNVC.tabBarItem = UITabBarItem(title: "人才", image: UIImage(named: "tabbar_人才"), selectedImage: UIImage(named: "tabbar_人才_sel"))

        let messageNVC = UINavigationController(rootViewController: FTMeHomeViewController())
        messageNVC.tabBarItem = UITabBarItem(title: "消息", image: UIImage(named: "tabbar_消息"), selectedImage: UIImage(named: "tabbar_消息_sel"))
        
        let mineNVC = UINavigationController(rootViewController: FTMiHomeViewController())
        mineNVC.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "tabbar_我的"), selectedImage: UIImage(named: "tabbar_我的_sel"))
        
        self.viewControllers = [talentNVC,messageNVC,mineNVC]

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
