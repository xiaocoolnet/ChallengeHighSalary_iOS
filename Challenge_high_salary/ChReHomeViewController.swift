//
//  ChReHomeViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChReHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let resumeItemArray = ["求职意向","教育背景","工作/实习经历","项目经验","我的优势"]
    let resumeItemStatusArray = ["待完善","完整","完整","待完善","完整"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
    }
    
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        
        self.title = "简历"
        
        let previewBtn = UIButton(frame: CGRectMake(0, 0, 60, 24))
        previewBtn.layer.cornerRadius = 6
        previewBtn.layer.borderColor = UIColor.whiteColor().CGColor
        previewBtn.layer.borderWidth = 1
        previewBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        previewBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        previewBtn.setTitle("预览", forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: previewBtn)
        
        // top imageBgView
        let topBgImageView = UIImageView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height*0.319))
        topBgImageView.userInteractionEnabled = true
        topBgImageView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(topBgImageView)
        
        // header imageview
        let headerImageView = UIImageView(frame: CGRectMake((screenSize.width-screenSize.width*0.16)/2.0, screenSize.height*0.087, screenSize.width*0.16, screenSize.width*0.16))
        headerImageView.layer.cornerRadius = screenSize.width*0.08
        headerImageView.backgroundColor = UIColor.orangeColor()
        topBgImageView.addSubview(headerImageView)
        
        // name Label
        let nameLab = UILabel(frame: CGRectMake(0, 0, 30, 25))
        nameLab.textColor = baseColor
        nameLab.text = "王小妞"
        nameLab.font = UIFont.boldSystemFontOfSize(16)
        nameLab.sizeToFit()
        nameLab.center.x = self.view.center.x
        nameLab.frame.origin.y = CGRectGetMaxY(headerImageView.frame)+10
        topBgImageView.addSubview(nameLab)
        
        // Overview Label
        let overviewLab = UILabel(frame: CGRectMake(0, 0, 30, 25))
        overviewLab.textColor = UIColor(red: 159/255.0, green: 159/255.0, blue: 159/255.0, alpha: 1)
        overviewLab.text = "女 | 1年工作经验 | 北京"
        overviewLab.font = UIFont.systemFontOfSize(14)
        overviewLab.sizeToFit()
        overviewLab.center.x = self.view.center.x
        overviewLab.frame.origin.y = CGRectGetMaxY(nameLab.frame)+10
        topBgImageView.addSubview(overviewLab)
        
        // 编辑 按钮
        let editBtn = UIButton(frame: CGRectMake(CGRectGetMaxX(overviewLab.frame)+5, 0, 25, 25))
        editBtn.backgroundColor = baseColor
        editBtn.center.y = overviewLab.center.y
        editBtn.addTarget(self, action: #selector(clickEditBtn), forControlEvents: .TouchUpInside)
        topBgImageView.addSubview(editBtn)
        
        // TableView
        let myTableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(topBgImageView.frame)+12, screenSize.width, screenSize.height-CGRectGetMaxY(topBgImageView.frame)-49))
        myTableView.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        myTableView.rowHeight = 50
        myTableView.dataSource = self
        myTableView.delegate = self
        
        self.view.addSubview(myTableView)
        // 用于去掉多余Cell的分割线
        let removeRedundantCellSepLine = UIView(frame: CGRectZero)
        myTableView.tableFooterView = removeRedundantCellSepLine
        
    }
    
    // MARK: 点击编辑按钮
    func clickEditBtn() {
        self.navigationController?.pushViewController(CHSReEditPersonalInfoViewController(), animated: true)
    }
    
    // MARK:- tableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resumeItemArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("resumeCell")
        if (cell == nil) {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "resumeCell")
        }
        cell?.selectionStyle = .None
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel?.font = UIFont.boldSystemFontOfSize(16)
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.text = resumeItemArray[indexPath.row]
        
        cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
        cell?.detailTextLabel?.textColor = resumeItemStatusArray[indexPath.row]=="待完善" ? baseColor:UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
        cell?.detailTextLabel?.textAlignment = .Right
        cell?.detailTextLabel?.text = resumeItemStatusArray[indexPath.row]
        
        return cell!
    }
    
    // MARK:- tableView DataSource
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(CHSReJobIntensionViewController(), animated: true)
        }else if indexPath.row == 2 {
            self.navigationController?.pushViewController(CHSReJobExperienceViewController(), animated: true)
        }else if indexPath.row == 3 {
            self.navigationController?.pushViewController(CHSReProjectExperienceViewController(), animated: true)
        }else if indexPath.row == 4 {
            self.navigationController?.pushViewController(CHSReMyAdvantagesViewController(), animated: true)
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
