//
//  CHSReProjectDescriptionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/14.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

protocol CHSReProjectDescriptionDelegate {
    func CHSReProjectDescriptionClickSaveBtn(content:String)
}

class CHSReProjectDescriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    let rootTableView = UITableView()
    
    let myAdvantagesTv = UIPlaceHolderTextView()
        
    var delegate : CHSReProjectDescriptionDelegate?
    
    var project_description = ""
    
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
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.title = "项目描述"
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
        
        
        if self.myAdvantagesTv.text!.isEmpty {
            
            let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            checkCodeHud.removeFromSuperViewOnHide = true
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入项目描述"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        self.delegate?.CHSReProjectDescriptionClickSaveBtn(myAdvantagesTv.text!)

        self.navigationController?.popViewControllerAnimated(true)
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
            myAdvantagesTv.placeholder = "请输入项目描述，5-500字"
            myAdvantagesTv.text = project_description
            myAdvantagesTv.delegate = self
            cell?.contentView.addSubview(myAdvantagesTv)
            
            drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 115), toPoint: CGPointMake(screenSize.width-8, 115), lineWidth: 1/UIScreen.mainScreen().scale)
            
        }else{
            
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
            cell?.detailTextLabel?.textColor = baseColor
            cell?.detailTextLabel?.textAlignment = .Right
            
            
            
            cell?.detailTextLabel?.attributedText = generateAttributesStr(jobContentMaxCount-myAdvantagesTv.text.characters.count)
            
//            cell?.detailTextLabel?.text = "0/500"
        }
        
        
        return cell!
    }
    
    func generateAttributesStr(numStr:Int) -> NSAttributedString {
        
        let nsStr = NSString(string: "还可以输入\(numStr)字")
        let attStr = NSMutableAttributedString(string: "还可以输入\(numStr)字")
        
        attStr.addAttributes([NSForegroundColorAttributeName: baseColor], range: NSMakeRange(0, nsStr.length))
        
        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], range: nsStr.rangeOfString("还可以输入"))
        
        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.blackColor()], range: nsStr.rangeOfString("字"))
        
        return attStr
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
    
    // MARK: 限制输入字数
    let jobContentMaxCount = 500
    
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
        cell?.detailTextLabel?.attributedText = generateAttributesStr(jobContentMaxCount-myAdvantagesTv.text.characters.count)
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
