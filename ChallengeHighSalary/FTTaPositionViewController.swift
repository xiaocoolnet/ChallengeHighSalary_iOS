//
//  FTTaPositionViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/9/24.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTTaPositionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let rootTableView = UITableView(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64), style: .grouped)
    let nameArray = [["公司信息"],["职位类型","职位名称","技能要求","薪资范围"],["工作性质","经验要求","学历要求"],["工作城市","工作地点","职位描述","公司福利"]]
    var selectedNameArray = [["公司信息"],["职位类型","职位名称","技能要求","薪资范围"],["工作性质","经验要求","学历要求"],["工作城市","工作地点","职位描述","公司福利"]] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    var pickSelectedRowArray = [[0,0],[0],[0],[0],[0,0]]
    
    let pickLowArray = ["1","2","3","4","5","6","7","8","9","10","15","20"]
    var pickSupArray = ["1","2","3","4","5","6","7","8","9","10","15","20"]
    
    let pickWorkPropertyArray = ["全职","兼职"]
    var pickExpRequiredArray = [String]()
    var pickEduRequiredArray = [String]()
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setSubviews()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        selectedNameArray = UserDefaults.standard.array(forKey: FTPublishJobSelectedNameArray_key) as! [Array<String>]
    }
    
    fileprivate var areaDic = [String:[String:Array<String>]]() // 地区 字典
    fileprivate var provinceArray=Array<String>() // 省
    fileprivate var cityArray=Array<String>()  // 市
    fileprivate var areaArray=Array<String>() // 区县州
    
    // MARK: 加载数据
    func loadData() {
        
        UserDefaults.standard.setValue(selectedNameArray, forKey: FTPublishJobSelectedNameArray_key)
        
        areaDic = NSDictionary.init(contentsOfFile: Bundle.main.path(forAuxiliaryExecutable: "area.plist")!)!  as! [String:[String:Array<String>]]
        provinceArray = Array(areaDic.keys)
        provinceArray = provinceArray.sorted(by: { (str1, str2) -> Bool in

            return self.transform(chinese: str1) < self.transform(chinese: str2)
        })
        
        cityArray = Array(areaDic[provinceArray.first!]!.keys).sorted(by: { (str1, str2) -> Bool in
            return self.transform(chinese: str1) < self.transform(chinese: str2)
        })
        
        loadNetData()
    }
    
    func transform(chinese:String) -> String {
        
        let pinyin = NSString(string: chinese).mutableCopy() as! NSMutableString
        
        CFStringTransform(pinyin, nil, kCFStringTransformMandarinLatin, false)
        
        CFStringTransform(pinyin, nil, kCFStringTransformStripCombiningMarks, false)

        return pinyin.uppercased
        
    }

    
    // MARK: - 获取数据
    func loadNetData() {
        
        var flag = 0
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.removeFromSuperViewOnHide = true
        hud.margin = 10
        
        PublicNetUtil.getDictionaryList(parentid: "52") { (success, response) in
            if success {
                
                let dicData = response as! [DicDataModel]
                
                for dic in dicData {
                    self.pickExpRequiredArray.append((dic.name ?? "")!)
                }
                
                flag += 1
                if flag >= 2 {
                    hud.hide(animated: true)
                }
                
            }else{
                
                self.loadNetData()
               
            }
        }
        
        PublicNetUtil.getDictionaryList(parentid: "60") { (success, response) in
            if success {
                hud.hide(animated: true)
                let dicData = response as! [DicDataModel]
                
                for dic in dicData {
                    self.pickEduRequiredArray.append((dic.name ?? "")!)
                }
                
                flag += 1
                if flag >= 2 {
                    hud.hide(animated: true)
                }
                
            }else{
                
                self.loadNetData()

            }
        }
        
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        
        ftPostPosition = ""
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.title = "发布职位"
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.view.addSubview(rootTableView)
        
        let postPositionBtn = UIButton(frame: CGRect(x: 0, y: screenSize.height-44, width: screenSize.width, height: 44))
        postPositionBtn.backgroundColor = baseColor
        postPositionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        postPositionBtn.setTitleColor(UIColor.white, for: UIControlState())
        postPositionBtn.setTitle("发布职位", for: UIControlState())
        postPositionBtn.addTarget(self, action: #selector(postPositionBtnClick), for: .touchUpInside)
        self.view.addSubview(postPositionBtn)
    }
    
    // MARK: 发布职位按钮 点击事件
    func postPositionBtnClick() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
//        [["公司信息"],["职位类型","职位名称","技能要求","薪资范围"],["经验要求","学历要求"],["工作城市","工作地点","职位描述"]] 
        if  selectedNameArray[1][0] == "职位类型" ||
            selectedNameArray[1][1] == "职位名称" ||
            selectedNameArray[1][2] == "技能要求" ||
            selectedNameArray[1][3] == "薪资范围" ||
            selectedNameArray[2][0] == "工作性质" ||
            selectedNameArray[2][1] == "经验要求" ||
            selectedNameArray[2][2] == "学历要求" ||
            selectedNameArray[3][0] == "工作城市" ||
            selectedNameArray[3][1] == "工作地点" ||
            selectedNameArray[3][2] == "职位描述" ||
            selectedNameArray[3][3] == "公司福利"{
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请完善职位信息"
            checkCodeHud.hide(animated: true, afterDelay: 1)
        }else{
            
            checkCodeHud.label.text = "正在发布职位"
            
            FTNetUtil().publishjob(
                CHSUserInfo.currentUserInfo.userid,
                jobtype: selectedNameArray[1][0],
                title: selectedNameArray[1][1],
                skill: selectedNameArray[1][2],
                salary: selectedNameArray[1][3],
                work_property: selectedNameArray[2][0],
                experience: selectedNameArray[2][1],
                education: selectedNameArray[2][2],
                city: selectedNameArray[3][0],
                address: selectedNameArray[3][1],
                description_job: selectedNameArray[3][2],
                welfare: selectedNameArray[3][3]) { (success, response) in
                    if success {
                        
                        checkCodeHud.mode = .text
                        checkCodeHud.label.text = "发布职位成功"
                        checkCodeHud.hide(animated: true, afterDelay: 1)
                        
                        ftPostPosition = ""
                        
                        let time: TimeInterval = 1.0
                        let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                        
                        DispatchQueue.main.asyncAfter(deadline: delay) {
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        
                        checkCodeHud.mode = .text
                        checkCodeHud.label.text = "发布职位失败"
                        checkCodeHud.hide(animated: true, afterDelay: 1)
                    }
            }
        }
    }
    
    // MARK:- tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CHSMiSettingCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "CHSMiSettingCell")
        }
        cell!.selectionStyle = .none
        
        cell?.textLabel!.text = nameArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        cell!.accessoryType = .disclosureIndicator
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.textColor = UIColor.black
        cell?.backgroundColor = UIColor.white
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
        cell?.detailTextLabel?.textAlignment = .right
        
        if (indexPath as NSIndexPath).section == 0 {
            cell?.detailTextLabel?.text = ""
        }else if indexPath.section == 1 && indexPath.row == 2 {
            
            var str = ""
            if selectedNameArray[1][2] == "技能要求" || selectedNameArray[1][2] == "" {
                str = "技能要求"
            }else{
                str = "\(selectedNameArray[1][2].components(separatedBy: "-").count)个技能"
            }
            
            cell?.detailTextLabel?.text = str
            
        }else if indexPath.section == selectedNameArray.count-1 && indexPath.row == 2 {
            cell?.detailTextLabel?.text = selectedNameArray[3][2] == "职位描述" ? "未填写":"已填写"
            
        }else if indexPath.section == selectedNameArray.count-1 && indexPath.row == 3 {
            cell?.detailTextLabel?.text = selectedNameArray[3][3] == "公司福利" ? "未填写":"已填写"
            
        }else{
            
            cell?.detailTextLabel?.text = selectedNameArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        }
