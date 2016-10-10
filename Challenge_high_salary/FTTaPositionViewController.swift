//
//  FTTaPositionViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaPositionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let rootTableView = UITableView(frame: CGRectMake(0, 64, screenSize.width, screenSize.height-64), style: .Grouped)
    let nameArray = [["公司信息"],["职位类型","职位名称","技能要求","薪资范围"],["经验要求","学历要求"],["工作城市","工作地点","职位描述"]]
    var selectedNameArray = [["公司信息"],["职位类型","职位名称","技能要求","薪资范围"],["经验要求","学历要求"],["工作城市","工作地点","职位描述"]] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    var pickSelectedRowArray = [[0,0],[0],[0],[0,0]]
    
    let pickLowArray = ["1","2","3","4","5"]
    var pickSupArray = ["1","2","3","4","5"]
    
    let pickExpRequiredArray = ["不限","应届生","1年以内","1-3年"]
    let pickEduRequiredArray = ["不限","大专","本科","研究生"]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.loadData()
        self.setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
        
        selectedNameArray = NSUserDefaults.standardUserDefaults().arrayForKey(FTPublishJobSelectedNameArray_key) as! [Array<String>]
    }
    
    private var areaDic = [String:[String:Array<String>]]() // 地区 字典
    private var provinceArray=Array<String>() // 省
    private var cityArray=Array<String>()  // 市
    private var areaArray=Array<String>() // 区县州
    
    // MARK: 加载数据
    func loadData() {
        
        NSUserDefaults.standardUserDefaults().setValue(selectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
        
        areaDic = NSDictionary.init(contentsOfFile: NSBundle.mainBundle().pathForAuxiliaryExecutable("area.plist")!)!  as! [String:[String:Array<String>]]
        provinceArray = Array(areaDic.keys)
        provinceArray = provinceArray.sort({ (str1, str2) -> Bool in
            str1 < str2
        })
        
        cityArray = Array(areaDic[provinceArray.first!]!.keys)
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.title = "发布职位"
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(rootTableView)
        
        let postPositionBtn = UIButton(frame: CGRectMake(0, screenSize.height-44, screenSize.width, 44))
        postPositionBtn.backgroundColor = baseColor
        postPositionBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        postPositionBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        postPositionBtn.setTitle("发布职位", forState: .Normal)
        postPositionBtn.addTarget(self, action: #selector(postPositionBtnClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(postPositionBtn)
    }
    
    // MARK: 发布职位按钮 点击事件
    func postPositionBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
//        [["公司信息"],["职位类型","职位名称","技能要求","薪资范围"],["经验要求","学历要求"],["工作城市","工作地点","职位描述"]] 
        if  selectedNameArray[1][0] == "职位类型" ||
            selectedNameArray[1][1] == "职位名称" ||
            selectedNameArray[1][2] == "技能要求" ||
            selectedNameArray[1][3] == "薪资范围" ||
            selectedNameArray[2][0] == "经验要求" ||
            selectedNameArray[2][1] == "学历要求" ||
            selectedNameArray[3][0] == "工作城市" ||
            selectedNameArray[3][1] == "工作地点" ||
            selectedNameArray[3][2] == "职位描述"{
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请完善职位信息"
            checkCodeHud.hide(true, afterDelay: 1)
        }else{
            
            checkCodeHud.labelText = "正在发布职位"
            
            FTNetUtil().publishjob(
                CHSUserInfo.currentUserInfo.userid,
                jobtype: selectedNameArray[1][0],
                title: selectedNameArray[1][1],
                skill: selectedNameArray[1][2],
                salary: selectedNameArray[1][3],
                experience: selectedNameArray[2][0],
                education: selectedNameArray[2][1],
                city: selectedNameArray[3][0],
                address: selectedNameArray[3][1],
                description: selectedNameArray[3][2]) { (success, response) in
                    if success {
                        
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelText = "发布职位成功"
                        checkCodeHud.hide(true, afterDelay: 1)
                        
                        let time: NSTimeInterval = 1.0
                        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                        
                        dispatch_after(delay, dispatch_get_main_queue()) {
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    }else{
                        
                        checkCodeHud.mode = .Text
                        checkCodeHud.labelText = "发布职位失败"
                        checkCodeHud.hide(true, afterDelay: 1)
                    }
            }
        }
    }
    
    // MARK:- tableview datasource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .None
        
        cell?.textLabel!.text = nameArray[indexPath.section][indexPath.row]
        
        cell!.accessoryType = .DisclosureIndicator
        
        cell?.textLabel?.font = UIFont.systemFontOfSize(15)
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.backgroundColor = UIColor.whiteColor()
        
        if indexPath.section == 0 {
            
        }else if indexPath.section == selectedNameArray.count-1 && indexPath.row == (selectedNameArray.last?.count)!-1 {
            
        }else{
            
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .Right
            cell?.detailTextLabel?.text = selectedNameArray[indexPath.section][indexPath.row]
        }
//        if indexPath.section != 0 && (indexPath.section == selectedNameArray.count-1 && indexPath.row != (selectedNameArray.last?.count)!-1)  {
//            
//        }
        
        return cell!
    }
    
    // MARK:- tableview delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return kHeightScale*15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            self.navigationController?.pushViewController(FTTaCompanyInfoViewController(), animated: true)
        case (1,0):
            self.navigationController?.pushViewController(FTTaPositionTypeViewController(), animated: true)
        case (1,1):
            self.navigationController?.pushViewController(FTTaPositionNameViewController(), animated: true)
        case (1,2):
            self.navigationController?.pushViewController(FTTaSkillRequiredViewController(), animated: true)
        case (3,1):
            self.navigationController?.pushViewController(FTTaWorkplaceViewController(), animated: true)
            
        case (3,2):
            
            self.navigationController?.pushViewController(FTTaJobDescriptionsViewController(), animated: true)
            
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
            case (1,3):
                pickerLab.text = "薪资范围（月薪，单位：千元）"
                
                pickerView.tag = 101
                pickerView.selectRow(pickSelectedRowArray[0][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[0][1], inComponent: 2, animated: false)
            case (2,0):
                
                pickerLab.text = "经验要求"
                
                pickerView.tag = 102
                pickerView.selectRow(pickSelectedRowArray[1][0], inComponent: 0, animated: false)
            case (2,1):
                pickerLab.text = "学历要求"
                
                pickerView.tag = 103
                pickerView.selectRow(pickSelectedRowArray[2][0], inComponent: 0, animated: false)
            case (3,0):
                
                pickerLab.text = "工作城市"
                
                pickerView.tag = 104
                pickerView.selectRow(pickSelectedRowArray[3][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[3][1], inComponent: 1, animated: false)
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
            
            selectedNameArray[1][3] = "\(pickLowArray[pickerView.selectedRowInComponent(0)])至\(pickSupArray[pickerView.selectedRowInComponent(2)])"
            
            pickSelectedRowArray[0][0] = pickerView.selectedRowInComponent(0)
            pickSelectedRowArray[0][1] = pickerView.selectedRowInComponent(2)
        }else if pickerView.tag == 102 {
            
            selectedNameArray[2][0] = pickExpRequiredArray[pickerView.selectedRowInComponent(0)]
            
            pickSelectedRowArray[1][0] = pickerView.selectedRowInComponent(0)
        }else if pickerView.tag == 103 {
            
            selectedNameArray[2][1] = pickEduRequiredArray[pickerView.selectedRowInComponent(0)]
            
            pickSelectedRowArray[2][0] = pickerView.selectedRowInComponent(0)
        }else if pickerView.tag == 104 {
            
            selectedNameArray[3][0] = "\(provinceArray[pickerView.selectedRowInComponent(0)])-\(cityArray[pickerView.selectedRowInComponent(1)])"

            pickSelectedRowArray[3][0] = pickerView.selectedRowInComponent(0)
            pickSelectedRowArray[3][1] = pickerView.selectedRowInComponent(1)
        }
        
        NSUserDefaults.standardUserDefaults().setValue(selectedNameArray, forKey: FTPublishJobSelectedNameArray_key)

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
            return 3
        }else if pickerView.tag == 102 {
            return 1
        }else if pickerView.tag == 103 {
            return 1
        }else if pickerView.tag == 104 {
            return 2
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            if component == 0 {
                return pickLowArray.count
            }else if component == 1 {
                return 1
            }else{
                return pickSupArray.count
            }
        }else if pickerView.tag == 102 {
            
            return pickExpRequiredArray.count
        }else if pickerView.tag == 103 {
            
            return pickEduRequiredArray.count
        }else if pickerView.tag == 104 {
            
            if component == 0 {
                return provinceArray.count
            }else{
                return cityArray.count
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
            
            if component == 0 {
                pickSupArray = Array(pickLowArray[row ..< pickLowArray.count])
                
            }
        }else if pickerView.tag == 102 {
            
            
        }else if pickerView.tag == 103 {
            
            
        }else if pickerView.tag == 104 {
            
            if component == 0 {
                cityArray = Array(areaDic[provinceArray[row]]!.keys)

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
            
            if component == 0 {
                view.text = pickLowArray[row]
            }else if component == 1 {
                view.text = "至"
            }else{
                view.text = pickSupArray[row]
            }
        }else if pickerView.tag == 102 {
            
            view.text = pickExpRequiredArray[row]
        }else if pickerView.tag == 103 {
            
            view.text = pickEduRequiredArray[row]
        }else if pickerView.tag == 104 {
            
            if component == 0 {
                view.text = provinceArray[row]
            }else{
                view.text = cityArray[row]
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
