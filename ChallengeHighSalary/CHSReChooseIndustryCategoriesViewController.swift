//
//  CHSReChooseIndustryCategoriesViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

enum FromVCType {
    case Intension
    case JobExperience
    case Default
}

class CHSReChooseIndustryCategoriesViewController: UIViewController {
    
    let industryNameArray = ["数据分析","移动产品","电子商务","智能硬件","电子商务","电子商务","智能硬件","智能硬件","项目管理","产品经理","交互设计","APP","用户研究","产品助理","交互设计","游戏策划","产品总监","产品助理","产品助理","在线教育","网页设计","游戏策划","产品总监","游戏策划","产品总监","无线产品","在线教育","网页设计","在线教育","网页设计","无线产品","无线产品","数据分析","移动产品","电子商务","智能硬件","电子商务","电子商务","智能硬件","智能硬件","项目管理","产品经理","交互设计","APP","用户研究","产品助理","交互设计","游戏策划","产品总监","产品助理","产品助理","在线教育","网页设计","游戏策划","产品总监","游戏策划","产品总监","无线产品","在线教育","网页设计","在线教育","网页设计","无线产品","无线产品"]
    
    var navTitle = ""
    
    var vcType:FromVCType = .Default
    
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
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = navTitle
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64-44))
        
        self.view.addSubview(scrollView)
        
        // 设置标签 button
        let industryBtnMargin_x:CGFloat = 10
        let industryBtnMargin_y:CGFloat = 10
        var industryBtnX:CGFloat = industryBtnMargin_x
        var industryBtnY:CGFloat = industryBtnMargin_y
        var industryBtnWidth:CGFloat = 0
        let industryBtnHeight:CGFloat = 30
        
        for (i,industryName) in industryNameArray.enumerate() {
            
            industryBtnWidth = calculateWidth(industryName, size: 15, height: industryBtnHeight)+industryBtnMargin_x*2
            let industryBtn = UIButton(frame: CGRectMake(industryBtnX, industryBtnY, industryBtnWidth, industryBtnHeight))
            industryBtn.tag = 100+i
            industryBtn.layer.cornerRadius = 6
            industryBtn.layer.borderWidth = 1
            industryBtn.layer.borderColor = UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1).CGColor
            industryBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
            industryBtn.setTitleColor(UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1), forState: .Normal)
            industryBtn.setTitle(industryName, forState: .Normal)
            industryBtn.setTitleColor(UIColor.whiteColor(), forState: .Selected)
            industryBtn.backgroundColor = UIColor.clearColor()
            industryBtn.addTarget(self, action: #selector(industryBtnClick(_:)), forControlEvents: .TouchUpInside)
            scrollView.addSubview(industryBtn)
            
            if i+1 < industryNameArray.count {
                
                let nextBtnWidth = calculateWidth(industryNameArray[i+1], size: 14, height: industryBtnHeight)+industryBtnMargin_x*4
                
                if industryBtnWidth + industryBtnX + industryBtnMargin_x + nextBtnWidth >= screenSize.width - industryBtnMargin_x*2 {
                    industryBtnX = industryBtnMargin_x
                    industryBtnY = industryBtnHeight + industryBtnY + industryBtnMargin_y
                }else{
                    
                    industryBtnX = industryBtnWidth + industryBtnX + industryBtnMargin_x
                }
            }
        }
        
        scrollView.contentSize = CGSizeMake(0, industryBtnHeight + industryBtnY + industryBtnMargin_y)
        
        let noMyIndustryBtn = UIButton(frame: CGRectMake(0, screenSize.height-44, screenSize.width, 44))
        noMyIndustryBtn.backgroundColor = UIColor.whiteColor()
        noMyIndustryBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        noMyIndustryBtn.setTitleColor(baseColor, forState: .Normal)
        noMyIndustryBtn.setTitle("我找不到符合的行业", forState: .Normal)
//        noMyIndustryBtn(self, action: #selector(noMyIndustryBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(noMyIndustryBtn)
        
    }
    
    // MARK: 点击 行业
    var flag = false
    
    func industryBtnClick(industryBtn: UIButton) {
        
        if flag {return}
        
        industryBtn.selected = !industryBtn.selected
        if industryBtn.selected {
            industryBtn.backgroundColor = baseColor
        }else{
            industryBtn.backgroundColor = UIColor.clearColor()
        }
        
        if self.vcType == .Intension {
            NSNotificationCenter.defaultCenter().postNotificationName("PersonalChangeJobIntensionNotification", object: nil, userInfo: ["type":"Categories","value":industryNameArray[industryBtn.tag-100]])

        }else if self.vcType == .JobExperience {
            NSNotificationCenter.defaultCenter().postNotificationName("PersonalChangeJobExperienceNotification", object: nil, userInfo: ["type":"Categories","value":industryNameArray[industryBtn.tag-100]])

        }
        
        flag = true
        
        let time: NSTimeInterval = 0.5
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
        
        dispatch_after(delay, dispatch_get_main_queue()) {
            self.navigationController?.popViewControllerAnimated(true)
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
