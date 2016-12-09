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
    
    var industryNameArray = [String]()
    
    var navTitle = ""
    
    var vcType:FromVCType = .default
    
    var industryStr = CHSCompanyInfo.currentCompanyInfo.industry
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if industryNameArray.count == 0 {
            loadData()
        }
    }
    
    // MARK: 加载数据
    func loadData() {
                
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.removeFromSuperViewOnHide = true
        hud?.margin = 10
        hud?.labelText = "正在获取公司行业"
        
        PublicNetUtil().getDictionaryList(parentid: "18") { (success, response) in
            if success {
                
                hud?.hide(true)
                
                self.industryNameArray = []
                let dicData = response as! [DicDataModel]
                for dic in dicData {
                    self.industryNameArray.append(dic.name!)
                }
                if !self.industryNameArray.contains(self.industryStr) {
                    self.industryNameArray.append(self.industryStr)
                }
                self.setIndustry()
                
            }else{
                hud?.mode = .text
                hud?.labelText = "公司行业获取失败"
                hud?.hide(true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    
                    _ = self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
        
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
        
        let noMyIndustryBtn = UIButton(frame: CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44))
        noMyIndustryBtn.backgroundColor = UIColor.white
        noMyIndustryBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        noMyIndustryBtn.setTitleColor(baseColor, for: UIControlState())
        noMyIndustryBtn.setTitle("我找不到符合的行业", for: UIControlState())
        noMyIndustryBtn.addTarget(self, action: #selector(noMyIndustryBtnClick), for: .touchUpInside)
        self.view.addSubview(noMyIndustryBtn)
        
    }
    
    // MARK: - 找不到符合行业点击事件
    func noMyIndustryBtnClick() {
        let alert = UIAlertController(title: nil, message: "输入标签不超过10个字", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .default, handler: { (sureAction) in
            if (alert.textFields?.first?.text)! == "" {
                return
            }
            self.industryNameArray.append((alert.textFields?.first?.text)!)
            self.setIndustry(isAdd: true)
        })
        alert.addAction(sureAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - 设置行业
    func setIndustry(isAdd:Bool = false) {
        
        self.view.viewWithTag(12345)?.removeFromSuperview()
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-44))
        scrollView.tag = 12345
        
        self.view.addSubview(scrollView)
        
//        var noIndustry = true
        
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
            
            if industryName == self.industryStr {
                industryBtn.backgroundColor = baseColor
                industryBtn.isSelected = true
//                noIndustry = false
            }
            
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
        
        if isAdd {
            self.industryBtnClick(scrollView.viewWithTag(100+industryNameArray.count-1) as! UIButton)
        }
    }
    
    // MARK: 点击 行业
    var flag = false
    
    func industryBtnClick(_ industryBtn: UIButton) {
        
        if flag {return}
        
        let scrollView = self.view.viewWithTag(12345)
        for subView in (scrollView?.subviews)! {
            if subView.tag >= 100 && subView.tag < industryNameArray.count+100 {
                (subView as! UIButton).isSelected = false
                subView.backgroundColor = UIColor.clear
            }
        }
        
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
