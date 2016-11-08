//
//  LoReCHSJobExperienceViewController.swift
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

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
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


class LoReCHSJobExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LoReFTInfoInputViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    let rootTableView = UITableView()
    
    var pickerView = UIPickerView()
    
    let pickYearLowRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    let pickMonthLowRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    var pickYearSupRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    var pickMonthSupRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    
    var pickSelectedRowArray = [0,0,0,0]
    
    let jobContentTv = UITextView()
    
    let nameArray = ["公司名称","公司行业","职位类型","技能展示","任职时间段"]
    var detailArray = CHSUserInfo.currentUserInfo.work?.count > 0 ?[
        (CHSUserInfo.currentUserInfo.work?.first?.company_name) == "" ? "请输入公司名称":(CHSUserInfo.currentUserInfo.work?.first?.company_name)!,
        (CHSUserInfo.currentUserInfo.work?.first?.company_industry)! == "" ? "选择行业":(CHSUserInfo.currentUserInfo.work?.first?.company_industry)!,
        (CHSUserInfo.currentUserInfo.work?.first?.jobtype)! == "" ? "选择职位类型":(CHSUserInfo.currentUserInfo.work?.first?.jobtype)!,
        (CHSUserInfo.currentUserInfo.work?.first?.skill)! == "" ? "请选择技能":(CHSUserInfo.currentUserInfo.work?.first?.skill)!,
        (CHSUserInfo.currentUserInfo.work?.first?.work_period)! == "" ? "请选择任职时间段":(CHSUserInfo.currentUserInfo.work?.first?.work_period)!
        ]:[
            "请输入公司名称","选择行业","选择职位类型","请选择技能","请选择任职时间段"
        ] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(JobIntensionChanged(_:)), name: NSNotification.Name(rawValue: "PersonalChangeJobExperienceNotification"), object: nil)
    }
    
    func JobIntensionChanged(_ noti:Notification) {
        let userInfo = (noti as NSNotification).userInfo
        if (userInfo != nil) {
            if userInfo!["type"] as! String == "PositionType" {
                detailArray[2] = userInfo!["value"] as! String
            }else if userInfo!["type"] as! String == "Categories" {
                detailArray[1] = userInfo!["value"] as! String
            }else if userInfo!["type"] as! String == "Skill" {
                detailArray[3] = userInfo!["value"] as! String
            }
        }
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
    
    // MARK: 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = "编写工作经历"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.separatorStyle = .none
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let postPositionBtn = UIButton(frame: CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44))
        postPositionBtn.backgroundColor = baseColor
        postPositionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        postPositionBtn.setTitleColor(UIColor.white, for: UIControlState())
        postPositionBtn.setTitle("下一步", for: UIControlState())
        postPositionBtn.addTarget(self, action: #selector(clickSaveBtn), for: .touchUpInside)
        self.view.addSubview(postPositionBtn)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        //        userid,company_name,company_industry,jobtype,skill,work_period,content
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
//        if detailArray[0] == "请输入公司名称" {
//            
//            checkCodeHud.mode = .Text
//            checkCodeHud.labelText = "请输入公司名称"
//            checkCodeHud.hide(true, afterDelay: 1)
//            return
//        }else if detailArray[1] == "选择行业" {
//            
//            checkCodeHud.mode = .Text
//            checkCodeHud.labelText = "请选择行业"
//            checkCodeHud.hide(true, afterDelay: 1)
//            return
//        }else if detailArray[2] == "选择职位类型" {
//            
//            checkCodeHud.mode = .Text
//            checkCodeHud.labelText = "请选择职位类型"
//            checkCodeHud.hide(true, afterDelay: 1)
//            return
//        }else if detailArray[3] == "请选择技能" {
//            
//            checkCodeHud.mode = .Text
//            checkCodeHud.labelText = "请选择技能"
//            checkCodeHud.hide(true, afterDelay: 1)
//            return
//        }else if detailArray[4] == "选择任职时间段" {
//            
//            checkCodeHud.mode = .Text
//            checkCodeHud.labelText = "请选择任职时间段"
//            checkCodeHud.hide(true, afterDelay: 1)
//            return
//        }else if jobContentTv.text!.isEmpty {
//            
//            checkCodeHud.mode = .Text
//            checkCodeHud.labelText = "请输入工作内容"
//            checkCodeHud.hide(true, afterDelay: 1)
//            return
//        }
//        
//        if CHSUserInfo.currentUserInfo.work?.first?.company_name ==  self.detailArray[0] && CHSUserInfo.currentUserInfo.work?.first?.company_industry ==  self.detailArray[1] && CHSUserInfo.currentUserInfo.work?.first?.jobtype ==  self.detailArray[2] && CHSUserInfo.currentUserInfo.work?.first?.skill ==  self.detailArray[3] && CHSUserInfo.currentUserInfo.work?.first?.work_period ==  self.detailArray[4] && CHSUserInfo.currentUserInfo.work?.first?.content == self.jobContentTv.text! {
//            checkCodeHud.mode = .Text
//            checkCodeHud.labelText = "信息未修改"
//            checkCodeHud.hide(true, afterDelay: 1)
//            
//            let time: NSTimeInterval = 1.0
//            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
//            
//            dispatch_after(delay, dispatch_get_main_queue()) {
//                self.navigationController?.popViewControllerAnimated(true)
//            }
//            return
//        }
        
        checkCodeHud.labelText = "正在保存工作经历"
        
        CHSNetUtil().PublishWork(
            CHSUserInfo.currentUserInfo.userid,
            company_name: detailArray[0],
            company_industry: detailArray[1],
            jobtype: detailArray[2],
            skill: detailArray[3],
            work_period: detailArray[4],
            content: jobContentTv.text!) { (success, response) in
                if success {
                    
                    let workModel = WorkModel()
                    
                    workModel.company_name =  self.detailArray[0]
                    workModel.company_industry =  self.detailArray[1]
                    workModel.jobtype =  self.detailArray[2]
                    workModel.skill =  self.detailArray[3]
                    workModel.work_period =  self.detailArray[4]
                    workModel.content = self.jobContentTv.text!
                    
                    if CHSUserInfo.currentUserInfo.work?.count > 0 {
                        CHSUserInfo.currentUserInfo.work?[0] = workModel
                    }else{
                        
                        CHSUserInfo.currentUserInfo.work = [WorkModel]()

                        CHSUserInfo.currentUserInfo.work?.append(workModel)
                    }
                    
                    self.detailArray = [
                        (CHSUserInfo.currentUserInfo.work?.first?.company_name)! == "" ? "请输入公司名称":(CHSUserInfo.currentUserInfo.work?.first?.company_name)!,
                        (CHSUserInfo.currentUserInfo.work?.first?.company_industry)! == "" ? "选择行业":(CHSUserInfo.currentUserInfo.work?.first?.company_industry)!,
                        (CHSUserInfo.currentUserInfo.work?.first?.jobtype)! == "" ? "选择职位类型":(CHSUserInfo.currentUserInfo.work?.first?.jobtype)!,
                        (CHSUserInfo.currentUserInfo.work?.first?.skill)! == "" ? "请选择技能":(CHSUserInfo.currentUserInfo.work?.first?.skill)!,
                        (CHSUserInfo.currentUserInfo.work?.first?.work_period)! == "" ? "请选择任职时间段":(CHSUserInfo.currentUserInfo.work?.first?.work_period)!
                    ]
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.labelText = "保存工作经历成功"
                    checkCodeHud.hide(true, afterDelay: 1)
                    
                    let time: TimeInterval = 1.0
                    let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self.navigationController?.pushViewController(LoReCHSMyAdvantagesViewController(), animated: true)
                    }
                }else{
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.labelText = "保存工作经历失败"
                    checkCodeHud.hide(true, afterDelay: 1)
                }
                
        }
    }
    
    // MARK: LoReFTInfoInputViewControllerDelegate
    func LoReFTInfoInputClickSaveBtn(_ infoType: InfoType, text: String) {
        switch infoType {
        case .jobExp_CompanyName:
            detailArray[0] = text
        default:
            break
        }
    }
    
    // MARK:- tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return nameArray.count
        }else{
            return 2
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "jobExperience")
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "jobExperience")
            }
            
            cell?.selectionStyle = .none
            
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.textLabel?.textColor = UIColor.black
            cell?.textLabel?.textAlignment = .left
            cell?.textLabel?.text = nameArray[(indexPath as NSIndexPath).row]
            
            //            if indexPath.row == 0 {
            
            //                let companyNameTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
            //                companyNameTf.font = UIFont.systemFontOfSize(14)
            //                companyNameTf.placeholder = detailArray[indexPath.row]
            //                companyNameTf.textAlignment = .Right
            //                cell?.accessoryView = companyNameTf
            //            }else{
            
            
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .right
            
            if (indexPath as NSIndexPath).row == 3 {
                cell?.detailTextLabel?.text = "\(detailArray[3].components(separatedBy: " ").count)个技能"
            }else{
                cell?.detailTextLabel?.text = detailArray[(indexPath as NSIndexPath).row]
            }
            //            }
            
            if (indexPath as NSIndexPath).row < nameArray.count-1 {
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 59), toPoint: CGPoint(x: screenSize.width-8, y: 59), lineWidth: 1/UIScreen.main.scale)
            }
            
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "jobContentCell")
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "jobContentCell")
            }
            
            cell?.selectionStyle = .none
            
            if (indexPath as NSIndexPath).row == 0 {
                jobContentTv.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*115)
                jobContentTv.font = UIFont.systemFont(ofSize: 14)
                jobContentTv.text = CHSUserInfo.currentUserInfo.work?.count > 0 ? (CHSUserInfo.currentUserInfo.work?.first?.content == "" ? "":CHSUserInfo.currentUserInfo.work?.first?.content):""
                
                jobContentTv.delegate = self
                cell?.contentView.addSubview(jobContentTv)
                
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 115), toPoint: CGPoint(x: screenSize.width-8, y: 115), lineWidth: 1/UIScreen.main.scale)
                
            }else{
                
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
                cell?.textLabel?.textColor = baseColor
                cell?.textLabel?.textAlignment = .left
                cell?.textLabel?.text = "看看别人怎么写"
                cell?.detailTextLabel?.text = "\((jobContentTv.text?.characters.count)!)/\(jobContentMaxCount)"
                
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
                cell?.detailTextLabel?.textColor = baseColor
                cell?.detailTextLabel?.textAlignment = .right
                
                othersDrop.anchorView = cell
                othersDrop.bottomOffset = CGPoint(x: 8, y: 45)
                othersDrop.width = screenSize.width-16
                othersDrop.direction = .bottom
                
                othersDrop.dataSource = getRandomArray(self.dropArray, maxNum: 5)
                
                
                // 下拉列表选中后的回调方法
                othersDrop.selectionAction = { (index, item) in
                    self.jobContentTv.text = item
                    self.textViewDidChange(self.jobContentTv)
                }
            }
            
            return cell!
        }
    }
    var dropArray = ["不限","1万以下","1~2万","2~3万","3~4万","4~5万","5万以上"]
    // MARK:随机数生成器函数
    func createRandomMan(_ start: Int, end: Int) ->() ->Int! {
        
        //根据参数初始化可选值数组
        var nums = [Int]();
        for i in start...end{
            nums.append(i)
        }
        
        func randomMan() -> Int! {
            if !nums.isEmpty {
                //随机返回一个数，同时从数组里删除
                let index = Int(arc4random_uniform(UInt32(nums.count)))
                return nums.remove(at: index)
            }else {
                //所有值都随机完则返回nil
                return nil
            }
        }
        
        return randomMan
    }
    
    func getRandomArray(_ array:Array<String>, maxNum:Int) -> Array<String> {
        
        var tempArray = Array<String>()
        
        let random1 = self.createRandomMan(0,end: array.count-1)
        
        for _ in 0 ... maxNum {
            let random = random1()
            if (random != nil) {
                tempArray.append(array[random!])
            }else{
                return tempArray
            }
        }
        
        return tempArray
    }
    
    // MARK:- tableView delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 35
        }else if section == 1 {
            return 35
        }else{
            return 0.0001
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let sectionHeaderBgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 35))
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 20, y: 0, width: screenSize.width-40, height: 35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 15)
            sectionHeaderLab.textColor = UIColor.lightGray
            sectionHeaderLab.text = "最近一次工作经历"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else if section == 1 {
            
            let sectionHeaderBgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 35))
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 20, y: 0, width: screenSize.width-40, height: 35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 15)
            sectionHeaderLab.textColor = UIColor.lightGray
            sectionHeaderLab.text = "工作内容"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath as NSIndexPath).section == 0 {
            return 60
        }else if (indexPath as NSIndexPath).section == 1 {
            if (indexPath as NSIndexPath).row == 0 {
                return 116
            }else if (indexPath as NSIndexPath).row == 1 {
                return 40
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    var othersDrop = DropDown()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            let cell = tableView.cellForRow(at: indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .jobExp_CompanyName
            vc.selfTitle = "公司名称"
            vc.placeHolder = "请输入公司名称"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.black ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = ""
            vc.hudTipText = "请输入公司名称"
            vc.maxCount = 20
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case (0,1):
            
            let industryCategoriesVC = CHSReChooseIndustryCategoriesViewController()
            industryCategoriesVC.navTitle = "公司行业选择"
            industryCategoriesVC.vcType = .jobExperience
            
            self.navigationController?.pushViewController(industryCategoriesVC, animated: true)
            
        case (0,2):
            
            let choosePositionTypeVC = CHSReChoosePositionTypeViewController()
            choosePositionTypeVC.vcType = .jobExperience
            self.navigationController?.pushViewController(choosePositionTypeVC, animated: true)
        case (0,3):
            
            let choosePositionTypeVC = CHSReJobExpSkillViewController()
            choosePositionTypeVC.orignalSelectSkillStr = detailArray[3]
            self.navigationController?.pushViewController(choosePositionTypeVC, animated: true)
        case (0,4):
            let bigBgView = UIButton(frame: self.view.bounds)
            bigBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
            bigBgView.tag = 1000
            bigBgView.addTarget(self, action: #selector(pickerCancelClick), for: .touchUpInside)
            self.view.addSubview(bigBgView)
            
            let pickerBgView = UIView(frame: CGRect(x: 0, y: screenSize.height-kHeightScale*240, width: screenSize.width, height: kHeightScale*240))
            pickerBgView.backgroundColor = UIColor.white
            bigBgView.addSubview(pickerBgView)
            
            let pickerLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 43))
            pickerLab.textAlignment = .center
            pickerBgView.addSubview(pickerLab)
            
            drawDashed(pickerBgView, color: UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1), fromPoint: CGPoint(x: 0, y: 43), toPoint: CGPoint(x: screenSize.width, y: 43), lineWidth: 1)
            
            pickerView = UIPickerView(frame: CGRect(x: 0, y: 44, width: screenSize.width, height: kHeightScale*240-88))
            
            //            pickerView.subviews[0].layer.borderWidth = 0.5
            //
            //            pickerView.subviews[0].layer.borderColor = UIColor.redColor().CGColor
            //指定Picker的代理
            pickerView.dataSource = self
            pickerView.delegate = self
            
            pickerBgView.addSubview(pickerView)
            
            drawDashed(pickerBgView, color: UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1), fromPoint: CGPoint(x: 0, y: kHeightScale*240-44), toPoint: CGPoint(x: screenSize.width, y: kHeightScale*240-44), lineWidth: 1)
            
            let cancelBtn = UIButton(frame: CGRect(x: 0, y: kHeightScale*240-43, width: screenSize.width/2.0-0.5, height: 43))
            cancelBtn.setTitleColor(UIColor.black, for: UIControlState())
            cancelBtn.setTitle("取消", for: UIControlState())
            cancelBtn.addTarget(self, action: #selector(pickerCancelClick), for: .touchUpInside)
            pickerBgView.addSubview(cancelBtn)
            
            drawDashed(pickerBgView, color: UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1), fromPoint: CGPoint(x: screenSize.width/2.0-0.5, y: kHeightScale*240-43), toPoint: CGPoint(x: screenSize.width/2.0-0.5, y: kHeightScale*240), lineWidth: 1)
            
            let sureBtn = UIButton(frame: CGRect(x: screenSize.width/2.0-0.5, y: kHeightScale*240-43, width: screenSize.width/2.0-0.5, height: 43))
            sureBtn.setTitleColor(UIColor.black, for: UIControlState())
            sureBtn.setTitle("确定", for: UIControlState())
            sureBtn.addTarget(self, action: #selector(sureBtnClick), for: .touchUpInside)
            pickerBgView.addSubview(sureBtn)
            
            pickerLab.text = "任职时间段"
            
            pickerView.tag = 101
            pickerView.selectRow(pickSelectedRowArray[0], inComponent: 0, animated: false)
            pickerView.selectRow(pickSelectedRowArray[1], inComponent: 1, animated: false)
            pickerView.selectRow(pickSelectedRowArray[2], inComponent: 3, animated: false)
            pickerView.selectRow(pickSelectedRowArray[3], inComponent: 4, animated: false)
            
        case (1,1):
            _ = othersDrop.show()
            let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 1))
            let changeDropDataSourceBtn = UIButton(frame: CGRect(x: 20,y: (cell?.frame.origin.y)!+64,width: screenSize.width/2.0-40,height: (cell?.frame.size.height)!))
            changeDropDataSourceBtn.backgroundColor = UIColor.white
            changeDropDataSourceBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            changeDropDataSourceBtn.contentHorizontalAlignment = .left
            changeDropDataSourceBtn.setTitleColor(baseColor, for: UIControlState())
            changeDropDataSourceBtn.setTitle("换一组", for: UIControlState())
            changeDropDataSourceBtn.addTarget(self, action: #selector(changeDropDataSourceBtnClick), for: .touchUpInside)
            othersDrop.addSubview(changeDropDataSourceBtn)
            
        default:
            
            print("找人才-人才-发布职位-didSelectRowAtIndexPath  default")
        }
    }
    
    func changeDropDataSourceBtnClick() {
        othersDrop.dataSource = getRandomArray(self.dropArray, maxNum: 5)
    }
    
    // MARK: 限制输入字数
    let jobContentMaxCount = 300
    
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
        
        let cell = rootTableView.cellForRow(at: IndexPath(row: 1, section: 1))
        cell?.detailTextLabel?.text = "\((textView.text?.characters.count)!)/\(jobContentMaxCount)"
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
    
    // MARK: 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            detailArray[4] = "\(pickYearLowRequiredArray[pickerView.selectedRow(inComponent: 0)]).\(pickMonthLowRequiredArray[pickerView.selectedRow(inComponent: 1)])-\(pickYearSupRequiredArray[pickerView.selectedRow(inComponent: 3)]).\(pickMonthSupRequiredArray[pickerView.selectedRow(inComponent: 4)])"
            
            pickSelectedRowArray[0] = pickerView.selectedRow(inComponent: 0)
            pickSelectedRowArray[1] = pickerView.selectedRow(inComponent: 1)
            pickSelectedRowArray[2] = pickerView.selectedRow(inComponent: 3)
            pickSelectedRowArray[3] = pickerView.selectedRow(inComponent: 4)
        }
        
        //        NSUserDefaults.standardUserDefaults().setValue(detailArray, forKey: FTPublishJobdetailArray_key)
        
        //        pickerView.removeFromSuperview()
        
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: 改变分割线颜色
    func changeSeparatorWithView(_ view: UIView) {
        
        if view.bounds.size.height <= 1 {
            view.backgroundColor = baseColor
        }
        
        for subview in view.subviews {
            self.changeSeparatorWithView(subview)
        }
    }
    
    // MARK:- UIPickerView DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 101 {
            return 5
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            if component == 0 {
                return pickYearLowRequiredArray.count
            }else if component == 1 {
                return pickMonthLowRequiredArray.count
            }else if component == 2 {
                return 1
            }else if component == 3 {
                return pickYearSupRequiredArray.count
            }else if component == 4 {
                return pickMonthSupRequiredArray.count
            }else{
                return 0
            }
        }else{
            return 0
        }
        
    }
    
    // MARK:- UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 101 {
            
            pickYearSupRequiredArray = Array(pickYearLowRequiredArray[pickerView.selectedRow(inComponent: 0) ..< pickYearLowRequiredArray.count])
            
            if pickYearSupRequiredArray[pickerView.selectedRow(inComponent: 3)] ==  pickYearLowRequiredArray[pickerView.selectedRow(inComponent: 0)]{
                pickMonthSupRequiredArray = Array(pickMonthLowRequiredArray[pickerView.selectedRow(inComponent: 1) ..< pickMonthLowRequiredArray.count])
            }else{
                pickMonthSupRequiredArray = pickMonthLowRequiredArray
            }
            
            
            //            if component == 0 {
            //            }else if component == 1 {
            //            }else if component == 3 {
            //                pickYearSupRequiredArray = Array(pickYearLowRequiredArray[row ..< pickYearLowRequiredArray.count])
            //            }else if component == 4 {
            //                pickYearSupRequiredArray = Array(pickYearLowRequiredArray[row ..< pickYearLowRequiredArray.count])
            //            }
        }
        
        pickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        self.changeSeparatorWithView(pickerView)
        
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 25))
        //        view.backgroundColor = UIColor.cyanColor()
        view.frame.size = pickerView.rowSize(forComponent: component)
        view.textAlignment = .center
        
        if row == pickerView.selectedRow(inComponent: component) {
            view.textColor = baseColor
        }else{
            view.textColor = UIColor.lightGray
        }
        
        if pickerView.tag == 101 {
            
            if component == 0 {
                view.text = pickYearLowRequiredArray[row]
            }else if component == 1 {
                view.text = pickMonthLowRequiredArray[row]
            }else if component == 2 {
                view.text = "至"
            }else if component == 3 {
                view.text = pickYearSupRequiredArray[row]
            }else if component == 4 {
                view.text = pickMonthSupRequiredArray[row]
            }
        }
        
        return view
    }
    // MARK:-
    
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