//        if indexPath.section != 0 && (indexPath.section == selectedNameArray.count-1 && indexPath.row != (selectedNameArray.last?.count)!-1)  {
//            
//        }
        
        return cell!
    }
    
    // MARK:- tableview delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return kHeightScale*15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            self.navigationController?.pushViewController(FTTaCompanyInfoViewController(), animated: true)
        case (1,0):
            self.navigationController?.pushViewController(FTTaPositionTypeViewController(), animated: true)
        case (1,1):
            self.navigationController?.pushViewController(FTTaPositionNameViewController(), animated: true)
        case (1,2):
            self.navigationController?.pushViewController(FTTaSkillRequiredViewController(), animated: true)
        case (3,1):
            
            if ftPostPosition == "" {
                
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.removeFromSuperViewOnHide = true
                hud.mode = .text
                hud.label.text = "请先选择工作城市"
                hud.hide(animated: true, afterDelay: 1)
                
            }else{
                
                self.navigationController?.pushViewController(FTTaWorkplaceViewController(), animated: true)
            }
            
        case (3,2):
            
            self.navigationController?.pushViewController(FTTaJobDescriptionsViewController(), animated: true)
        case (3,3):
            
            self.navigationController?.pushViewController(FTTaCompanyWelfareViewController(), animated: true)
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
            case (1,3):
                pickerLab.text = "薪资范围（月薪，单位：千元）"
                
                pickerView.tag = 101
                pickerView.selectRow(pickSelectedRowArray[0][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[0][1], inComponent: 2, animated: false)
            case (2,0):
                
                pickerLab.text = "工作性质"
                
                pickerView.tag = 120
                pickerView.selectRow(pickSelectedRowArray[1][0], inComponent: 0, animated: false)
            case (2,1):
                
                pickerLab.text = "经验要求"
                
                pickerView.tag = 102
                pickerView.selectRow(pickSelectedRowArray[2][0], inComponent: 0, animated: false)
            case (2,2):
                pickerLab.text = "学历要求"
                
                pickerView.tag = 103
                pickerView.selectRow(pickSelectedRowArray[3][0], inComponent: 0, animated: false)
            case (3,0):
                
                pickerLab.text = "工作城市"
                
                pickerView.tag = 104
                pickerView.selectRow(pickSelectedRowArray[4][0], inComponent: 0, animated: false)
                pickerView.selectRow(pickSelectedRowArray[4][1], inComponent: 1, animated: false)
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
            
            selectedNameArray[1][3] = "\(pickLowArray[pickerView.selectedRow(inComponent: 0)])至\(pickSupArray[pickerView.selectedRow(inComponent: 2)])"
            
            pickSelectedRowArray[0][0] = pickerView.selectedRow(inComponent: 0)
            pickSelectedRowArray[0][1] = pickerView.selectedRow(inComponent: 2)
        }else if pickerView.tag == 120 {
            
            selectedNameArray[2][0] = pickWorkPropertyArray[pickerView.selectedRow(inComponent: 0)]
            
            pickSelectedRowArray[1][0] = pickerView.selectedRow(inComponent: 0)
        }else if pickerView.tag == 102 {
            
            selectedNameArray[2][1] = pickExpRequiredArray[pickerView.selectedRow(inComponent: 0)]
            
            pickSelectedRowArray[2][0] = pickerView.selectedRow(inComponent: 0)
        }else if pickerView.tag == 103 {
            
            selectedNameArray[2][2] = pickEduRequiredArray[pickerView.selectedRow(inComponent: 0)]
            
            pickSelectedRowArray[3][0] = pickerView.selectedRow(inComponent: 0)
        }else if pickerView.tag == 104 {
            
            selectedNameArray[3][0] = "\(provinceArray[pickerView.selectedRow(inComponent: 0)])-\(cityArray[pickerView.selectedRow(inComponent: 1)])"
            
            ftPostPosition = selectedNameArray[3][0]

            pickSelectedRowArray[4][0] = pickerView.selectedRow(inComponent: 0)
            pickSelectedRowArray[4][1] = pickerView.selectedRow(inComponent: 1)
        }
        
        UserDefaults.standard.setValue(selectedNameArray, forKey: FTPublishJobSelectedNameArray_key)

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
            return 3
        }else if pickerView.tag == 120 {
            return 1
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
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            if component == 0 {
                return pickLowArray.count
            }else if component == 1 {
                return 1
            }else{
                return pickSupArray.count
            }
        }else if pickerView.tag == 120 {
            
            return pickWorkPropertyArray.count
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
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 101 {
            
            if component == 0 {
                pickSupArray = Array(pickLowArray[row ..< pickLowArray.count])
                
            }
        }else if pickerView.tag == 120 {
            
            
        }else if pickerView.tag == 102 {
            
            
        }else if pickerView.tag == 103 {
            
            
        }else if pickerView.tag == 104 {
            
            if component == 0 {
                cityArray = Array(areaDic[provinceArray[row]]!.keys).sorted(by: { (str1, str2) -> Bool in
                    return self.transform(chinese: str1) < self.transform(chinese: str2)
                })

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
            
            if component == 0 {
                view.text = pickLowArray[row]
            }else if component == 1 {
                view.text = "至"
            }else{
                view.text = pickSupArray[row]
            }
        }else if pickerView.tag == 120 {
            
            view.text = pickWorkPropertyArray[row]
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
