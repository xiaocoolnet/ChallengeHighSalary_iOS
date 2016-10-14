//
//  CHSReProjectExperienceViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReProjectExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let rootTableView = UITableView()
    
    let projectNameTf = UITextField()
    
    var pickerView = UIPickerView()

    var pickYearRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    var pickMonthRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    
    var pickYearLowRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    var pickMonthLowRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    var pickYearSupRequiredArray = ["2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年","2018年","2019年"]
    var pickMonthSupRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    
    var pickSelectedRowArray = [[0,0],[0,0]]
    
    let nameArray = ["项目名称","开始时间","结束时间","项目描述"]
    
    var detailArray = CHSUserInfo.currentUserInfo.project?.count > 0 ? [
        (CHSUserInfo.currentUserInfo.project?.first?.project_name)! == "" ? "输入项目名称":(CHSUserInfo.currentUserInfo.project?.first?.project_name)!,
        (CHSUserInfo.currentUserInfo.project?.first?.start_time)! == "" ? "请选择开始时间":(CHSUserInfo.currentUserInfo.project?.first?.start_time)!,
        (CHSUserInfo.currentUserInfo.project?.first?.end_time)! == "" ? "请选择结束时间":(CHSUserInfo.currentUserInfo.project?.first?.end_time)!,
        (CHSUserInfo.currentUserInfo.project?.first?.project_description)! == "" ? "请填写项目描述":"已填写"
        ]:["输入项目名称","请选择开始时间","请选择结束时间","请填写项目描述"] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    var project_description = CHSUserInfo.currentUserInfo.project?.count > 0 ? CHSUserInfo.currentUserInfo.project?.first?.project_description:"" {
        didSet {
            detailArray[3] = "已填写"
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

        self.title = "项目经验"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .Done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        // 加起止时间的判断
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if self.projectNameTf.text!.isEmpty {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入项目名称"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if detailArray[1] == "选择开始时间" {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请选择开始时间"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if detailArray[2] == "选择结束时间" {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请选择结束时间"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if detailArray[3] == "请填写项目描述" {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请填写项目描述"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else{
            
            if pickSelectedRowArray[0][0] > pickSelectedRowArray[1][0] {
                
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "开始时间晚于结束时间"
                checkCodeHud.detailsLabelText = "请重新选择起止时间"
                checkCodeHud.hide(true, afterDelay: 1)
                return
            }else if pickSelectedRowArray[0][0] == pickSelectedRowArray[1][0]{
                
                if pickSelectedRowArray[0][1] > pickSelectedRowArray[1][1]{
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "开始时间晚于结束时间"
                    checkCodeHud.detailsLabelText = "请重新选择起止时间"
                    checkCodeHud.hide(true, afterDelay: 1)
                    return
                }
            }
        }
        
        if CHSUserInfo.currentUserInfo.project?.first?.project_name ==  self.projectNameTf.text! && CHSUserInfo.currentUserInfo.project?.first?.start_time ==  self.detailArray[1] && CHSUserInfo.currentUserInfo.project?.first?.end_time ==  self.detailArray[2] && CHSUserInfo.currentUserInfo.project?.first?.project_description ==  self.project_description {
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "信息未修改"
            checkCodeHud.hide(true, afterDelay: 1)
            
            let time: NSTimeInterval = 1.0
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            
            dispatch_after(delay, dispatch_get_main_queue()) {
                self.navigationController?.popViewControllerAnimated(true)
            }
            return
        }
        
        checkCodeHud.labelText = "正在保存工作经历"
        
        CHSNetUtil().PublishProject(
            CHSUserInfo.currentUserInfo.userid,
            project_name: self.projectNameTf.text!,
            start_time: detailArray[1],
            end_time: detailArray[2],
            description: self.project_description!,
            handle: { (success, response) in
                if success {
                    
                    self.detailArray = [
                        (CHSUserInfo.currentUserInfo.project?.first?.project_name)! == "" ? "输入项目名称":(CHSUserInfo.currentUserInfo.project?.first?.project_name)!,
                        (CHSUserInfo.currentUserInfo.project?.first?.start_time)! == "" ? "请选择开始时间":(CHSUserInfo.currentUserInfo.project?.first?.start_time)!,
                        (CHSUserInfo.currentUserInfo.project?.first?.end_time)! == "" ? "请选择结束时间":(CHSUserInfo.currentUserInfo.project?.first?.end_time)!,
                        (CHSUserInfo.currentUserInfo.project?.first?.project_description)! == "" ? "请填写项目描述":"已填写"
                    ]
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "保存工作经历成功"
                    checkCodeHud.hide(true, afterDelay: 1)
                    
                    let time: NSTimeInterval = 1.0
                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                    
                    dispatch_after(delay, dispatch_get_main_queue()) {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }else{
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "保存工作经历失败"
                    checkCodeHud.hide(true, afterDelay: 1)
                }

        })

    }
    
    // MARK:- tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("myInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "myInfoCell")
        }
        
        cell?.selectionStyle = .None
        cell?.accessoryType = .DisclosureIndicator
        cell?.textLabel?.font = UIFont.systemFontOfSize(16)
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.text = nameArray[indexPath.row]
        
        if indexPath.row == 0 {
            
            projectNameTf.frame = CGRectMake(0, 0, 150, 50)
            projectNameTf.font = UIFont.systemFontOfSize(14)
            projectNameTf.placeholder = detailArray[indexPath.row]
            projectNameTf.textAlignment = .Right
            projectNameTf.text = projectNameTf.text == "" ? "":projectNameTf.text
            cell?.accessoryView = projectNameTf
        }else{
            
            
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .Right
            cell?.detailTextLabel?.text = detailArray[indexPath.row]
        }
        
        return cell!
    }
    
    // MARK:- tableView delegate
    var othersDrop = DropDown()
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            break
        
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
            case (0,1):

                pickerLab.text = "开始时间"
                
                pickerView.tag = 101
                pickerView.selectRow(pickSelectedRowArray[0][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[0][1], inComponent: 1, animated: false)
            case (0,2):
                
                pickerLab.text = "结束时间"
                
                pickerView.tag = 102

                pickerView.selectRow(pickSelectedRowArray[1][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[1][1], inComponent: 1, animated: false)
            default:
                print("找人才-人才-发布职位-didSelectRowAtIndexPath  default")

            }
            
            print("找人才-人才-发布职位-didSelectRowAtIndexPath  default")
        }
    }
    
    // MARK: 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            detailArray[1] = "\(pickYearLowRequiredArray[pickerView.selectedRowInComponent(0)]).\(pickMonthLowRequiredArray[pickerView.selectedRowInComponent(1)])"
            
            pickSelectedRowArray[0][0] = pickerView.selectedRowInComponent(0)
            pickSelectedRowArray[0][1] = pickerView.selectedRowInComponent(1)
        }else if pickerView.tag == 102 {
            
            detailArray[2] = "\(pickYearSupRequiredArray[pickerView.selectedRowInComponent(0)]).\(pickMonthSupRequiredArray[pickerView.selectedRowInComponent(1)])"
            
            pickSelectedRowArray[1][0] = pickerView.selectedRowInComponent(0)
            pickSelectedRowArray[1][1] = pickerView.selectedRowInComponent(1)
        }
        
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
            return 2
        }else if pickerView.tag == 102 {
            return 2
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
            }else{
                return 0
            }
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                return pickYearSupRequiredArray.count
            }else if component == 1 {
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
        
//        if pickerView.tag == 101 {
//            
//
//        }else if pickerView.tag == 102 {
//       
//        }
        
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
            }
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                view.text = pickYearSupRequiredArray[row]
            }else if component == 1 {
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
