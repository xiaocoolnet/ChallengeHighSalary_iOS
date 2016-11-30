//
//  LoReCHSJobIntensionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/14.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReCHSJobIntensionViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let rootTableView = UITableView()
    
    var pickerView = UIPickerView()
    
    let pickJobTypeRequiredArray = ["全职","兼职"]
    let pickExpSalaryLowRequiredArray = ["1k","2k","3k","4k","5k"]
    var pickExpSalarySupRequiredArray = ["1k","2k","3k","4k","5k"]
    let pickJobStatusRequiredArray = ["离职","在职"]
    
    var pickSelectedRowArray = [[0],[0,0],[0,0],[0]]
    
    fileprivate var areaDic = [String:[String:Array<String>]]() // 地区 字典
    fileprivate var provinceArray=Array<String>() // 省
    fileprivate var cityArray=Array<String>()  // 市
    fileprivate var areaArray=Array<String>() // 区县州
    
    let nameArray = ["工作性质","工作地点","职位类型","行业类别","期望薪资","工作状态"]
    
    var detailArray = [
        "\(CHSUserInfo.currentUserInfo.work_property)",
        "\(CHSUserInfo.currentUserInfo.address)",
        "\(CHSUserInfo.currentUserInfo.position_type)",
        "\(CHSUserInfo.currentUserInfo.categories)",
        "\(CHSUserInfo.currentUserInfo.wantsalary)",
        "\(CHSUserInfo.currentUserInfo.jobstate)"
        ] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadData()
        setSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(JobIntensionChanged(_:)), name: NSNotification.Name(rawValue: "PersonalChangeJobIntensionNotification"), object: nil)
    }
    
    func JobIntensionChanged(_ noti:Notification) {
        let userInfo = (noti as NSNotification).userInfo
        if (userInfo != nil) {
            if userInfo!["type"] as! String == "PositionType" {
                detailArray[2] = userInfo!["value"] as! String
            }else if userInfo!["type"] as! String == "Categories" {
                detailArray[3] = userInfo!["value"] as! String
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: 加载数据
    func loadData() {
        
        //        NSUserDefaults.standardUserDefaults().setValue(detailArray, forKey: FTPublishJobdetailArray_key)
        
        areaDic = NSDictionary.init(contentsOfFile: Bundle.main.path(forAuxiliaryExecutable: "area.plist")!)!  as! [String:[String:Array<String>]]
        provinceArray = Array(areaDic.keys)
        provinceArray = provinceArray.sorted(by: { (str1, str2) -> Bool in
            str1 < str2
        })
        
        cityArray = Array(areaDic[provinceArray.first!]!.keys)
        
        detailArray = [
            CHSUserInfo.currentUserInfo.work_property == "" ? pickJobTypeRequiredArray.first!:CHSUserInfo.currentUserInfo.work_property,
            CHSUserInfo.currentUserInfo.address == "" ? "\(provinceArray[0])-\(cityArray[0])":CHSUserInfo.currentUserInfo.address,
            CHSUserInfo.currentUserInfo.position_type == "" ? "职位类型":CHSUserInfo.currentUserInfo.position_type,
            CHSUserInfo.currentUserInfo.categories == "" ? "行业类别":CHSUserInfo.currentUserInfo.categories,
            CHSUserInfo.currentUserInfo.wantsalary == "" ? "\(pickExpSalaryLowRequiredArray[0])至\(pickExpSalarySupRequiredArray[0]) /月":CHSUserInfo.currentUserInfo.categories,
            CHSUserInfo.currentUserInfo.jobstate == "" ? pickJobStatusRequiredArray[0]:CHSUserInfo.currentUserInfo.jobstate
        ]
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
        
        self.title = "求职意向"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let postPositionBtn = UIButton(frame: CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44))
        postPositionBtn.backgroundColor = baseColor
        postPositionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        postPositionBtn.setTitleColor(UIColor.white, for: UIControlState())
        postPositionBtn.setTitle("挑战高薪，GO！", for: UIControlState())
        postPositionBtn.addTarget(self, action: #selector(clickSaveBtn), for: .touchUpInside)
        self.view.addSubview(postPositionBtn)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if detailArray[2] == "职位类型" || detailArray[3] == "行业类别" {
            checkCodeHud.mode = .text
            checkCodeHud.labelText = "请完善求职意向"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }
        
        checkCodeHud.labelText = "正在上传求职意向"
        
        CHSNetUtil().PublishIntension(
            CHSUserInfo.currentUserInfo.userid,
            work_property: detailArray[0],
            address: detailArray[1],
            position_type: detailArray[2],
            categories: detailArray[3],
            wantsalary: detailArray[4],
            jobstate: detailArray[5]) { (success, response) in
                if success {
                    
                    CHSUserInfo.currentUserInfo.work_property =  self.detailArray[0]
                    CHSUserInfo.currentUserInfo.address =  self.detailArray[1]
                    CHSUserInfo.currentUserInfo.position_type =  self.detailArray[2]
                    CHSUserInfo.currentUserInfo.categories =  self.detailArray[3]
                    CHSUserInfo.currentUserInfo.wantsalary =  self.detailArray[4]
                    CHSUserInfo.currentUserInfo.jobstate =  self.detailArray[5]
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.labelText = "求职意向保存成功"
                    checkCodeHud.hide(true, afterDelay: 1)
                    
                    let time: TimeInterval = 1.0
                    let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        _ = self.navigationController?.popViewController(animated: true)
                        self.present(CHRoHomeViewController(), animated: true, completion: nil)
                    }
                }else{
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.labelText = "求职意向保存失败"
                    checkCodeHud.hide(true, afterDelay: 1)
                }
        }
    }
    
    // MARK:- tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "myInfoCell")
        }
        
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.text = nameArray[(indexPath as NSIndexPath).row]
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
        cell?.detailTextLabel?.textAlignment = .right
        cell?.detailTextLabel?.text = detailArray[(indexPath as NSIndexPath).row]
        
        return cell!
    }
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,2):
            
            let choosePositionTypeVC = CHSReChoosePositionTypeViewController()
            choosePositionTypeVC.vcType = .intension
            self.navigationController?.pushViewController(choosePositionTypeVC, animated: true)
        case (0,3):
            
            let industryCategoriesVC = CHSReChooseIndustryCategoriesViewController()
            industryCategoriesVC.navTitle = "行业选择"
            industryCategoriesVC.vcType = .intension
            
            self.navigationController?.pushViewController(industryCategoriesVC, animated: true)
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
            case (0,0):
                pickerLab.text = "工作性质"
                
                pickerView.tag = 101
                pickerView.selectRow(pickSelectedRowArray[0][0], inComponent: 0, animated: false)
            case (0,1):
                
                pickerLab.text = "工作地点"
                
                pickerView.tag = 102
                pickerView.selectRow(pickSelectedRowArray[1][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[1][1], inComponent: 1, animated: false)
            case (0,4):
                pickerLab.text = "期望薪资"
                
                pickerView.tag = 103
                pickerView.selectRow(pickSelectedRowArray[2][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[2][1], inComponent: 2, animated: false)
                
            case (0,5):
                
                pickerLab.text = "工作状态"
                
                pickerView.tag = 104
                pickerView.selectRow(pickSelectedRowArray[3][0], inComponent: 0, animated: false)
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
            
            detailArray[0] = "\(pickJobTypeRequiredArray[pickerView.selectedRow(inComponent: 0)])"
            
            pickSelectedRowArray[0][0] = pickerView.selectedRow(inComponent: 0)
        }else if pickerView.tag == 102 {
            
            detailArray[1] = "\(provinceArray[pickerView.selectedRow(inComponent: 0)])-\(cityArray[pickerView.selectedRow(inComponent: 1)])"
            
            pickSelectedRowArray[1][0] = pickerView.selectedRow(inComponent: 0)
        }else if pickerView.tag == 103 {
            
            detailArray[4] = "\(pickExpSalaryLowRequiredArray[pickerView.selectedRow(inComponent: 0)])至\(pickExpSalarySupRequiredArray[pickerView.selectedRow(inComponent: 2)]) /月"
            
            pickSelectedRowArray[2][0] = pickerView.selectedRow(inComponent: 0)
            pickSelectedRowArray[2][1] = pickerView.selectedRow(inComponent: 2)
        }else if pickerView.tag == 104 {
            
            detailArray[5] = pickJobStatusRequiredArray[pickerView.selectedRow(inComponent: 0)]
            
            pickSelectedRowArray[3][0] = pickerView.selectedRow(inComponent: 0)
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
            return 2
        }else if pickerView.tag == 103 {
            return 3
        }else if pickerView.tag == 104 {
            return 1
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            return pickJobTypeRequiredArray.count
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                return provinceArray.count
            }else{
                return cityArray.count
            }
        }else if pickerView.tag == 103 {
            
            if component == 0 {
                return pickExpSalaryLowRequiredArray.count
            }else if component == 1 {
                return 1
            }else{
                return pickExpSalarySupRequiredArray.count
            }
        }else if pickerView.tag == 104 {
            
            return pickJobStatusRequiredArray.count
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
                cityArray = Array(areaDic[provinceArray[row]]!.keys)
                
            }
        }else if pickerView.tag == 103 {
            
            if component == 0 {
                pickExpSalarySupRequiredArray = Array(pickExpSalaryLowRequiredArray[row ..< pickExpSalaryLowRequiredArray.count])
                
            }
        }else if pickerView.tag == 104 {
            
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
            
            view.text = pickJobTypeRequiredArray[row]
        }else if pickerView.tag == 102 {
            
            if component == 0 {
                view.text = provinceArray[row]
            }else{
                view.text = cityArray[row]
            }
        }else if pickerView.tag == 103 {
            
            if component == 0 {
                view.text = pickExpSalaryLowRequiredArray[row]
            }else if component == 1 {
                view.text = "至"
            }else{
                view.text = pickExpSalarySupRequiredArray[row]
            }
        }else if pickerView.tag == 104 {
            
            view.text = pickJobStatusRequiredArray[row]
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
