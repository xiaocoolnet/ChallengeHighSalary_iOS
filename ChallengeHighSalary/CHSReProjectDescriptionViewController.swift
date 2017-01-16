//
//  CHSReProjectDescriptionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/14.
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


protocol CHSReProjectDescriptionDelegate {
    func CHSReProjectDescriptionClickSaveBtn(_ content:String)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
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
        
        self.title = "项目描述"
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
        
        
        if self.myAdvantagesTv.text!.isEmpty {
            
            let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
            checkCodeHud.removeFromSuperViewOnHide = true
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入项目描述"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }
        
        self.delegate?.CHSReProjectDescriptionClickSaveBtn(myAdvantagesTv.text!)

        _ = self.navigationController?.popViewController(animated: true)
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
            myAdvantagesTv.placeholder = "请输入项目描述，5-500字"
            myAdvantagesTv.text = project_description
            myAdvantagesTv.delegate = self
            cell?.contentView.addSubview(myAdvantagesTv)
            
            drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 115), toPoint: CGPoint(x: screenSize.width-8, y: 115), lineWidth: 1/UIScreen.main.scale)
            
        }else{
            
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
            cell?.detailTextLabel?.textColor = baseColor
            cell?.detailTextLabel?.textAlignment = .right
            
            
            
            cell?.detailTextLabel?.attributedText = generateAttributesStr(jobContentMaxCount-myAdvantagesTv.text.characters.count)
            
//            cell?.detailTextLabel?.text = "0/500"
        }
        
        
        return cell!
    }
    
    func generateAttributesStr(_ numStr:Int) -> NSAttributedString {
        
        let nsStr = NSString(string: "还可以输入\(numStr)字")
        let attStr = NSMutableAttributedString(string: "还可以输入\(numStr)字")
        
        attStr.addAttributes([NSForegroundColorAttributeName: baseColor], range: NSMakeRange(0, nsStr.length))
        
        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.black], range: nsStr.range(of: "还可以输入"))
        
        attStr.addAttributes([NSForegroundColorAttributeName: UIColor.black], range: nsStr.range(of: "字"))
        
        return attStr
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
    
    // MARK: 限制输入字数
    let jobContentMaxCount = 500
    
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
