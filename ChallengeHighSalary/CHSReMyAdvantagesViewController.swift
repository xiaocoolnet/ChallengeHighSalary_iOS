//
//  CHSReMyAdvantagesViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class CHSReMyAdvantagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    let rootTableView = UITableView()
    
    let myAdvantagesTv = UIPlaceHolderTextView()
    
    var othersDrop = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        self.customizeDropDown()
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.title = "我的优势"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.separatorStyle = .none
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if self.myAdvantagesTv.text!.isEmpty {
            
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入优势描述"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        if myAdvantagesTv.text == CHSUserInfo.currentUserInfo.advantage {
            
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "信息未修改"
            checkCodeHud.hide(true, afterDelay: 1)
            
            let time: TimeInterval = 1.0
            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: delay) {
                _ = self.navigationController?.popViewController(animated: true)
            }
            
            return
        }
        
        checkCodeHud.labelText = "正在保存我的优势"
        
        CHSNetUtil().PublishAdvantage(
        CHSUserInfo.currentUserInfo.userid,
        advantage: self.myAdvantagesTv.text!) { (success, response) in
            if success {
                
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "保存我的优势成功"
                checkCodeHud.hide(true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }else{
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "保存我的优势失败"
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
    }
    
    // MARK:- tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "jobContentCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "jobContentCell")
        }
        
        cell?.selectionStyle = .none
        
        if (indexPath as NSIndexPath).row == 0 {
            myAdvantagesTv.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*115)
            myAdvantagesTv.placeholder = "请输入优势描述，1-120字"
            myAdvantagesTv.text = CHSUserInfo.currentUserInfo.advantage == "" ? "":CHSUserInfo.currentUserInfo.advantage
            myAdvantagesTv.delegate = self
            cell?.contentView.addSubview(myAdvantagesTv)
            textViewDidChange(myAdvantagesTv)
            
            drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 115), toPoint: CGPoint(x: screenSize.width-8, y: 115), lineWidth: 1/UIScreen.main.scale)
            
        }else{
            
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell?.textLabel?.textColor = baseColor
            cell?.textLabel?.textAlignment = .left
            cell?.textLabel?.text = "看看别人怎么写"
            
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            cell?.detailTextLabel?.textColor = baseColor
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = "\(self.myAdvantagesTv.text.characters.count)/\(jobContentMaxCount)"
            othersDrop.anchorView = cell
            othersDrop.bottomOffset = CGPoint(x: 8, y: 45)
            othersDrop.width = screenSize.width-16
            othersDrop.direction = .bottom
            
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if (indexPath as NSIndexPath).row == 0 {
            return 116
        }else if (indexPath as NSIndexPath).row == 1 {
            return 40
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row == 1 {
            _ = othersDrop.show()
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
        appearance.textColor = .darkGray
        appearance.textFont = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: 限制输入字数
    let jobContentMaxCount = 120
    
    func textViewDidChange(_ textView: UITextView) {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = textView.markedTextRange
            if range == nil {
                if textView.text?.characters.count >= jobContentMaxCount {
                    textView.text = textView.text?.substring(to: (textView.text?.characters.index((textView.text?.startIndex)!, offsetBy: jobContentMaxCount))!)
                }
            }
        }
        else {
            if textView.text?.characters.count >= jobContentMaxCount {
                textView.text = textView.text?.substring(to: (textView.text?.characters.index((textView.text?.startIndex)!, offsetBy: jobContentMaxCount))!)
            }
        }
        
        let cell = rootTableView.cellForRow(at: IndexPath(row: 1, section: 0))
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
