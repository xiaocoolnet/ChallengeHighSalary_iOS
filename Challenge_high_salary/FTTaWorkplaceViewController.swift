//
//  FTTaWorkplaceViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/10/8.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaWorkplaceViewController: UIViewController {
    
    let countLab = UILabel()
    let positionNameTf = UITextField()
    
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
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .Done, target: self, action: #selector(saveBtnClick))
        
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "工作地点"
        
        let positionNameBgView = UIView(frame: CGRectMake(0, 64+10, screenSize.width, 44))
        positionNameBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(positionNameBgView)
        
        positionNameTf.frame = CGRectMake(8, 0, screenSize.width-16, 44)
        positionNameTf.backgroundColor = UIColor.whiteColor()
        
        positionNameTf.placeholder = "请输入工作地点"
        
        var FTPublishJobSelectedNameArray = NSUserDefaults.standardUserDefaults().arrayForKey(FTPublishJobSelectedNameArray_key) as! [Array<String>]
        if FTPublishJobSelectedNameArray[1][1] != "工作地点" {
            positionNameTf.text = FTPublishJobSelectedNameArray[1][1]
        }
        
        positionNameTf.addTarget(self, action: #selector(positionNameTfValueChanged), forControlEvents: .EditingChanged)
        positionNameBgView.addSubview(positionNameTf)
        
        let tipLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(positionNameTf.frame)+10, screenSize.width*0.6, 30))
        tipLab.textColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
        tipLab.text = "请填写您的工作地点"
        tipLab.font = UIFont.systemFontOfSize(14)
        positionNameBgView.addSubview(tipLab)
        
        countLab.frame = CGRectMake(CGRectGetMaxX(tipLab.frame), CGRectGetMaxY(positionNameTf.frame)+10, screenSize.width-CGRectGetMaxX(tipLab.frame)-8, 30)
        countLab.textAlignment = .Right
        countLab.text = "\((positionNameTf.text?.characters.count)!)/50"
        positionNameBgView.addSubview(countLab)
    }
    
    // MARK: 点击保存按钮
    func saveBtnClick() {
        if self.positionNameTf.text!.isEmpty {
            let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            checkCodeHud.removeFromSuperViewOnHide = true
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入工作地点"
            checkCodeHud.hide(true, afterDelay: 1)
        }else{
            var FTPublishJobSelectedNameArray = NSUserDefaults.standardUserDefaults().arrayForKey(FTPublishJobSelectedNameArray_key) as! [Array<String>]
            FTPublishJobSelectedNameArray[3][1] = self.positionNameTf.text!
            NSUserDefaults.standardUserDefaults().setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: 限制输入字数
    let maxCount = 50
    
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
