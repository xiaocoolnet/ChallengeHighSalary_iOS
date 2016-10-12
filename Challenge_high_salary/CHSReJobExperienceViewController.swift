//
//  CHSReJobExperienceViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReJobExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LoReFTInfoInputViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let rootTableView = UITableView()
    
    var pickerView = UIPickerView()
    
    let pickYearLowRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    let pickMonthLowRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    var pickYearSupRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    var pickMonthSupRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]

    var pickSelectedRowArray = [0,0,0,0]

    
    let nameArray = ["公司名称","公司行业","职位类型","技能展示","任职时间段"]
    var detailArray = ["请输入公司名称","选择行业","选择职位类型","请选择技能","选择任职时间段"] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(JobIntensionChanged(_:)), name: "PersonalChangeJobExperienceNotification", object: nil)
    }
    
    func JobIntensionChanged(noti:NSNotification) {
        let userInfo = noti.userInfo
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
        
        self.customizeDropDown()
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

        self.title = "编写工作经历"
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
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: LoReFTInfoInputViewControllerDelegate
    func LoReFTInfoInputClickSaveBtn(infoType: InfoType, text: String) {
        switch infoType {
        case .JobExp_CompanyName:
            detailArray[0] = text
        default:
            break
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
            }
            
            cell?.selectionStyle = .None
            
            cell?.accessoryType = .DisclosureIndicator
            cell?.textLabel?.font = UIFont.systemFontOfSize(16)
            cell?.textLabel?.textColor = UIColor.blackColor()
            cell?.textLabel?.textAlignment = .Left
            cell?.textLabel?.text = nameArray[indexPath.row]
            
//            if indexPath.row == 0 {
            
//                let companyNameTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
//                companyNameTf.font = UIFont.systemFontOfSize(14)
//                companyNameTf.placeholder = detailArray[indexPath.row]
//                companyNameTf.textAlignment = .Right
//                cell?.accessoryView = companyNameTf
//            }else{
                
            
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .Right
            cell?.detailTextLabel?.text = detailArray[indexPath.row]
//            }
            
            if indexPath.row < nameArray.count-1 {
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 59), toPoint: CGPointMake(screenSize.width-8, 59), lineWidth: 1/UIScreen.mainScreen().scale)
            }
            
            return cell!
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("jobContentCell")
            if cell == nil {
                cell = UITableViewCell(style: .Value1, reuseIdentifier: "jobContentCell")
            }
            
            cell?.selectionStyle = .None
            
            if indexPath.row == 0 {
                let jobContentTv = UITextView(frame: CGRectMake(0, 0, screenSize.width, kHeightScale*115))
                cell?.contentView.addSubview(jobContentTv)
                
                drawDashed((cell?.contentView)!, color: UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1), fromPoint: CGPointMake(8, 115), toPoint: CGPointMake(screenSize.width-8, 115), lineWidth: 1/UIScreen.mainScreen().scale)
                
            }else{
                
                cell?.textLabel?.font = UIFont.systemFontOfSize(13)
                cell?.textLabel?.textColor = baseColor
                cell?.textLabel?.textAlignment = .Left
                cell?.textLabel?.text = "看看别人怎么写"
                
                cell?.detailTextLabel?.font = UIFont.systemFontOfSize(13)
                cell?.detailTextLabel?.textColor = baseColor
                cell?.detailTextLabel?.textAlignment = .Right
                cell?.detailTextLabel?.text = "0/300"
                othersDrop.anchorView = cell
                othersDrop.bottomOffset = CGPoint(x: 8, y: 45)
                othersDrop.width = screenSize.width-16
                othersDrop.direction = .Bottom
                
                othersDrop.dataSource = ["不限","1万以下","1~2万","2~3万","3~4万","4~5万","5万以上"]
                
                // 下拉列表选中后的回调方法
                othersDrop.selectionAction = { (index, item) in
                    
//                    salaryBtn.setTitle(item, forState: .Normal)
                }
            }
            
            
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
            sectionHeaderLab.text = "最近一次工作经历"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else if section == 1 {
            
            let sectionHeaderBgView = UIView(frame: CGRectMake(0, 0, screenSize.width, 35))
            
            let sectionHeaderLab = UILabel(frame: CGRectMake(20, 0, screenSize.width-40, 35))
            sectionHeaderLab.font = UIFont.systemFontOfSize(15)
            sectionHeaderLab.textColor = UIColor.lightGrayColor()
            sectionHeaderLab.text = "工作内容"
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
    var othersDrop = DropDown()

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .JobExp_CompanyName
            vc.selfTitle = "公司名称"
            vc.placeHolder = "请输入公司名称"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.blackColor() ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = ""
            vc.hudTipText = "请输入公司名称"
            vc.maxCount = 20
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case (0,1):
            
            let industryCategoriesVC = CHSReChooseIndustryCategoriesViewController()
            industryCategoriesVC.navTitle = "公司行业选择"
            industryCategoriesVC.vcType = .JobExperience
            
            self.navigationController?.pushViewController(industryCategoriesVC, animated: true)
            
        case (0,2):
            
            let choosePositionTypeVC = CHSReChoosePositionTypeViewController()
            choosePositionTypeVC.vcType = .JobExperience
            self.navigationController?.pushViewController(choosePositionTypeVC, animated: true)
        case (0,3):
            
            let choosePositionTypeVC = CHSReJobExpSkillViewController()
            self.navigationController?.pushViewController(choosePositionTypeVC, animated: true)
        case (0,4):
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
            
            pickerLab.text = "任职时间段"
            
            pickerView.tag = 101
            pickerView.selectRow(pickSelectedRowArray[0], inComponent: 0, animated: false)
            pickerView.selectRow(pickSelectedRowArray[1], inComponent: 1, animated: false)
            pickerView.selectRow(pickSelectedRowArray[2], inComponent: 3, animated: false)
            pickerView.selectRow(pickSelectedRowArray[3], inComponent: 4, animated: false)
            
        case (1,1):
            othersDrop.show()
        default:
            
            print("找人才-人才-发布职位-didSelectRowAtIndexPath  default")
        }
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
        appearance.textColor = .darkGrayColor()
        appearance.textFont = UIFont.systemFontOfSize(14)
    }
    
    // MARK: 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            detailArray[4] = "\(pickYearLowRequiredArray[pickerView.selectedRowInComponent(0)]).\(pickMonthLowRequiredArray[pickerView.selectedRowInComponent(1)])-\(pickYearSupRequiredArray[pickerView.selectedRowInComponent(3)]).\(pickMonthSupRequiredArray[pickerView.selectedRowInComponent(4)])"
            
            pickSelectedRowArray[0] = pickerView.selectedRowInComponent(0)
            pickSelectedRowArray[1] = pickerView.selectedRowInComponent(1)
            pickSelectedRowArray[2] = pickerView.selectedRowInComponent(3)
            pickSelectedRowArray[3] = pickerView.selectedRowInComponent(4)
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
            return 5
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

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
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 101 {
            
            pickYearSupRequiredArray = Array(pickYearLowRequiredArray[pickerView.selectedRowInComponent(0) ..< pickYearLowRequiredArray.count])
            
            if pickYearSupRequiredArray[pickerView.selectedRowInComponent(3)] ==  pickYearLowRequiredArray[pickerView.selectedRowInComponent(0)]{
                pickMonthSupRequiredArray = Array(pickMonthLowRequiredArray[pickerView.selectedRowInComponent(1) ..< pickMonthLowRequiredArray.count])
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
