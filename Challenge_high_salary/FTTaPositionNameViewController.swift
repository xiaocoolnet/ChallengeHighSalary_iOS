//
//  FTTaPositionNameViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaPositionNameViewController: UIViewController {
    
    let countLab = UILabel()
    
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.title = "职位名称"
        
        let positionNameBgView = UIView(frame: CGRectMake(0, 64+10, screenSize.width, 44))
        positionNameBgView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(positionNameBgView)
        
        let positionNameTf = UITextField(frame: CGRectMake(8, 0, screenSize.width-16, 44))
        positionNameTf.backgroundColor = UIColor.whiteColor()
        positionNameTf.addTarget(self, action: #selector(positionNameTfValueChanged), forControlEvents: .EditingChanged)
        positionNameBgView.addSubview(positionNameTf)
        
        let tipLab = UILabel(frame: CGRectMake(8, CGRectGetMaxY(positionNameTf.frame)+10, screenSize.width*0.6, 30))
        tipLab.textColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
        tipLab.text = "请填写您的职位名称"
        tipLab.font = UIFont.systemFontOfSize(14)
        self.view.addSubview(tipLab)

        countLab.frame = CGRectMake(CGRectGetMaxX(tipLab.frame), CGRectGetMaxY(positionNameTf.frame)+10, screenSize.width-CGRectGetMaxX(tipLab.frame)-8, 30)
        countLab.textAlignment = .Right
        countLab.text = "0/4"
        self.view.addSubview(countLab)
    }
    
    func positionNameTfValueChanged(textField: UITextField) {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = textField.markedTextRange
            if range == nil {
                if textField.text?.characters.count >= 4 {
                    textField.text = textField.text?.substringToIndex((textField.text?.startIndex.advancedBy(4))!)
                }
            }
        }
        else {
            if textField.text?.characters.count >= 4 {
                textField.text = textField.text?.substringToIndex((textField.text?.startIndex.advancedBy(4))!)
            }
        }
        countLab.text = "\((textField.text?.characters.count)!)/4"
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
