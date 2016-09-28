//
//  CHSChCompanyHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSChCompanyHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let rootTableView = UITableView()
    let companyNoteStr = "如果你无法简洁的表达你的想法，那只说明你还不够了解它。64d99164d991       如果你无法简洁的表达你的想法，那只说明你还不够了解它。       如果你无法简洁的表达你的想法，那只说明你还不够了解它。"
    var productNoteStr = "如果你无法简洁的表达你的想法，那只说明你还不够了解它。64d99164d991       如果你无法简洁的表达你的想法，那只说明你还不够了解它。       如果你无法简洁的表达你的想法，那只说明你还不够了解它。"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.title = "公司主页"

        self.view.backgroundColor = UIColor.whiteColor()
        
        rootTableView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height-45)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.separatorStyle = .None
        rootTableView.registerNib(UINib(nibName: "CHSChCompanyPositionTableViewCell", bundle: nil), forCellReuseIdentifier: "CHSChCompanyPositionCell")
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(rootTableView)
        
        setHeaderView()
        
        let backBtn = UIButton(frame: CGRectMake(8, 28, kHeightScale*25, kHeightScale*25))
//        backBtn.backgroundColor = baseColor
        backBtn.setImage(UIImage(named: "ic_返回_green"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(backBtn)
        
        let interviewEvaluateBtn = UIButton(frame: CGRectMake(0, screenSize.height-45, screenSize.width, 45))
        interviewEvaluateBtn.backgroundColor = baseColor
        interviewEvaluateBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        interviewEvaluateBtn.setTitle("面试评价(2)", forState: .Normal)
        interviewEvaluateBtn.addTarget(self, action: #selector(interviewEvaluateBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(interviewEvaluateBtn)
    }
    
    // MARK:- backBtn 点击事件
    func backBtnClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- interviewEvaluateBtn 点击事件
    func interviewEvaluateBtnClick() {
        self.navigationController?.pushViewController(CHSChCompanyInterviewEvaluationViewController(), animated: true)
    }
    
    // MARK:- 设置tableview 头视图
    func setHeaderView() {
        let headerView = UIView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*270))
        headerView.backgroundColor = UIColor.whiteColor()
        
        let headerBgImgView = UIImageView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*180))
        headerBgImgView.backgroundColor = UIColor.orangeColor()
        headerView.addSubview(headerBgImgView)
        
        let headerImgView = UIImageView(frame: CGRectMake(0, kHeightScale*155, kHeightScale*60, kHeightScale*60))
        headerImgView.layer.cornerRadius = headerImgView.frame.size.width/2.0
        headerImgView.backgroundColor = UIColor.grayColor()
        headerImgView.center.x = self.view.center.x
        headerView.addSubview(headerImgView)
        
        let companyNameLab = UILabel(frame: CGRectMake(0, CGRectGetMaxY(headerImgView.frame)+kHeightScale*15, screenSize.width, kHeightScale*20))
        companyNameLab.textAlignment = .Center
        companyNameLab.textColor = baseColor
        companyNameLab.font = UIFont.systemFontOfSize(14)
        companyNameLab.text = "北京互联科技有限公司"
        headerView.addSubview(companyNameLab)
        
        let companyNoteLab = UILabel(frame: CGRectMake(0, CGRectGetMaxY(companyNameLab.frame), screenSize.width, kHeightScale*20))
        companyNoteLab.textAlignment = .Center
        companyNoteLab.textColor = UIColor(red: 116/255.0, green: 116/255.0, blue: 116/255.0, alpha: 1)
        companyNoteLab.font = UIFont.systemFontOfSize(13)
        companyNoteLab.text = "移动互联网，企业服务/未融资/20-30人"
        headerView.addSubview(companyNoteLab)
        
        self.rootTableView.tableHeaderView = headerView
    }
    
    // MARK:- tableview datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 5
        }else{
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CHSChCompanyPositionCell") as! CHSChCompanyPositionTableViewCell
            cell.selectionStyle = .None
            return cell
        }else{
            
            var cell = tableView.dequeueReusableCellWithIdentifier("companyHomeCell")
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: "companyHomeCell")
            }
            cell!.selectionStyle = .None
            
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = UIFont.systemFontOfSize(13)
            if indexPath.section == 0 {
                cell?.textLabel?.text = "\t"+companyNoteStr
            }else if indexPath.section == 1 {
                cell?.textLabel?.text = "\t"+productNoteStr
            }
            
            return cell!
        }
    }
    
    // MARK:- tableview delegate
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            return calculateHeight(companyNoteStr, size: 14, width: screenSize.width-16)+20
        case (1,0):
            return calculateHeight(productNoteStr, size: 14, width: screenSize.width-16)+20
        default:
            return 146
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let sectionHeaderView = UIView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*35))
            sectionHeaderView.backgroundColor = UIColor.whiteColor()
            
            let sectionHeaderLab = UILabel(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*35))
            sectionHeaderLab.font = UIFont.systemFontOfSize(14)
            sectionHeaderLab.textColor = baseColor
            sectionHeaderLab.text = "公司介绍"
            sectionHeaderLab.sizeToFit()
            sectionHeaderLab.center = sectionHeaderView.center
            sectionHeaderView.addSubview(sectionHeaderLab)
            
            let leftLine = UIView(frame: CGRectMake(8, kHeightScale*17, CGRectGetMinX(sectionHeaderLab.frame)-16, 1))
            leftLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(leftLine)
            
            let rightLine = UIView(frame: CGRectMake(CGRectGetMaxX(sectionHeaderLab.frame)+8, kHeightScale*17, CGRectGetMinX(sectionHeaderLab.frame)-16, 1))
            rightLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(rightLine)
            
            return sectionHeaderView
        }else if section == 1 {
            let sectionHeaderView = UIView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*35))
            sectionHeaderView.backgroundColor = UIColor.whiteColor()
            
            let sectionHeaderLab = UILabel(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*35))
            sectionHeaderLab.font = UIFont.systemFontOfSize(14)
            sectionHeaderLab.textColor = baseColor
            sectionHeaderLab.text = "产品介绍"
            sectionHeaderLab.sizeToFit()
            sectionHeaderLab.center = sectionHeaderView.center
            sectionHeaderView.addSubview(sectionHeaderLab)

            let leftLine = UIView(frame: CGRectMake(8, kHeightScale*17, CGRectGetMinX(sectionHeaderLab.frame)-16, 1))
            leftLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(leftLine)
            
            let rightLine = UIView(frame: CGRectMake(CGRectGetMaxX(sectionHeaderLab.frame)+8, kHeightScale*17, CGRectGetMinX(sectionHeaderLab.frame)-16, 1))
            rightLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(rightLine)
            
            return sectionHeaderView
        }else if section == 2 {
            let sectionHeaderView = UIView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*35))
            sectionHeaderView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
            
            let sectionHeaderLab = UILabel(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*35))
            sectionHeaderLab.font = UIFont.systemFontOfSize(14)
            sectionHeaderLab.textColor = baseColor
            sectionHeaderLab.text = "热招职位"
            sectionHeaderLab.sizeToFit()
            sectionHeaderLab.center = sectionHeaderView.center
            sectionHeaderView.addSubview(sectionHeaderLab)
            
            let leftLine = UIView(frame: CGRectMake(8, kHeightScale*17, CGRectGetMinX(sectionHeaderLab.frame)-16, 1))
            leftLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(leftLine)
            
            let rightLine = UIView(frame: CGRectMake(CGRectGetMaxX(sectionHeaderLab.frame)+8, kHeightScale*17, CGRectGetMinX(sectionHeaderLab.frame)-16, 1))
            rightLine.backgroundColor = UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1)
            sectionHeaderView.addSubview(rightLine)
            
            return sectionHeaderView
        }
    
        return UIView()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kHeightScale*35
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            self.navigationController?.pushViewController(CHSChPersonalInfoViewController(), animated: true)
        }
    }
    
    // MARK: scrollview delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 64 {
            UIView.animateWithDuration(0.5, animations: { 
                
                self.navigationController?.navigationBar.hidden = false
            })
        }else{
            UIView.animateWithDuration(0.5, animations: {
                
                self.navigationController?.navigationBar.hidden = true
            })
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
