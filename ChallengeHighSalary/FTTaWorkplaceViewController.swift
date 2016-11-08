//
//  FTTaWorkplaceViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/8.
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


class FTTaWorkplaceViewController: UIViewController {
    
    let countLab = UILabel()
    let positionNameTf = UITextField()
    
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
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .done, target: self, action: #selector(saveBtnClick))
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "工作地点"
        
        let positionNameBgView = UIView(frame: CGRect(x: 0, y: 64+10, width: screenSize.width, height: 44))
        positionNameBgView.backgroundColor = UIColor.white
        self.view.addSubview(positionNameBgView)
        
        positionNameTf.frame = CGRect(x: 8, y: 0, width: screenSize.width-16, height: 44)
        positionNameTf.backgroundColor = UIColor.white
        
        positionNameTf.placeholder = "请输入工作地点"
        
        var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
        if FTPublishJobSelectedNameArray[3][1] != "工作地点" {
            positionNameTf.text = FTPublishJobSelectedNameArray[3][1]
        }
        
        positionNameTf.addTarget(self, action: #selector(positionNameTfValueChanged), for: .editingChanged)
        positionNameBgView.addSubview(positionNameTf)
        
        let tipLab = UILabel(frame: CGRect(x: 8, y: positionNameTf.frame.maxY+10, width: screenSize.width*0.6, height: 30))
        tipLab.textColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
        tipLab.text = "请填写您的工作地点"
        tipLab.font = UIFont.systemFont(ofSize: 14)
        positionNameBgView.addSubview(tipLab)
        
        countLab.frame = CGRect(x: tipLab.frame.maxX, y: positionNameTf.frame.maxY+10, width: screenSize.width-tipLab.frame.maxX-8, height: 30)
        countLab.textAlignment = .right
        countLab.text = "\((positionNameTf.text?.characters.count)!)/50"
        positionNameBgView.addSubview(countLab)
    }
    
    // MARK: 点击保存按钮
    func saveBtnClick() {
        if self.positionNameTf.text!.isEmpty {
            let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
            checkCodeHud.removeFromSuperViewOnHide = true
            
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请输入工作地点"
            checkCodeHud.hide(true, afterDelay: 1)
        }else{
            var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
            FTPublishJobSelectedNameArray[3][1] = self.positionNameTf.text!
            UserDefaults.standard.setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: 限制输入字数
    let maxCount = 50
    
    func positionNameTfValueChanged(_ textField: UITextField) {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = textField.markedTextRange
            if range == nil {
                if textField.text?.characters.count >= maxCount {
                    textField.text = textField.text?.substring(to: (textField.text?.characters.index((textField.text?.startIndex)!, offsetBy: maxCount))!)
                }
            }
        }
        else {
            if textField.text?.characters.count >= maxCount {
                textField.text = textField.text?.substring(to: (textField.text?.characters.index((textField.text?.startIndex)!, offsetBy: maxCount))!)
            }
        }
        countLab.text = "\((textField.text?.characters.count)!)/\(maxCount)"
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
