//
//  CHSReProjectExperienceViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/19.
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


class CHSReProjectExperienceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, CHSReProjectDescriptionDelegate {
    
    let rootTableView = UITableView()
    
    let projectNameTf = UITextField()
    
    var pickerView = UIPickerView()

    var pickYearRequiredArray = ["1970年","1971年","1972年","1973年","1974年","1975年","1976年","1977年","1978年","1979年","1980年","1981年","1982年","1983年","1984年","1985年","1986年","1987年","1988年","1989年","1990年","1991年","1992年","1993年","1994年","1995年","1996年","1997年","1998年","1999年","2000年","2001年","2002年","2003年","2004年","2005年","2006年","2007年","2008年","2009年","2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年"]
    var pickMonthRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    
    var pickYearLowRequiredArray = ["1970年","1971年","1972年","1973年","1974年","1975年","1976年","1977年","1978年","1979年","1980年","1981年","1982年","1983年","1984年","1985年","1986年","1987年","1988年","1989年","1990年","1991年","1992年","1993年","1994年","1995年","1996年","1997年","1998年","1999年","2000年","2001年","2002年","2003年","2004年","2005年","2006年","2007年","2008年","2009年","2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年"]
    var pickMonthLowRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    var pickYearSupRequiredArray = ["1970年","1971年","1972年","1973年","1974年","1975年","1976年","1977年","1978年","1979年","1980年","1981年","1982年","1983年","1984年","1985年","1986年","1987年","1988年","1989年","1990年","1991年","1992年","1993年","1994年","1995年","1996年","1997年","1998年","1999年","2000年","2001年","2002年","2003年","2004年","2005年","2006年","2007年","2008年","2009年","2010年","2011年","2012年","2013年","2014年","2015年","2016年","2017年"]
    var pickMonthSupRequiredArray = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    
    var pickSelectedRowArray = [[0,0],[0,0]]
    
    let nameArray = ["项目名称","开始时间","结束时间","项目描述"]
    
