//
//  FTTaSkillRequiredViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaSkillRequiredViewController: UIViewController {

    var skillModelArray = [String]()
//    let skillNameArray = ["数据分析","移动产品","电子商务","智能硬件","电子商务","电子商务","智能硬件","智能硬件","项目管理","产品经理","交互设计","APP","用户研究","产品助理","交互设计","游戏策划","产品总监","产品助理","产品助理","在线教育","网页设计","游戏策划","产品总监","游戏策划","产品总监","无线产品","在线教育","网页设计","在线教育","网页设计","无线产品","无线产品"]
    var selectSkillArray = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if skillModelArray.count <= 0 {
            loadData()
        }
    }
    
    // MARK: - 获取数据
    func loadData() {
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.removeFromSuperViewOnHide = true
        hud?.margin = 10
        hud?.labelText = "正在获取技能标签"
        
        PublicNetUtil().getDictionaryList(parentid: "36") { (success, response) in
            if success {
                hud?.hide(true)
                
                self.skillModelArray = []
                
                let dicDataArray = response as! [DicDataModel]
                
                for dicData in dicDataArray {
                    self.skillModelArray.append((dicData.name ?? "")!)
                }
                
                var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
                
                let skillArray = FTPublishJobSelectedNameArray[1][2].components(separatedBy: "-")
                if skillArray.count == 1 && skillArray.first == "技能要求" {
                    
                }else{
                    
                    for skillStr in FTPublishJobSelectedNameArray[1][2].components(separatedBy: "-") {
                        
                        if !self.skillModelArray.contains(skillStr) {
                            self.skillModelArray.append(skillStr)
                        }
                        
                    }
                }
                
                for _ in self.skillModelArray {
                    self.selectSkillArray.append("")
                }
                
                self.setSkillBtn()

            }else{
                hud?.mode = .text
                hud?.labelText = "技能标签获取失败"
                hud?.hide(true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    
                    _ = self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
        
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
        
        self.title = "技能标签"
        
        // 提示 Label
        let tipLab = UILabel(frame: CGRect(x: 0, y: 64+10, width: screenSize.width, height: 40))
        tipLab.textColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
        tipLab.textAlignment = .center
        tipLab.text = "最多三个标签"
        tipLab.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(tipLab)
        
    }
    
    // MARK: - 设置标签
    func setSkillBtn() {
        
        self.view.viewWithTag(12345)?.removeFromSuperview()
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 114, width: screenSize.width, height: screenSize.height-64-44))
        scrollView.tag = 12345
        
        self.view.addSubview(scrollView)
        
        // 设置标签 button
        let skillBtnMargin_x:CGFloat = 10
        let skillBtnMargin_y:CGFloat = 10
        var skillBtnX:CGFloat = skillBtnMargin_x
        var skillBtnY:CGFloat = skillBtnMargin_y
        var skillBtnWidth:CGFloat = 0
        let skillBtnHeight:CGFloat = 30
        
        for (i,skillModel) in skillModelArray.enumerated() {
            
            skillBtnWidth = calculateWidth(skillModel, size: 15, height: skillBtnHeight)+skillBtnMargin_x*2
            let skillBtn = UIButton(frame: CGRect(x: skillBtnX, y: skillBtnY, width: skillBtnWidth, height: skillBtnHeight))
            skillBtn.tag = 100+i
            skillBtn.layer.cornerRadius = 6
            skillBtn.layer.borderWidth = 1
            skillBtn.layer.borderColor = UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1).cgColor
            skillBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            skillBtn.setTitleColor(UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1), for: UIControlState())
            skillBtn.setTitle(skillModel, for: UIControlState())
            skillBtn.setTitleColor(UIColor.white, for: .selected)
            skillBtn.backgroundColor = UIColor.clear
            skillBtn.addTarget(self, action: #selector(skillBtnClick(_:)), for: .touchUpInside)
            scrollView.addSubview(skillBtn)
            
            var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
            
            for skillStr in FTPublishJobSelectedNameArray[1][2].components(separatedBy: "-") {
                if skillModel == skillStr {
                    skillBtn.isSelected = true
                    skillBtn.backgroundColor = baseColor
                    selectSkillArray[i] = skillModelArray[i]
                }
            }
            
            if i+1 < skillModelArray.count {
                
                let nextBtnWidth = calculateWidth(skillModelArray[i+1], size: 14, height: skillBtnHeight)+skillBtnMargin_x*4
                
                if skillBtnWidth + skillBtnX + skillBtnMargin_x + nextBtnWidth >= screenSize.width - skillBtnMargin_x*2 {
                    skillBtnX = skillBtnMargin_x
                    skillBtnY = skillBtnHeight + skillBtnY + skillBtnMargin_y
                }else{
                    
                    skillBtnX = skillBtnWidth + skillBtnX + skillBtnMargin_x
                }
            }
        }
        
        // 添加标签 button
        let addBtnWidth:CGFloat = 40
        let expectX = skillBtnWidth + skillBtnX + skillBtnMargin_x + addBtnWidth
        if  expectX >= screenSize.width - skillBtnMargin_x*2 {
            skillBtnX = skillBtnMargin_x
            skillBtnY = skillBtnHeight + skillBtnY + skillBtnMargin_y
        }else{
            
            skillBtnX = skillBtnWidth + skillBtnX + skillBtnMargin_x
        }
        
        let addBtn = UIButton(frame: CGRect(x: skillBtnX, y: skillBtnY, width: addBtnWidth, height: skillBtnHeight))
        //        addBtn.layer.cornerRadius = 6
        //        addBtn.layer.borderWidth = 1
        //        addBtn.layer.borderColor = baseColor.CGColor
        
        addBtn.contentVerticalAlignment = .center
        addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        addBtn.setTitleColor(baseColor, for: UIControlState())
        addBtn.setTitle("+", for: UIControlState())
        addBtn.backgroundColor = UIColor.clear
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        scrollView.addSubview(addBtn)
        
        scrollView.contentSize = CGSize(width: 0, height: addBtn.frame.maxY+skillBtnMargin_y)
        
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = baseColor.cgColor
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: addBtn.bounds, cornerRadius: 6).cgPath
        borderLayer.frame = addBtn.bounds;
        
        borderLayer.lineWidth = 1
        
        borderLayer.lineCap = "square"
        
        borderLayer.lineDashPattern = [2, 2];
        
        addBtn.layer.addSublayer(borderLayer)
        
    }
    
    // MARK: 点击技能标签
    func skillBtnClick(_ skillBtn: UIButton) {
        
        var count = 0
        for selectSkillName in selectSkillArray {
            if selectSkillName != "" {
                count += 1
            }
        }
        
        if count >= 3 && !skillBtn.isSelected {

            let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
            checkCodeHud.removeFromSuperViewOnHide = true
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "最多选择3个标签"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        skillBtn.isSelected = !skillBtn.isSelected
        if skillBtn.isSelected {
            skillBtn.backgroundColor = baseColor
            selectSkillArray[skillBtn.tag-100] = skillModelArray[skillBtn.tag-100]
        }else{
            skillBtn.backgroundColor = UIColor.clear
            selectSkillArray[skillBtn.tag-100] = ""
        }
        
        print("抢人才-发布职位-技能要求- 选中的标签有 ")
        for selectSkillName in selectSkillArray {
            if selectSkillName != "" {
                print(selectSkillName)
            }
        }
    }
    
    // MARK: 点击添加按钮
    func addBtnClick() {
        
        print("抢人才-发布职位-技能要求- 点击添加按钮 ")
        
        let alert = UIAlertController(title: nil, message: "输入标签不超过10个字", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let sureAction = UIAlertAction(title: "确定", style: .default, handler: { (sureAction) in
            
            if (alert.textFields?.first?.text)! == "" {
                return
            }
            
            self.skillModelArray.append((alert.textFields?.first?.text)!)
            self.selectSkillArray.append("")
            
            self.setSkillBtn()
//            self.industryNameArray.append((alert.textFields?.first?.text)!)
//            self.setIndustry(isAdd: true)
        })
        alert.addAction(sureAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 点击保存按钮
    func saveBtnClick() {
        
        var skillStr = ""
//        var count = 0
        for selectSkillName in selectSkillArray {
            if selectSkillName != "" {
                skillStr = skillStr+"-"+selectSkillName
//                count += 1
            }
        }
        
        skillStr.remove(at: skillStr.startIndex)
        
        if skillStr == "" {
            let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
            checkCodeHud.removeFromSuperViewOnHide = true
            
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请选择技能标签"
            checkCodeHud.hide(true, afterDelay: 1)
        }else{
            
            var FTPublishJobSelectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
            FTPublishJobSelectedNameArray[1][2] = skillStr
            UserDefaults.standard.setValue(FTPublishJobSelectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
            
            _ = self.navigationController?.popViewController(animated: true)
        }
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
