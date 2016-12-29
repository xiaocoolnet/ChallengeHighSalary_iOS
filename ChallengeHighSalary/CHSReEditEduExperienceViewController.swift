//
//  CHSReEditEduExperienceViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/25.
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


class CHSReEditEduExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UITextViewDelegate {
    
    var selectedIndex:Int? {
        didSet {
            detailArray = [
                CHSUserInfo.currentUserInfo.education![self.selectedIndex!].school,
                CHSUserInfo.currentUserInfo.education![self.selectedIndex!].major,
                CHSUserInfo.currentUserInfo.education![self.selectedIndex!].degree,
                CHSUserInfo.currentUserInfo.education![self.selectedIndex!].time
            ]
        }
    }
    
    let rootTableView = UITableView()
    
    let schoolNameTf = UITextField()
    
    let majorNameTf = UITextField()
    
    var pickerView = UIPickerView()
    
    let pickEduArray = ["大专","本科","硕士"]
    let pickSchoolTimeLowRequiredArray = ["1970年","1971年","1972年","1973年","1974年","1975年","1976年","1977年","1978年","1979年","1980年","1981年","1982年","1983年","1984年","1985年","1986年","1987年","1988年","1989年","1990年","1991年","1992年","1993年","1994年","1995年","1996年","1997年","1998年","1999年","2000年","2001年","2002年","2003年","2004年","2005年","2006年","2007年","2008年","2009年","2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年"]
    var pickSchoolTimeSupRequiredArray = ["1970年","1971年","1972年","1973年","1974年","1975年","1976年","1977年","1978年","1979年","1980年","1981年","1982年","1983年","1984年","1985年","1986年","1987年","1988年","1989年","1990年","1991年","1992年","1993年","1994年","1995年","1996年","1997年","1998年","1999年","2000年","2001年","2002年","2003年","2004年","2005年","2006年","2007年","2008年","2009年","2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年"]
    
    var pickSelectedRowArray = [[0],[0,0]]
    
    let schoolExpTv = UITextView()

    let nameArray = ["学校","专业","学历","时间段"]
    var detailArray = ["请输入学校名称","请输入专业","选择学历","请选择就读时间段"] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
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
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.title = "编写教育经历"
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
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if self.selectedIndex == nil {
            
            if schoolNameTf.text!.isEmpty {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "请输入学校名称"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                return
            }else if majorNameTf.text!.isEmpty {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "请输入专业"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                return
            }else if detailArray[2] == "选择学历" {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "请选择学历"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                return
            }else if detailArray[3] == "请选择就读时间段" {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "请选择就读时间段"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                return
            }else if schoolExpTv.text!.isEmpty {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "请输入在校经历"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                return
            }
        }else if
                CHSUserInfo.currentUserInfo.education![self.selectedIndex!].school ==  schoolNameTf.text &&
                    CHSUserInfo.currentUserInfo.education![self.selectedIndex!].major ==  majorNameTf.text &&
                    CHSUserInfo.currentUserInfo.education![self.selectedIndex!].degree ==  detailArray[2] &&
                    CHSUserInfo.currentUserInfo.education![self.selectedIndex!].time ==  detailArray[3] && CHSUserInfo.currentUserInfo.education![self.selectedIndex!].experience == schoolExpTv.text! {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "信息未修改"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                
                let time: TimeInterval = 1.0
                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
                return
            
        }
        
        checkCodeHud.label.text = "正在保存教育经历"
        
