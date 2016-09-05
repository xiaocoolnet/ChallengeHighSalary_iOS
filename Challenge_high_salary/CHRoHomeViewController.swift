//
//  CHRoHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHRoHomeViewController: UITabBarController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let chanceNVC = UINavigationController(rootViewController: ChChHomeViewController())
        chanceNVC.tabBarItem = UITabBarItem(title: "机会", image: nil, selectedImage: nil)
        
        let resumeNVC = UINavigationController(rootViewController: ChReHomeViewController())
        resumeNVC.tabBarItem = UITabBarItem(title: "简历", image: nil, selectedImage: nil)
        
        let messageNVC = UINavigationController(rootViewController: ChMeHomeViewController())
        messageNVC.tabBarItem = UITabBarItem(title: "消息", image: nil, selectedImage: nil)
        
        let mineNVC = UINavigationController(rootViewController: ChMiHomeViewController())
        mineNVC.tabBarItem = UITabBarItem(title: "我的", image: nil, selectedImage: nil)
        
        self.viewControllers = [chanceNVC,resumeNVC,messageNVC,mineNVC]
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
