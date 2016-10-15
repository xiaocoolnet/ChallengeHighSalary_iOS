//
//  LoReCHSPersonalInfoViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/10.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReCHSPersonalInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let rootTableView = UITableView()
    let headerImg = UIImageView()
    var selectedImage:UIImage?
    
    let nameTf = UITextField()
    var nameText:String?
    
    let womanBtn = UIButton()
    let manBtn = UIButton()
    
    var currentCity = "请选择目前所在城市"
    
    var jobTime = "请选择工作年限"
    
    var pickerView = UIPickerView()
    
    var pickSelectedRow = 0
    
    let pickJobTimeRequiredArray = ["不限","应届生","1年以内","1-3年"]
    
    let QQTf = UITextField()
    var QQNumber:String?
    
    let wechatTf = UITextField()
    var wechatNumber:String?
    
    let weiboTf = UITextField()
    var weiboNumber:String?
    
    let nameArray = [["个人头像","真实姓名","性别","目前所在城市","工作年限"],["QQ","微信","微博"]]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadData()
        setSubviews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(currentCityChanged(_:)), name: "currentCityChanged", object: nil)
    }
    
    func currentCityChanged(noti:NSNotification) {
        currentCity = noti.object as! String
        self.rootTableView.reloadData()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        selectedImage = CHSUserInfo.currentUserInfo.avatar == "" ? nil:UIImage(data: NSData(contentsOfURL: NSURL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar)!)!)
        nameText = CHSUserInfo.currentUserInfo.realName == "" ? nil:CHSUserInfo.currentUserInfo.realName
        womanBtn.selected = CHSUserInfo.currentUserInfo.sex == "0" ? true:false
        currentCity = CHSUserInfo.currentUserInfo.city == "" ? "请选择目前所在城市":CHSUserInfo.currentUserInfo.city
        jobTime = CHSUserInfo.currentUserInfo.work_life == "" ? "请选择工作年限":CHSUserInfo.currentUserInfo.work_life
        QQNumber = CHSUserInfo.currentUserInfo.qqNumber == "" ? nil:CHSUserInfo.currentUserInfo.qqNumber
        wechatNumber = CHSUserInfo.currentUserInfo.weixinNumber == "" ? nil:CHSUserInfo.currentUserInfo.weixinNumber
        weiboNumber = CHSUserInfo.currentUserInfo.weiboNumber == "" ? nil:CHSUserInfo.currentUserInfo.weiboNumber
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
        
        self.title = "个人信息"
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height-64-44)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 60
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
        
        let postPositionBtn = UIButton(frame: CGRectMake(0, screenSize.height-44, screenSize.width, 44))
        postPositionBtn.backgroundColor = baseColor
        postPositionBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        postPositionBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        postPositionBtn.setTitle("创建微简历", forState: .Normal)
        postPositionBtn.addTarget(self, action: #selector(clickSaveBtn), forControlEvents: .TouchUpInside)
        self.view.addSubview(postPositionBtn)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if (selectedImage == nil) {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请先上传头像"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if nameTf.text!.isEmpty {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入真实姓名"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if currentCity == "请选择目前所在城市" {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请选择目前所在城市"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if jobTime == "请选择工作年限" {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请选择工作年限"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else{
            
            checkCodeHud.labelText = "正在上传头像"
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            let dateStr = dateFormatter.stringFromDate(NSDate())
            let imageName = "avatar" + dateStr + CHSUserInfo.currentUserInfo.userid + ".png"
            
            LoginNetUtil().uploadImage(imageName, image: selectedImage!) { (success, response) in
                if success {
                    
                    checkCodeHud.labelText = "正在创建微简历"
                    
                    LoginNetUtil().savepersonalinfo(
                        CHSUserInfo.currentUserInfo.userid,
                        avatar: imageName,
                        realname: self.nameTf.text!,
                        sex: self.womanBtn.selected ? "0":"1",
                        city: self.currentCity,
                        work_life: self.jobTime,
                        qq: self.QQTf.text!,
                        weixin: self.wechatTf.text!,
                        weibo: self.weiboTf.text!, handle: { (success, response) in
                            if success {
                                
                                checkCodeHud.mode = .Text
                                checkCodeHud.labelText = "创建微简历成功"
                                checkCodeHud.hide(true, afterDelay: 1)
                                
                                let time: NSTimeInterval = 1.0
                                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                                
                                dispatch_after(delay, dispatch_get_main_queue()) {
                                    self.navigationController?.pushViewController(LoReCHSEduExperienceViewController(), animated: true)
                                }
                            }else{
                                
                                checkCodeHud.mode = .Text
                                checkCodeHud.labelText = "创建微简历失败"
                                checkCodeHud.hide(true, afterDelay: 1)
                            }
                    })
                    
                }else{
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "上传头像失败"
                    checkCodeHud.hide(true, afterDelay: 1)
                }
            }
        }
        
    }
    
    // MARK:- tableView dataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("myInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "myInfoCell")
        }
        
        cell?.selectionStyle = .None
        cell?.accessoryType = .DetailDisclosureButton
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                headerImg.frame = CGRectMake(0, 0, 50, 50)
                headerImg.layer.cornerRadius = 25
                headerImg.clipsToBounds = true
                headerImg.image = selectedImage == nil ? UIImage(named: "temp_default_headerImg"):selectedImage
                cell?.accessoryView = headerImg
            case 1:
                nameTf.frame = CGRectMake(0, 0, screenSize.width*0.5, 50)
                nameTf.placeholder = "请输入真实姓名"
                nameTf.textAlignment = .Right
                nameTf.text = nameTf.text == "" ?  nameText:nameTf.text
                cell?.accessoryView = nameTf
            case 2:
                let sexView = UIView(frame: CGRectMake(0, 0, 100, 50))
                
                womanBtn.frame = CGRectMake(0, 0, 50, 50)
                womanBtn.contentHorizontalAlignment = .Right
                womanBtn.setImage(UIImage(named: "ic_选择_nor"), forState: .Normal)
                womanBtn.setImage(UIImage(named: "ic_选择_sel"), forState: .Selected)
                womanBtn.setTitle("女", forState: .Normal)
                womanBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                womanBtn.addTarget(self, action: #selector(sexBtnClick(_:)), forControlEvents: .TouchUpInside)
                sexView.addSubview(womanBtn)
                
                manBtn.frame = CGRectMake(50, 0, 50, 50)
                manBtn.contentHorizontalAlignment = .Right
                manBtn.setImage(UIImage(named: "ic_选择_nor"), forState: .Normal)
                manBtn.setImage(UIImage(named: "ic_选择_sel"), forState: .Selected)
                manBtn.setTitle("男", forState: .Normal)
                manBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                manBtn.addTarget(self, action: #selector(sexBtnClick(_:)), forControlEvents: .TouchUpInside)
                sexView.addSubview(manBtn)
                
                womanBtn.selected = womanBtn.selected ? true:false
                manBtn.selected = womanBtn.selected ? false:true
                
                cell?.accessoryView = sexView
            case 3:
                let cityLab = UILabel(frame: CGRectMake(0, 0, screenSize.width*0.5, 50))
                cityLab.text = currentCity
                if currentCity == "请选择目前所在城市" {
                    cityLab.textColor = UIColor.lightGrayColor()
                }else{
                    cityLab.textColor = UIColor.blackColor()
                }
                cityLab.textAlignment = .Right
                cell?.accessoryView = cityLab
            case 4:
                let jobTimeLab = UILabel(frame: CGRectMake(0, 0, screenSize.width*0.5, 50))
                jobTimeLab.text = jobTime
                if jobTime == "请选择工作年限" {
                    jobTimeLab.textColor = UIColor.lightGrayColor()
                }else{
                    jobTimeLab.textColor = UIColor.blackColor()
                }
                jobTimeLab.textAlignment = .Right
                cell?.accessoryView = jobTimeLab
            default:
                cell?.accessoryView = nil
            }
        case 1:
            switch indexPath.row {
            case 0:
                QQTf.frame = CGRectMake(0, 0, screenSize.width*0.5, 50)
                QQTf.placeholder = "请输入QQ账号"
                QQTf.textAlignment = .Right
                QQTf.text = QQTf.text == "" ?  QQNumber:QQTf.text
                cell?.accessoryView = QQTf
            case 1:
                wechatTf.frame = CGRectMake(0, 0, screenSize.width*0.5, 50)
                wechatTf.placeholder = "请输入微信账号"
                wechatTf.textAlignment = .Right
                wechatTf.text = wechatTf.text == "" ?  wechatNumber:wechatTf.text!
                cell?.accessoryView = wechatTf
            case 2:
                weiboTf.frame = CGRectMake(0, 0, screenSize.width*0.5, 50)
                weiboTf.placeholder = "请输入微博账号"
                weiboTf.textAlignment = .Right
                weiboTf.text = weiboTf.text == "" ? weiboNumber:weiboTf.text!
                cell?.accessoryView = weiboTf
            default:
                cell?.accessoryView = nil
            }
        default:
            cell?.accessoryView = nil
        }
        
        cell?.textLabel?.text = nameArray[indexPath.section][indexPath.row]
        
        return cell!
    }
    
    // MARK:- tableView delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 35
        }else{
            return 0.0001
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let sectionHeaderBgView = UIView(frame: CGRectMake(0, 0, screenSize.width, 35))
            
            let sectionHeaderLab = UILabel(frame: CGRectMake(20, 0, screenSize.width-40, 35))
            sectionHeaderLab.font = UIFont.systemFontOfSize(15)
            sectionHeaderLab.textColor = UIColor.lightGrayColor()
            sectionHeaderLab.text = "账号关联"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else{
            return nil
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.section,indexPath.row) {
        case (0,0):
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            let cameraAction = UIAlertAction(title: "拍照", style: .Default, handler: { (action) in
                
                if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.allowsEditing = true
                    picker.sourceType = .Camera
                    self.presentViewController(picker, animated: true, completion: nil)
                }else{
                    print("无法打开相机")
                }
            })
            alert.addAction(cameraAction)
            
            let photoLibraryAction = UIAlertAction(title: "从手机相册选择", style: .Default, handler: { (action) in
                
                let picker = UIImagePickerController()
                picker.sourceType = .PhotoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.presentViewController(picker, animated: true, completion: nil)
            })
            alert.addAction(photoLibraryAction)
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        case (0,3):
            
            self.presentViewController(UINavigationController(rootViewController: LoReCHSChooseCityViewController()), animated: true, completion: nil)
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
            
            pickerLab.text = "参加工作年份"
            
            pickerView.tag = 101
            pickerView.selectRow(pickSelectedRow, inComponent: 0, animated: false)
            
        default:
            break
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let type = info[UIImagePickerControllerMediaType] as! String
        if type != "public.image" {
            return
        }
        
        //裁剪后图片
        selectedImage = (info[UIImagePickerControllerEditedImage] as! UIImage)
        
        headerImg.image = selectedImage
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: 性别按钮点击事件
    func sexBtnClick(sexBtn:UIButton) {
        
        if sexBtn == womanBtn {
            womanBtn.selected = true
            manBtn.selected = false
        }else{
            womanBtn.selected = false
            manBtn.selected = true
        }
    }
    // MARK: pickerView 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: pickerView 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            jobTime = pickJobTimeRequiredArray[pickerView.selectedRowInComponent(0)]
            self.rootTableView.reloadData()
            
            pickSelectedRow = pickerView.selectedRowInComponent(0)
        }
        
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
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
           
            return pickJobTimeRequiredArray.count
        }else{
            return 0
        }
        
    }
    
    // MARK:- UIPickerView Delegate
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
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
            
            view.text = pickJobTimeRequiredArray[row]
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