        CHSNetUtil().PublishEducation(
            CHSUserInfo.currentUserInfo.userid,
            school: schoolNameTf.text!,
            major: majorNameTf.text!,
            degree: detailArray[2],
            time: detailArray[3],
            experience: schoolExpTv.text!) { (success, response) in
                
                if success {
                    
                    //                    CHSUserInfo.currentUserInfo.work_property =  self.detailArray[0]
                    //                    CHSUserInfo.currentUserInfo.address =  self.detailArray[1]
                    //                    CHSUserInfo.currentUserInfo.position_type =  self.detailArray[2]
                    //                    CHSUserInfo.currentUserInfo.categories =  self.detailArray[3]
                    //                    CHSUserInfo.currentUserInfo.wantsalary =  self.detailArray[4]
                    //                    CHSUserInfo.currentUserInfo.jobstate =  self.detailArray[5]
                    
                    let eduModel = EducationModel()
                    eduModel.school = self.schoolNameTf.text!
                    eduModel.major = self.majorNameTf.text!
                    eduModel.degree = self.detailArray[2]
                    eduModel.time = self.detailArray[3]
                    eduModel.experience = self.schoolExpTv.text
                    
                    CHSUserInfo.currentUserInfo.education?.append(eduModel)
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.label.text = "保存教育经历成功"
                    checkCodeHud.hide(animated: true, afterDelay: 1)
                    
                    let time: TimeInterval = 1.0
                    let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.label.text = "保存教育经历失败"
                    checkCodeHud.hide(animated: true, afterDelay: 1)
                }

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
                
                cell?.selectionStyle = .none
                
                cell?.accessoryType = .disclosureIndicator
                cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
                cell?.textLabel?.textColor = UIColor.black
                cell?.textLabel?.textAlignment = .left
                cell?.textLabel?.text = nameArray[(indexPath as NSIndexPath).row]
                
                if (indexPath as NSIndexPath).row == 0 {
                    
                    schoolNameTf.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
                    schoolNameTf.font = UIFont.systemFont(ofSize: 14)
                    schoolNameTf.placeholder = detailArray[(indexPath as NSIndexPath).row]
                    schoolNameTf.textAlignment = .right
                    cell?.accessoryView = schoolNameTf
                }else if (indexPath as NSIndexPath).row == 1 {
                    
                    majorNameTf.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
                    majorNameTf.font = UIFont.systemFont(ofSize: 14)
                    majorNameTf.placeholder = detailArray[(indexPath as NSIndexPath).row]
                    majorNameTf.textAlignment = .right
                    cell?.accessoryView = majorNameTf
                }else{
                    
                    
                    cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.textAlignment = .right
                    cell?.detailTextLabel?.text = detailArray[(indexPath as NSIndexPath).row]
                    
                }
                
                if (indexPath as NSIndexPath).row < nameArray.count-1 {
                    drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 59), toPoint: CGPoint(x: screenSize.width-8, y: 59), lineWidth: 1/UIScreen.main.scale)
                }
            }
            
            if (indexPath as NSIndexPath).row == 0 {
                
                
//                if (self.selectedIndex != nil) {
//                    schoolNameTf.text = CHSUserInfo.currentUserInfo.education![self.selectedIndex!].school
//                }else{
//                }
                schoolNameTf.text = schoolNameTf.text == "" ? nil:schoolNameTf.text
            }else if (indexPath as NSIndexPath).row == 1 {
                
//                if (self.selectedIndex != nil) {
//                    majorNameTf.text = CHSUserInfo.currentUserInfo.education![self.selectedIndex!].major
//                }else{
//                }
                majorNameTf.text = majorNameTf.text == "" ? nil:majorNameTf.text
            }else{
                
//                
//                if (self.selectedIndex != nil) {
//                    if (indexPath as NSIndexPath).row == 2 {
//                        cell?.detailTextLabel?.text = CHSUserInfo.currentUserInfo.education![self.selectedIndex!].degree
//                    }else if (indexPath as NSIndexPath).row == 3 {
//                        cell?.detailTextLabel?.text = CHSUserInfo.currentUserInfo.education![self.selectedIndex!].time
//                    }
//                }else{
//                }
                cell?.detailTextLabel?.text = detailArray[(indexPath as NSIndexPath).row]
            }
            
            if (indexPath as NSIndexPath).row < nameArray.count-1 {
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 59), toPoint: CGPoint(x: screenSize.width-8, y: 59), lineWidth: 1/UIScreen.main.scale)
            }
            
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "jobContentCell")
            
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "jobContentCell")
                
                cell?.selectionStyle = .none
                
                if (indexPath as NSIndexPath).row == 0 {
                    schoolExpTv.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: kHeightScale*115)
                    schoolExpTv.font = UIFont.systemFont(ofSize: 14)
                    schoolExpTv.delegate = self
                    cell?.contentView.addSubview(schoolExpTv)
                    
                    drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPoint(x: 8, y: 115), toPoint: CGPoint(x: screenSize.width-8, y: 115), lineWidth: 1/UIScreen.main.scale)
                    
                }else{
                    
                    cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
                    cell?.detailTextLabel?.textColor = baseColor
                    cell?.detailTextLabel?.textAlignment = .right
                }
            }
            
            if (indexPath as NSIndexPath).row == 0 {
                
//                if (self.selectedIndex != nil) {
//                    schoolExpTv.text = CHSUserInfo.currentUserInfo.education![self.selectedIndex!].experience
//                    self.textViewDidChange(schoolExpTv)
//                }else{
//                }
                schoolExpTv.text = schoolExpTv.text == "" ? nil:schoolExpTv.text
                
            }else{
                cell?.detailTextLabel?.text = "\((schoolExpTv.text?.characters.count)!)/\(schoolExpMaxCount)"

//                cell?.detailTextLabel?.text = "0/300"
            }
            
            
            return cell!
        }
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
            sectionHeaderLab.text = "教育经历"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else if section == 1 {
            
            let sectionHeaderBgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 35))
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 20, y: 0, width: screenSize.width-40, height: 35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 15)
            sectionHeaderLab.textColor = UIColor.lightGray
            sectionHeaderLab.text = "在校经历"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,1):
            break
            self.navigationController?.pushViewController(CHSReChoosePositionTypeViewController(), animated: true)
            
        default:
            
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
            
            switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
            case (0,2):
                pickerLab.text = "学历"
                
                pickerView.tag = 101
                pickerView.selectRow(pickSelectedRowArray[0][0], inComponent: 0, animated: false)
            case (0,3):
                
                pickerLab.text = "就读时间段"
                
                pickerView.tag = 102
                pickerView.selectRow(pickSelectedRowArray[1][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[1][1], inComponent: 2, animated: false)
            default:
                print("挑战高薪-简历-编辑教育经历-didSelectRowAtIndexPath  default")
            }
            print("挑战高薪-简历-编辑教育经历-didSelectRowAtIndexPath  default")
        }
    }
    
    // MARK: 限制输入字数
    let schoolExpMaxCount = 300
    
    func textViewDidChange(_ textView: UITextView) {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = textView.markedTextRange
            if range == nil {
                if textView.text?.characters.count >= schoolExpMaxCount {
                    textView.text = textView.text?.substring(to: (textView.text?.characters.index((textView.text?.startIndex)!, offsetBy: schoolExpMaxCount))!)
                }
            }
        }
        else {
            if textView.text?.characters.count >= schoolExpMaxCount {
                textView.text = textView.text?.substring(to: (textView.text?.characters.index((textView.text?.startIndex)!, offsetBy: schoolExpMaxCount))!)
            }
        }
        
        let cell = rootTableView.cellForRow(at: IndexPath(row: 1, section: 1))
        cell?.detailTextLabel?.text = "\((textView.text?.characters.count)!)/\(schoolExpMaxCount)"
    }
    
    // MARK: 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            detailArray[2] = "\(pickEduArray[pickerView.selectedRow(inComponent: 0)])"
            
            pickSelectedRowArray[0][0] = pickerView.selectedRow(inComponent: 0)
        }else if pickerView.tag == 102 {
            
            detailArray[3] = "\(pickSchoolTimeLowRequiredArray[pickerView.selectedRow(inComponent: 0)])-\(pickSchoolTimeSupRequiredArray[pickerView.selectedRow(inComponent: 2)])"
            
            pickSelectedRowArray[1][0] = pickerView.selectedRow(inComponent: 0)
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
            return 1
        }else if pickerView.tag == 102 {
            return 3
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            return pickEduArray.count
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                return pickSchoolTimeLowRequiredArray.count
            }else if component == 1 {
                return 1
            }else{
                return pickSchoolTimeSupRequiredArray.count
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
            
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                pickSchoolTimeSupRequiredArray = Array(pickSchoolTimeLowRequiredArray[row ..< pickSchoolTimeLowRequiredArray.count])
                
            }
        }else{
            
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
            
            view.text = pickEduArray[row]
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                view.text = pickSchoolTimeLowRequiredArray[row]
            }else if component == 1 {
                view.text = "至"
            }else{
                view.text = pickSchoolTimeSupRequiredArray[row]
            }
        }else{
            
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
