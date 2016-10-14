//
//  CHSChCompanyInterviewEvaluationViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/21.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChCompanyInterviewEvaluationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Grouped)
    
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
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.title = "面试评价(2)"
        
        // tableView
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-20-44)
        rootTableView.registerNib(UINib.init(nibName: "CHSChInterviewEvaHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChInterviewHeaderCell")
        rootTableView.registerNib(UINib.init(nibName: "CHSChInterviewEvaTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChInterviewCell")
        rootTableView.rowHeight = 140
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return 10
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CHSChInterviewHeaderCell") as! CHSChInterviewEvaHeaderTableViewCell
            cell.selectionStyle = .None
            
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("CHSChInterviewCell") as! CHSChInterviewEvaTableViewCell
            cell.selectionStyle = .None
            
            
            return cell
        }
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 61
        }else{
            
            let evaTagArray = ["面试官很nice","面试效率高","聊得很开心"]
            let evaContent = "面试过程：公司人员配置目测完善，希望能获得这份工作"
            
            let cityBtnMargin:CGFloat = 10
            var cityBtnX:CGFloat = cityBtnMargin
            var cityBtnY:CGFloat = cityBtnMargin
            var cityBtnWidth:CGFloat = 0
            let cityBtnHeight:CGFloat = 25
            
            for (i,city) in evaTagArray.enumerate() {
                cityBtnWidth = calculateWidth(city, size: 14, height: cityBtnHeight)+cityBtnMargin*4
                
                
                if i+1 < evaTagArray.count {
                    
                    let nextBtnWidth = calculateWidth(evaTagArray[i+1], size: 14, height: cityBtnHeight)+cityBtnMargin*4
                    
                    if cityBtnWidth + cityBtnX + cityBtnMargin + nextBtnWidth >= screenSize.width - 20 {
                        cityBtnX = cityBtnMargin
                        cityBtnY = cityBtnHeight + cityBtnY + cityBtnMargin
                    }else{
                        
                        cityBtnX = cityBtnWidth + cityBtnX + cityBtnMargin
                    }
                }
            }
            
            let evaContentHeight = calculateHeight(evaContent, size: 13, width: screenSize.width-10)

            return 8+40+cityBtnY+cityBtnHeight+cityBtnMargin+evaContentHeight+cityBtnMargin+30+8
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
    }
    
    // MARK:- companyBtnClick
    func companyBtnClick() {
        self.navigationController?.pushViewController(CHSChCompanyHomeViewController(), animated: true)
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
