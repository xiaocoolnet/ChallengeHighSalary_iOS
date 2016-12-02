//
//  CHRoHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHRoHomeViewController: UITabBarController, UIViewControllerTransitioningDelegate {

    var messageNVC = UINavigationController()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let chanceNVC = UINavigationController(rootViewController: ChChHomeViewController())
        chanceNVC.tabBarItem = UITabBarItem(title: "机会", image: UIImage(named: "tabbar_机会"), selectedImage: UIImage(named: "tabbar_机会_sel"))
        
        let resumeNVC = UINavigationController(rootViewController: ChReHomeViewController())
        resumeNVC.tabBarItem = UITabBarItem(title: "简历", image: UIImage(named: "tabbar_简历"), selectedImage: UIImage(named: "tabbar_简历_sel"))
        
        messageNVC = UINavigationController(rootViewController: ChMeHomeViewController())
        messageNVC.tabBarItem = UITabBarItem(title: "消息", image: UIImage(named: "tabbar_消息"), selectedImage: UIImage(named: "tabbar_消息_sel"))
        
        let mineNVC = UINavigationController(rootViewController: ChMiHomeViewController())
        mineNVC.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "tabbar_我的"), selectedImage: UIImage(named: "tabbar_我的_sel"))
        
        self.viewControllers = [chanceNVC,resumeNVC,messageNVC,mineNVC]
//        NotificationCenter.default.addObserver(self, selector: #selector(newMessageRecived), name: NSNotification.Name(rawValue: "NewMessageRecivedNotification"), object: nil)
//        self.newMessageRecived()
    }
    
    func newMessageRecived() {
        
        
        messageNVC.tabBarItem.badgeValue = messageNVC.tabBarItem.badgeValue == nil ? "1":String(Int(messageNVC.tabBarItem.badgeValue!)!+1)
        
        if messageNVC.tabBarItem.badgeValue != nil {
            if Int(messageNVC.tabBarItem.badgeValue!)! >= 99 {
                messageNVC.tabBarItem.badgeValue = "99+"
            }else{
                messageNVC.tabBarItem.badgeValue = String(Int(messageNVC.tabBarItem.badgeValue!)!+1)
            }
        }else{
            messageNVC.tabBarItem.badgeValue = "1"
        }
        
//        let userInfo = noti.userInfo
//        
//        
//        
//        let chatData = ChatData()
        
        //        chatData.send_uid = userInfo?["extras"] ["v"] as! String
        //        chatData.content = userInfo?["alert"] as! String
        
        
        
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