    var detailArray = CHSUserInfo.currentUserInfo.project?.count > 0 ? [
        (CHSUserInfo.currentUserInfo.project?.first?.project_name)! == "" ? "":(CHSUserInfo.currentUserInfo.project?.first?.project_name)!,
        (CHSUserInfo.currentUserInfo.project?.first?.start_time)! == "" ? "请选择开始时间":(CHSUserInfo.currentUserInfo.project?.first?.start_time)!,
        (CHSUserInfo.currentUserInfo.project?.first?.end_time)! == "" ? "请选择结束时间":(CHSUserInfo.currentUserInfo.project?.first?.end_time)!,
        (CHSUserInfo.currentUserInfo.project?.first?.description_project)! == "" ? "请填写项目描述":"已填写"
        ]:["","请选择开始时间","请选择结束时间","请填写项目描述"] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    var project_description = CHSUserInfo.currentUserInfo.project?.count > 0 ? CHSUserInfo.currentUserInfo.project?.first?.description_project:"" {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        if ((CHSUserInfo.currentUserInfo.project?.first?.start_time) != nil) {
            
            for (i,year_low) in pickYearLowRequiredArray.enumerated() {
                if year_low == (CHSUserInfo.currentUserInfo.project?.first?.start_time)!.components(separatedBy: ".").first {
                    pickSelectedRowArray[0][0] = i
                }
            }
            for (i,month_low) in pickMonthLowRequiredArray.enumerated() {
                if month_low == (CHSUserInfo.currentUserInfo.project?.first?.start_time)!.components(separatedBy: ".").last {
                    pickSelectedRowArray[0][1] = i
                }
            }
        }
        
        if ((CHSUserInfo.currentUserInfo.project?.first?.end_time) != nil) {
            for (i,year_sup) in pickYearSupRequiredArray.enumerated() {
                if year_sup == (CHSUserInfo.currentUserInfo.project?.first?.end_time)!.components(separatedBy: ".").first {
                    pickSelectedRowArray[1][0] = i
                }
            }
            for (i,month_sup) in pickMonthSupRequiredArray.enumerated() {
                if month_sup == (CHSUserInfo.currentUserInfo.project?.first?.end_time)!.components(separatedBy: ".").last {
                    pickSelectedRowArray[1][1] = i
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
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))

        self.title = "项目经验"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if self.projectNameTf.text!.isEmpty {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入项目名称"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if detailArray[1] == "请选择开始时间" {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请选择开始时间"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if detailArray[2] == "请选择结束时间" {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请选择结束时间"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if detailArray[3] == "请填写项目描述" {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请填写项目描述"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else{
            
            if pickSelectedRowArray[0][0] > pickSelectedRowArray[1][0] {
                
                checkCodeHud.mode = .text
                checkCodeHud.label.text = "开始时间晚于结束时间"
                checkCodeHud.detailsLabel.text = "请重新选择起止时间"
                checkCodeHud.hide(animated: true, afterDelay: 1)
                return
            }else if pickSelectedRowArray[0][0] == pickSelectedRowArray[1][0]{
                
                if pickSelectedRowArray[0][1] > pickSelectedRowArray[1][1]{
                    checkCodeHud.mode = .text
                    checkCodeHud.label.text = "开始时间晚于结束时间"
                    checkCodeHud.detailsLabel.text = "请重新选择起止时间"
                    checkCodeHud.hide(animated: true, afterDelay: 1)
                    return
                }
            }
        }
        
        if CHSUserInfo.currentUserInfo.project?.first?.project_name ==  self.projectNameTf.text! && CHSUserInfo.currentUserInfo.project?.first?.start_time ==  self.detailArray[1] && CHSUserInfo.currentUserInfo.project?.first?.end_time ==  self.detailArray[2] && CHSUserInfo.currentUserInfo.project?.first?.description_project ==  self.project_description {
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
        
        checkCodeHud.label.text = "正在保存项目经验"
        
        CHSNetUtil().PublishProject(
            CHSUserInfo.currentUserInfo.userid,
            project_name: self.projectNameTf.text!,
            start_time: detailArray[1],
            end_time: detailArray[2],
            description_project: self.project_description!,
            handle: { (success, response) in
                if success {
                    
//                    self.detailArray = [
//                        (CHSUserInfo.currentUserInfo.project?.first?.project_name)! == "" ? "输入项目名称":(CHSUserInfo.currentUserInfo.project?.first?.project_name)!,
//                        (CHSUserInfo.currentUserInfo.project?.first?.start_time)! == "" ? "请选择开始时间":(CHSUserInfo.currentUserInfo.project?.first?.start_time)!,
//                        (CHSUserInfo.currentUserInfo.project?.first?.end_time)! == "" ? "请选择结束时间":(CHSUserInfo.currentUserInfo.project?.first?.end_time)!,
//                        (CHSUserInfo.currentUserInfo.project?.first?.project_description)! == "" ? "请填写项目描述":"已填写"
//                    ]
                    self.detailArray = [self.projectNameTf.text!,self.detailArray[1],self.detailArray[2],"已填写"]
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.label.text = "保存项目经验成功"
                    checkCodeHud.hide(animated: true, afterDelay: 1)
                    
                    let time: TimeInterval = 1.0
                    let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.label.text = "保存工作经历失败"
                    checkCodeHud.hide(animated: true, afterDelay: 1)
                }

        })

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
        
        if (indexPath as NSIndexPath).row == 0 {
            
            projectNameTf.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
            projectNameTf.font = UIFont.systemFont(ofSize: 14)
            projectNameTf.placeholder = "输入项目名称"
            projectNameTf.textAlignment = .right
            projectNameTf.text = projectNameTf.text == "" ? detailArray[0]:projectNameTf.text
            cell?.accessoryView = projectNameTf
        }else{
            
            
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = detailArray[(indexPath as NSIndexPath).row]
        }
        
        return cell!
    }
    
    // MARK:- tableView delegate
    var othersDrop = DropDown()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.projectNameTf.resignFirstResponder()
        
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,3):
            
            let projectDescriptionVC = CHSReProjectDescriptionViewController()
            projectDescriptionVC.delegate = self
            projectDescriptionVC.project_description = self.project_description!
            self.navigationController?.pushViewController(projectDescriptionVC, animated: true)
            break
        case (0,0):
            break
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
            
            detailArray[1] = "\(pickYearLowRequiredArray[pickerView.selectedRow(inComponent: 0)]).\(pickMonthLowRequiredArray[pickerView.selectedRow(inComponent: 1)])"
            
            pickSelectedRowArray[0][0] = pickerView.selectedRow(inComponent: 0)
            pickSelectedRowArray[0][1] = pickerView.selectedRow(inComponent: 1)
        }else if pickerView.tag == 102 {
            
            detailArray[2] = "\(pickYearSupRequiredArray[pickerView.selectedRow(inComponent: 0)]).\(pickMonthSupRequiredArray[pickerView.selectedRow(inComponent: 1)])"
            
            pickSelectedRowArray[1][0] = pickerView.selectedRow(inComponent: 0)
            pickSelectedRowArray[1][1] = pickerView.selectedRow(inComponent: 1)
        }
        
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
            return 2
        }else if pickerView.tag == 102 {
            return 2
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
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        if pickerView.tag == 101 {
//            
//
//        }else if pickerView.tag == 102 {
//       
//        }
        
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
    
    
    // MARK: 项目描述 代理
    func CHSReProjectDescriptionClickSaveBtn(_ content: String) {
        self.project_description = content
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
