//
//  CHSReChooseIndustryCategoriesViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/12.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

enum FromVCType {
    case intension
    case jobExperience
    case companyInfo
    case `default`
}

class CHSReChooseIndustryCategoriesViewController: UIViewController {
    
    let industryNameArray = ["数据分析","移动产品","电子商务","智能硬件","电子商务","电子商务","智能硬件","智能硬件","项目管理","产品经理","交互设计","APP","用户研究","产品助理","交互设计","游戏策划","产品总监","产品助理","产品助理","在线教育","网页设计","游戏策划","产品总监","游戏策划","产品总监","无线产品","在线教育","网页设计","在线教育","网页设计","无线产品","无线产品","数据分析","移动产品","电子商务","智能硬件","电子商务","电子商务","智能硬件","智能硬件","项目管理","产品经理","交互设计","APP","用户研究","产品助理","交互设计","游戏策划","产品总监","产品助理","产品助理","在线教育","网页设计","游戏策划","产品总监","游戏策划","产品总监","无线产品","在线教育","网页设计","在线教育","网页设计","无线产品","无线产品"]
    
    var navTitle = ""
    
    var vcType:FromVCType = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = navTitle
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-44))
        
        self.view.addSubview(scrollView)
        
        // 设置标签 button
        let industryBtnMargin_x:CGFloat = 10
        let industryBtnMargin_y:CGFloat = 10
        var industryBtnX:CGFloat = industryBtnMargin_x
        var industryBtnY:CGFloat = industryBtnMargin_y
        var industryBtnWidth:CGFloat = 0
        let industryBtnHeight:CGFloat = 30
        
        for (i,industryName) in industryNameArray.enumerated() {
            
            industryBtnWidth = calculateWidth(industryName, size: 15, height: industryBtnHeight)+industryBtnMargin_x*2
            let industryBtn = UIButton(frame: CGRect(x: industryBtnX, y: industryBtnY, width: industryBtnWidth, height: industryBtnHeight))
            industryBtn.tag = 100+i
            industryBtn.layer.cornerRadius = 6
            industryBtn.layer.borderWidth = 1
            industryBtn.layer.borderColor = UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1).cgColor
            industryBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            industryBtn.setTitleColor(UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1), for: UIControlState())
            industryBtn.setTitle(industryName, for: UIControlState())
            industryBtn.setTitleColor(UIColor.white, for: .selected)
            industryBtn.backgroundColor = UIColor.clear
            industryBtn.addTarget(self, action: #selector(industryBtnClick(_:)), for: .touchUpInside)
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
        
        scrollView.contentSize = CGSize(width: 0, height: industryBtnHeight + industryBtnY + industryBtnMargin_y)
        
        let noMyIndustryBtn = UIButton(frame: CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44))
        noMyIndustryBtn.backgroundColor = UIColor.white
        noMyIndustryBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        noMyIndustryBtn.setTitleColor(baseColor, for: UIControlState())
        noMyIndustryBtn.setTitle("我找不到符合的行业", for: UIControlState())
//        noMyIndustryBtn(self, action: #selector(noMyIndustryBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(noMyIndustryBtn)
        
    }
    
    // MARK: 点击 行业
    var flag = false
    
    func industryBtnClick(_ industryBtn: UIButton) {
        
        if flag {return}
        
        industryBtn.isSelected = !industryBtn.isSelected
        if industryBtn.isSelected {
            industryBtn.backgroundColor = baseColor
        }else{
            industryBtn.backgroundColor = UIColor.clear
        }
        
        if self.vcType == .intension {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PersonalChangeJobIntensionNotification"), object: nil, userInfo: ["type":"Categories","value":industryNameArray[industryBtn.tag-100]])

        }else if self.vcType == .jobExperience {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PersonalChangeJobExperienceNotification"), object: nil, userInfo: ["type":"Categories","value":industryNameArray[industryBtn.tag-100]])

        }else if self.vcType == .companyInfo {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PersonalChangeCompanyInfoNotification"), object: nil, userInfo: ["type":"Categories","value":industryNameArray[industryBtn.tag-100]])
            
        }
        
        flag = true
        
        let time: TimeInterval = 0.5
        let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            _ = self.navigationController?.popViewController(animated: true)
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
