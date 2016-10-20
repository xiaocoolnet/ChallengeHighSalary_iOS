//
//  CHSRePreviewViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSRePreviewViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
    }
    
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        self.title = "简历预览"
        
        let rootScrollView = UIScrollView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64))
        rootScrollView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        self.view.addSubview(rootScrollView)
        
        let titleLab = UILabel(frame: CGRectMake(8, 64, screenSize.width, kHeightScale*70))
        titleLab.font = UIFont.systemFontOfSize(15)
        titleLab.textColor = UIColor(red: 149/255.0, green: 149/255.0, blue: 149/255.0, alpha: 1)
        titleLab.text = "我的简历"
        rootScrollView.addSubview(titleLab)
        
        // MARK: 概况
        let summaryView = UIView(frame: CGRectMake(8, 64, screenSize.width, kHeightScale*70))
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
