//
//  CHSReEditEduExperienceViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReEditEduExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let rootTableView = UITableView()
    
    let nameArray = ["公司名称","公司行业","职位类型","技能展示","任职时间段"]
    let detailArray = ["请输入公司名称","选择行业","选择职位类型","请选择技能","选择任职时间段"]
    
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
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "编写工作经历"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.separatorStyle = .None
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return nameArray.count
        }else{
            return 2
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("jobExperience")
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "jobExperience")
            }
            
            cell?.selectionStyle = .None
            
            cell?.accessoryType = .DisclosureIndicator
            cell?.textLabel?.font = UIFont.systemFontOfSize(16)
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell?.textLabel?.textAlignment = .Left
            cell?.textLabel?.text = nameArray[indexPath.row]
            
            if indexPath.row == 0 {
                
                let companyNameTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
                companyNameTf.font = UIFont.systemFontOfSize(14)
                companyNameTf.placeholder = detailArray[indexPath.row]
                companyNameTf.textAlignment = .Right
                cell?.accessoryView = companyNameTf
            }else{
                
                
                cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
                cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                cell?.detailTextLabel?.textAlignment = .Right
                cell?.detailTextLabel?.text = detailArray[indexPath.row]
            }
            
            if indexPath.row < nameArray.count-1 {
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 59), toPoint: CGPointMake(screenSize.width-8, 59), lineWidth: 1/UIScreen.mainScreen().scale)
            }
            
            return cell!
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("jobContentCell")
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "jobContentCell")
            }
            
            cell?.selectionStyle = .None
            
            if indexPath.row == 0 {
                let jobContentTv = UITextView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*115))
                cell?.contentView.addSubview(jobContentTv)
                
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 115), toPoint: CGPointMake(screenSize.width-8, 115), lineWidth: 1/UIScreen.mainScreen().scale)
                
            }else{
                
                cell?.textLabel?.font = UIFont.systemFontOfSize(13)
                cell?.textLabel?.textColor = baseColor
                cell?.textLabel?.textAlignment = .Left
                cell?.textLabel?.text = "看看别人怎么写"
                
                cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
                cell?.detailTextLabel?.textColor = baseColor
                cell?.detailTextLabel?.textAlignment = .Right
                cell?.detailTextLabel?.text = "0/300"
            }
            
            
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "教育经历"
        }else if section == 1{
            return "在校经历"
        }else{
            return nil
        }
    }
    
    // MARK:- tableView delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 60
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 116
            }else if indexPath.row == 1 {
                return 40
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
