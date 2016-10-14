//
//  FTTaJobDescriptionsViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaJobDescriptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    let rootTableView = UITableView()
    let jobDescriptionTv = UIPlaceHolderTextView()
    
    var othersDrop = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
        
        self.customizeDropDown()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.title = "职位描述"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .Done, target: self, action: #selector(clickSaveBtn))
        
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
        
        if self.jobDescriptionTv.text!.isEmpty {
            let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            checkCodeHud.removeFromSuperViewOnHide = true
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入职位描述"
            checkCodeHud.hide(true, afterDelay: 1)
        }else{
            var FTPublishJobSelectedNameArray = NSUserDefaults.standardUserDefaults().arrayForKey(FTPublishJobSelectedNameArray_key) as! [Array<String>]
            FTPublishJobSelectedNameArray[3][2] = self.jobDescriptionTv.text!
            NSUserDefaults.standardUserDefaults().setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK:- tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("jobContentCell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "jobContentCell")
        }
        
        cell?.selectionStyle = .None
        
        if indexPath.row == 0 {
            jobDescriptionTv.frame = CGRectMake(0, 0, screenSize.width, kHeightScale*115)
            jobDescriptionTv.placeholder = "请输入职位描述"
            
            var FTPublishJobSelectedNameArray = NSUserDefaults.standardUserDefaults().arrayForKey(FTPublishJobSelectedNameArray_key) as! [Array<String>]
            if FTPublishJobSelectedNameArray[3][2] != "职位描述" {
                jobDescriptionTv.text = FTPublishJobSelectedNameArray[3][2]
            }
            
            jobDescriptionTv.delegate = self
//            myAdvantagesTv.addTarget(self, action: #selector(positionNameTfValueChanged), forControlEvents: .EditingChanged)

            cell?.contentView.addSubview(jobDescriptionTv)
            
            drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 115), toPoint: CGPointMake(screenSize.width-8, 115), lineWidth: 1/UIScreen.mainScreen().scale)
            
        }else{
            
            cell?.textLabel?.font = UIFont.systemFontOfSize(13)
            cell?.textLabel?.textColor = baseColor
            cell?.textLabel?.textAlignment = .Left
            cell?.textLabel?.text = "看看别人怎么写"
            
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
            cell?.detailTextLabel?.textColor = baseColor
            cell?.detailTextLabel?.textAlignment = .Right
            cell?.detailTextLabel?.text = "\((jobDescriptionTv.text?.characters.count)!)/\(maxCount)"
            othersDrop.anchorView = cell
            othersDrop.bottomOffset = CGPoint(x: 8, y: 45)
            othersDrop.width = screenSize.width-16
            othersDrop.direction = .Bottom
            
            othersDrop.dataSource = ["不限","1万以下","1~2万","2~3万","3~4万","4~5万","5万以上"]
            
            // 下拉列表选中后的回调方法
            othersDrop.selectionAction = { (index, item) in
                
                self.jobDescriptionTv.text = item
                self.positionNameTfValueChanged()
            }
        }
        
        
        return cell!
    }
    
    // MARK:- tableView delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 116
        }else if indexPath.row == 1 {
            return 40
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            othersDrop.show()
        }
    }
    
    // MARK: 限制输入字数
    let maxCount = 120
    
    func positionNameTfValueChanged() {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = self.jobDescriptionTv.markedTextRange
            if range == nil {
                if self.jobDescriptionTv.text?.characters.count >= maxCount {
                    self.jobDescriptionTv.text = self.jobDescriptionTv.text?.substringToIndex((self.jobDescriptionTv.text?.startIndex.advancedBy(maxCount))!)
                }
            }
        }
        else {
            if self.jobDescriptionTv.text?.characters.count >= maxCount {
                self.jobDescriptionTv.text = self.jobDescriptionTv.text?.substringToIndex((self.jobDescriptionTv.text?.startIndex.advancedBy(maxCount))!)
            }
        }
        
        let cell = rootTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))
        cell?.detailTextLabel?.text = "\((self.jobDescriptionTv.text?.characters.count)!)/\(maxCount)"
    }
    
    func textViewDidChange(textView: UITextView) {
        positionNameTfValueChanged()
    }
    // MARK:自定义下拉列表样式
    func customizeDropDown() {
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 45
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadiu = 6
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 6
        appearance.animationduration = 0.25
        appearance.textColor = .darkGrayColor()
        appearance.textFont = UIFont.systemFontOfSize(14)
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
