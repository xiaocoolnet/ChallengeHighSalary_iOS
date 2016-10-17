//
//  LoReFTInfoInputViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/11.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

enum InfoType {
    case Name
    case Position
    case Email
    case CompanyName
    case CompanyNetUrl
    case JobExp_CompanyName
    case Default
}

protocol LoReFTInfoInputViewControllerDelegate {
    func LoReFTInfoInputClickSaveBtn(infoType:InfoType, text:String)
}

class LoReFTInfoInputViewController: UIViewController {
    
    var infoType:InfoType = .Default
    var selfTitle = ""
    var placeHolder = ""
    var tfText = ""
    var tipText = ""
    var hudTipText = ""
    var maxCount = 0
    
    let countLab = UILabel()
    let positionNameTf = UITextField()
    
    var delegate:LoReFTInfoInputViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Compact)
        self.tabBarController?.tabBar.hidden = true
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .Done, target: self, action: #selector(saveBtnClick))
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = selfTitle
        
        let positionNameBgView = UIView(frame: CGRectMake(0, 64+10, screenSize.width, 44))
        positionNameBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(positionNameBgView)
        
        positionNameTf.frame = CGRectMake(8, 0, screenSize.width-16, 44)
        positionNameTf.backgroundColor = UIColor.whiteColor()
        
        positionNameTf.placeholder = placeHolder
        
        positionNameTf.text = tfText
        
        positionNameTf.addTarget(self, action: #selector(positionNameTfValueChanged), forControlEvents: .EditingChanged)
        positionNameBgView.addSubview(positionNameTf)
        
        let tipLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(positionNameTf.frame)+10, screenSize.width*0.8, 30))
        tipLab.textColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
        tipLab.numberOfLines = 0
        tipLab.text = tipText
        tipLab.font = UIFont.systemFontOfSize(14)
        tipLab.frame.size.height = calculateHeight(tipText, size: 14, width: screenSize.width*0.8)
        positionNameBgView.addSubview(tipLab)
        
        countLab.frame = CGRectMake(CGRectGetMaxX(tipLab.frame), CGRectGetMaxY(positionNameTf.frame)+10, screenSize.width-CGRectGetMaxX(tipLab.frame)-8, 30)
        countLab.textAlignment = .Right
        countLab.text = "\((positionNameTf.text?.characters.count)!)/\(maxCount)"
        positionNameBgView.addSubview(countLab)
    }
    
    // MARK: 点击保存按钮
    func saveBtnClick() {
        if self.positionNameTf.text!.isEmpty {
            let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            checkCodeHud.removeFromSuperViewOnHide = true
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = hudTipText
            checkCodeHud.hide(true, afterDelay: 1)
        }else{
            
            self.delegate?.LoReFTInfoInputClickSaveBtn(self.infoType, text: positionNameTf.text!)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: 限制输入字数
    func positionNameTfValueChanged(textField: UITextField) {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = textField.markedTextRange
            if range == nil {
                if textField.text?.characters.count >= maxCount {
                    textField.text = textField.text?.substringToIndex((textField.text?.startIndex.advancedBy(maxCount))!)
                }
            }
        }
        else {
            if textField.text?.characters.count >= maxCount {
                textField.text = textField.text?.substringToIndex((textField.text?.startIndex.advancedBy(maxCount))!)
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
