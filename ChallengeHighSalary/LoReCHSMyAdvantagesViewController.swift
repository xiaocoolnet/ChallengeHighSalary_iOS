//
//  LoReCHSMyAdvantagesViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/14.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReCHSMyAdvantagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    let rootTableView = UITableView()
    
    let myAdvantagesTv = UIPlaceHolderTextView()
    
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
        
        self.title = "我的优势"
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.separatorStyle = .None
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        
        let postPositionBtn = UIButton(frame: CGRectMake(0, screenSize.height-44, screenSize.width, 44))
        postPositionBtn.backgroundColor = baseColor
        postPositionBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        postPositionBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        postPositionBtn.setTitle("下一步", forState: .Normal)
        postPositionBtn.addTarget(self, action: #selector(clickSaveBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(postPositionBtn)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if self.myAdvantagesTv.text!.isEmpty {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入优势描述"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        checkCodeHud.labelText = "正在保存我的优势"
        
        CHSNetUtil().PublishAdvantage(
            CHSUserInfo.currentUserInfo.userid,
            advantage: self.myAdvantagesTv.text!) { (success, response) in
                if success {
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "保存我的优势成功"
                    checkCodeHud.hide(true, afterDelay: 1)
                    
                    let time: NSTimeInterval = 1.0
                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                    
                    dispatch_after(delay, dispatch_get_main_queue()) {
                        self.navigationController?.pushViewController(LoReCHSJobIntensionViewController(), animated: true)
                    }
                }else{
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "保存我的优势失败"
                    checkCodeHud.hide(true, afterDelay: 1)
                }
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
            myAdvantagesTv.frame = CGRectMake(0, 0, screenSize.width, kHeightScale*115)
            myAdvantagesTv.placeholder = "请输入优势描述，1-120字"
            myAdvantagesTv.text = CHSUserInfo.currentUserInfo.advantage == "" ? "":CHSUserInfo.currentUserInfo.advantage
            myAdvantagesTv.delegate = self
            cell?.contentView.addSubview(myAdvantagesTv)
            textViewDidChange(myAdvantagesTv)
            
            drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 115), toPoint: CGPointMake(screenSize.width-8, 115), lineWidth: 1/UIScreen.mainScreen().scale)
            
        }else{
            
            cell?.textLabel?.font = UIFont.systemFontOfSize(13)
            cell?.textLabel?.textColor = baseColor
            cell?.textLabel?.textAlignment = .Left
            cell?.textLabel?.text = "看看别人怎么写"
            
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
            cell?.detailTextLabel?.textColor = baseColor
            cell?.detailTextLabel?.textAlignment = .Right
            cell?.detailTextLabel?.text = "\(self.myAdvantagesTv.text.characters.count)/\(jobContentMaxCount)"
            othersDrop.anchorView = cell
            othersDrop.bottomOffset = CGPoint(x: 8, y: 45)
            othersDrop.width = screenSize.width-16
            othersDrop.direction = .Bottom
            
            othersDrop.dataSource = ["不限","1万以下","1~2万","2~3万","3~4万","4~5万","5万以上"]
            
            // 下拉列表选中后的回调方法
            othersDrop.selectionAction = { (index, item) in
                
                self.myAdvantagesTv.text = item
                self.textViewDidChange(self.myAdvantagesTv)
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
    
    // MARK: 限制输入字数
    let jobContentMaxCount = 120
    
    func textViewDidChange(textView: UITextView) {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = textView.markedTextRange
            if range == nil {
                if textView.text?.characters.count >= jobContentMaxCount {
                    textView.text = textView.text?.substringToIndex((textView.text?.startIndex.advancedBy(jobContentMaxCount))!)
                }
            }
        }
        else {
            if textView.text?.characters.count >= jobContentMaxCount {
                textView.text = textView.text?.substringToIndex((textView.text?.startIndex.advancedBy(jobContentMaxCount))!)
            }
        }
        
        let cell = rootTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))
        cell?.detailTextLabel?.text = "\(self.myAdvantagesTv.text.characters.count)/\(jobContentMaxCount)"
        cell?.detailTextLabel?.sizeToFit()
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
