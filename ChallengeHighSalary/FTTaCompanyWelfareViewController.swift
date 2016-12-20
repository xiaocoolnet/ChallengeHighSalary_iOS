//
//  FTTaCompanyWelfareViewController.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/11/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaCompanyWelfareViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    let rootTableView = UITableView()
    let jobDescriptionTv = UIPlaceHolderTextView()
    
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = "公司福利"
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
        
        if self.jobDescriptionTv.text!.isEmpty {
            let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
            checkCodeHud.removeFromSuperViewOnHide = true
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入公司福利描述"
            checkCodeHud.hide(animated: true, afterDelay: 1)
        }else{
            var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
            FTPublishJobSelectedNameArray[3][3] = self.jobDescriptionTv.text!
            UserDefaults.standard.setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
            
            _ = self.navigationController?.popViewController(animated: true)
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
            jobDescriptionTv.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*115)
            jobDescriptionTv.placeholder = "请输入公司福利描述"
            
            var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
            if FTPublishJobSelectedNameArray[3][3] != "公司福利" {
                jobDescriptionTv.text = FTPublishJobSelectedNameArray[3][2]
            }
            
            jobDescriptionTv.delegate = self
            //            myAdvantagesTv.addTarget(self, action: #selector(positionNameTfValueChanged), forControlEvents: .EditingChanged)
            
            cell?.contentView.addSubview(jobDescriptionTv)
            
            drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 115), toPoint: CGPoint(x: screenSize.width-8, y: 115), lineWidth: 1/UIScreen.main.scale)
            
        }else{
            
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell?.textLabel?.textColor = baseColor
            cell?.textLabel?.textAlignment = .left
            cell?.textLabel?.text = "看看别人怎么写"
            
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            cell?.detailTextLabel?.textColor = baseColor
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = "\((jobDescriptionTv.text?.characters.count)!)/\(maxCount)"
            othersDrop.anchorView = cell
            othersDrop.bottomOffset = CGPoint(x: 8, y: 45)
            othersDrop.width = screenSize.width-16
            othersDrop.direction = .bottom
            
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
    
    // MARK: 限制输入字数
    let maxCount = 50
    
    func positionNameTfValueChanged() {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = self.jobDescriptionTv.markedTextRange
            if range == nil {
                if (self.jobDescriptionTv.text?.characters.count ?? 0)! >= maxCount {
                    self.jobDescriptionTv.text = self.jobDescriptionTv.text?.substring(to: (self.jobDescriptionTv.text?.characters.index((self.jobDescriptionTv.text?.startIndex)!, offsetBy: maxCount))!)
                }
            }
        }
        else {
            if (self.jobDescriptionTv.text?.characters.count ?? 0)! >= maxCount {
                self.jobDescriptionTv.text = self.jobDescriptionTv.text?.substring(to: (self.jobDescriptionTv.text?.characters.index((self.jobDescriptionTv.text?.startIndex)!, offsetBy: maxCount))!)
            }
        }
        
        let cell = rootTableView.cellForRow(at: IndexPath(row: 1, section: 0))
        cell?.detailTextLabel?.text = "\((self.jobDescriptionTv.text?.characters.count)!)/\(maxCount)"
    }
    
    func textViewDidChange(_ textView: UITextView) {
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
        appearance.textColor = .darkGray
        appearance.textFont = UIFont.systemFont(ofSize: 14)
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
