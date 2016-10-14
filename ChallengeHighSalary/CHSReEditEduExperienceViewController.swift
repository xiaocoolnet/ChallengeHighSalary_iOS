//
//  CHSReEditEduExperienceViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/25.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReEditEduExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource,UITextViewDelegate {
    
    let rootTableView = UITableView()
    
    let schoolNameTf = UITextField()
    
    let majorNameTf = UITextField()
    
    var pickerView = UIPickerView()
    
    let pickEduArray = ["大专","本科","硕士"]
    let pickSchoolTimeLowRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    var pickSchoolTimeSupRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    
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
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.title = "编写教育经历"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .Done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.separatorStyle = .None
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
//        if
//            CHSUserInfo.currentUserInfo.work_property ==  detailArray[0] &&
//                CHSUserInfo.currentUserInfo.address ==  detailArray[1] &&
//                CHSUserInfo.currentUserInfo.position_type ==  detailArray[2] &&
//                CHSUserInfo.currentUserInfo.categories ==  detailArray[3] &&
//                CHSUserInfo.currentUserInfo.wantsalary ==  detailArray[4] &&
//                CHSUserInfo.currentUserInfo.jobstate ==  detailArray[5]{
//            
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
//            
//            return
//        }
        
        if schoolNameTf.text!.isEmpty {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入学校名称"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if majorNameTf.text!.isEmpty {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入专业"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if detailArray[2] == "选择学历" {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请选择学历"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if detailArray[3] == "请选择就读时间段" {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请选择就读时间段"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if schoolExpTv.text!.isEmpty {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入在校经历"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        checkCodeHud.labelText = "正在保存教育经历"
        
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
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "保存教育经历成功"
                    checkCodeHud.hide(true, afterDelay: 1)
                    
                    let time: NSTimeInterval = 1.0
                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                    
                    dispatch_after(delay, dispatch_get_main_queue()) {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }else{
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "保存教育经历失败"
                    checkCodeHud.hide(true, afterDelay: 1)
                }

        }
    }
    
    // MARK:- tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return nameArray.count
        }else{
            return 2
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("jobExperience")
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "jobExperience")
                
                cell?.selectionStyle = .None
                
                cell?.accessoryType = .DisclosureIndicator
                cell?.textLabel?.font = UIFont.systemFontOfSize(16)
                cell?.textLabel?.textColor = UIColor.blackColor()
                cell?.textLabel?.textAlignment = .Left
                cell?.textLabel?.text = nameArray[indexPath.row]
                
                if indexPath.row == 0 {
                    
                    schoolNameTf.frame = CGRectMake(0, 0, 150, 50)
                    schoolNameTf.font = UIFont.systemFontOfSize(14)
                    schoolNameTf.placeholder = detailArray[indexPath.row]
                    schoolNameTf.textAlignment = .Right
                    cell?.accessoryView = schoolNameTf
                }else if indexPath.row == 1 {
                    
                    majorNameTf.frame = CGRectMake(0, 0, 150, 50)
                    majorNameTf.font = UIFont.systemFontOfSize(14)
                    majorNameTf.placeholder = detailArray[indexPath.row]
                    majorNameTf.textAlignment = .Right
                    cell?.accessoryView = majorNameTf
                }else{
                    
                    
                    cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.textAlignment = .Right
                    cell?.detailTextLabel?.text = detailArray[indexPath.row]
                }
                
                if indexPath.row < nameArray.count-1 {
                    drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 59), toPoint: CGPointMake(screenSize.width-8, 59), lineWidth: 1/UIScreen.mainScreen().scale)
                }
            }
            
            if indexPath.row == 0 {
                
                
                schoolNameTf.text = schoolNameTf.text == "" ? nil:schoolNameTf.text
            }else if indexPath.row == 1 {
                
                majorNameTf.text = majorNameTf.text == "" ? nil:majorNameTf.text
            }else{
                
                
                cell?.detailTextLabel?.text = detailArray[indexPath.row]
            }
            
            if indexPath.row < nameArray.count-1 {
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 59), toPoint: CGPointMake(screenSize.width-8, 59), lineWidth: 1/UIScreen.mainScreen().scale)
            }
            
            return cell!
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("jobContentCell")
            
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "jobContentCell")
                
                cell?.selectionStyle = .None
                
                if indexPath.row == 0 {
                    schoolExpTv.frame = CGRectMake(0, 0, screenSize.width, kHeightScale*115)
                    schoolExpTv.font = UIFont.systemFontOfSize(14)
                    schoolExpTv.delegate = self
                    cell?.contentView.addSubview(schoolExpTv)
                    
                    drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 115), toPoint: CGPointMake(screenSize.width-8, 115), lineWidth: 1/UIScreen.mainScreen().scale)
                    
                }else{
                    
                    cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
                    cell?.detailTextLabel?.textColor = baseColor
                    cell?.detailTextLabel?.textAlignment = .Right
                    cell?.detailTextLabel?.text = "0/300"
                }
            }
            
            schoolExpTv.text = schoolExpTv.text == "" ? nil:schoolExpTv.text
            
            return cell!
        }
    }
        
    // MARK:- tableView delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 35
        }else if section == 1 {
            return 35
        }else{
            return 0.0001
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let sectionHeaderBgView = UIView(frame: CGRectMake(0, 0, screenSize.width, 35))
            
            let sectionHeaderLab = UILabel(frame: CGRectMake(20, 0, screenSize.width-40, 35))
            sectionHeaderLab.font = UIFont.systemFontOfSize(15)
            sectionHeaderLab.textColor = UIColor.lightGrayColor()
            sectionHeaderLab.text = "教育经历"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else if section == 1 {
            
            let sectionHeaderBgView = UIView(frame: CGRectMake(0, 0, screenSize.width, 35))
            
            let sectionHeaderLab = UILabel(frame: CGRectMake(20, 0, screenSize.width-40, 35))
            sectionHeaderLab.font = UIFont.systemFontOfSize(15)
            sectionHeaderLab.textColor = UIColor.lightGrayColor()
            sectionHeaderLab.text = "在校经历"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else{
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 60
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 116
            }else if indexPath.row == 1 {
                return 40
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section,indexPath.row) {
        case (0,1):
            break
            self.navigationController?.pushViewController(CHSReChoosePositionTypeViewController(), animated: true)
            
        default:
            
            let bigBgView = UIButton(frame: self.view.bounds)
            bigBgView.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
            bigBgView.tag = 1000
            bigBgView.addTarget(self, action: #selector(pickerCancelClick), forControlEvents: .TouchUpInside)
            self.view.addSubview(bigBgView)
            
            let pickerBgView = UIView(frame: CGRectMake(0, screenSize.height-kHeightScale*240, screenSize.width, kHeightScale*240))
            pickerBgView.backgroundColor = UIColor.whiteColor()
            bigBgView.addSubview(pickerBgView)
            
            let pickerLab = UILabel(frame: CGRectMake(0, 0, screenSize.width, 43))
            pickerLab.textAlignment = .Center
            pickerBgView.addSubview(pickerLab)
            
            drawDashed(pickerBgView, color: UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1), fromPoint: CGPointMake(0, 43), toPoint: CGPointMake(screenSize.width, 43), lineWidth: 1)
            
            pickerView = UIPickerView(frame: CGRectMake(0, 44, screenSize.width, kHeightScale*240-88))
            
            //            pickerView.subviews[0].layer.borderWidth = 0.5
            //
            //            pickerView.subviews[0].layer.borderColor = UIColor.redColor().CGColor
            //指定Picker的代理
            pickerView.dataSource = self
            pickerView.delegate = self
            
            pickerBgView.addSubview(pickerView)
            
            drawDashed(pickerBgView, color: UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1), fromPoint: CGPointMake(0, kHeightScale*240-44), toPoint: CGPointMake(screenSize.width, kHeightScale*240-44), lineWidth: 1)
            
            let cancelBtn = UIButton(frame: CGRectMake(0, kHeightScale*240-43, screenSize.width/2.0-0.5, 43))
            cancelBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            cancelBtn.setTitle("取消", forState: .Normal)
            cancelBtn.addTarget(self, action: #selector(pickerCancelClick), forControlEvents: .TouchUpInside)
            pickerBgView.addSubview(cancelBtn)
            
            drawDashed(pickerBgView, color: UIColor(red: 226/255.0, green: 226/255.0, blue: 226/255.0, alpha: 1), fromPoint: CGPointMake(screenSize.width/2.0-0.5, kHeightScale*240-43), toPoint: CGPointMake(screenSize.width/2.0-0.5, kHeightScale*240), lineWidth: 1)
            
            let sureBtn = UIButton(frame: CGRectMake(screenSize.width/2.0-0.5, kHeightScale*240-43, screenSize.width/2.0-0.5, 43))
            sureBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            sureBtn.setTitle("确定", forState: .Normal)
            sureBtn.addTarget(self, action: #selector(sureBtnClick), forControlEvents: .TouchUpInside)
            pickerBgView.addSubview(sureBtn)
            
            switch (indexPath.section,indexPath.row) {
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
    
    func textViewDidChange(textView: UITextView) {
        
        let lang = textInputMode?.primaryLanguage
        if lang == "zh-Hans" {
            let range = textView.markedTextRange
            if range == nil {
                if textView.text?.characters.count >= schoolExpMaxCount {
                    textView.text = textView.text?.substringToIndex((textView.text?.startIndex.advancedBy(schoolExpMaxCount))!)
                }
            }
        }
        else {
            if textView.text?.characters.count >= schoolExpMaxCount {
                textView.text = textView.text?.substringToIndex((textView.text?.startIndex.advancedBy(schoolExpMaxCount))!)
            }
        }
        
        let cell = rootTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1))
        cell?.detailTextLabel?.text = "\((textView.text?.characters.count)!)/\(schoolExpMaxCount)"
    }
    
    // MARK: 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            detailArray[2] = "\(pickEduArray[pickerView.selectedRowInComponent(0)])"
            
            pickSelectedRowArray[0][0] = pickerView.selectedRowInComponent(0)
        }else if pickerView.tag == 102 {
            
            detailArray[3] = "\(pickSchoolTimeLowRequiredArray[pickerView.selectedRowInComponent(0)])-\(pickSchoolTimeSupRequiredArray[pickerView.selectedRowInComponent(2)])"
            
            pickSelectedRowArray[1][0] = pickerView.selectedRowInComponent(0)
        }
        
        //        NSUserDefaults.standardUserDefaults().setValue(detailArray, forKey: FTPublishJobdetailArray_key)
        
        //        pickerView.removeFromSuperview()
        
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: 改变分割线颜色
    func changeSeparatorWithView(view: UIView) {
        
        if view.bounds.size.height <= 1 {
            view.backgroundColor = baseColor
        }
        
        for subview in view.subviews {
            self.changeSeparatorWithView(subview)
        }
    }
    
    // MARK:- UIPickerView DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 101 {
            return 1
        }else if pickerView.tag == 102 {
            return 3
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
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
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 101 {
            
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                pickSchoolTimeSupRequiredArray = Array(pickSchoolTimeLowRequiredArray[row ..< pickSchoolTimeLowRequiredArray.count])
                
            }
        }else{
            
        }
        
        pickerView.reloadAllComponents()
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        self.changeSeparatorWithView(pickerView)
        
        let view = UILabel(frame: CGRectMake(0, 0, 20, 25))
        //        view.backgroundColor = UIColor.cyanColor()
        view.frame.size = pickerView.rowSizeForComponent(component)
        view.textAlignment = .Center
        
        if row == pickerView.selectedRowInComponent(component) {
            view.textColor = baseColor
        }else{
            view.textColor = UIColor.lightGrayColor()
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
