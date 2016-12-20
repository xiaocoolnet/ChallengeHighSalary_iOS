//
//  CHSReEditPersonalInfoViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/13.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class CHSReEditPersonalInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let rootTableView = UITableView()
    let headerImg = UIImageView()
    var selectedImage:UIImage?
    var orignalImage:UIImage?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadData()
        setSubviews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(currentCityChanged(_:)), name: NSNotification.Name(rawValue: "currentCityChanged"), object: nil)
    }
    
    func currentCityChanged(_ noti:Notification) {
        currentCity = noti.object as! String
        self.rootTableView.reloadData()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        selectedImage = UIImage(data: try! Data(contentsOf: URL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar)!))
        orignalImage = selectedImage
        nameText = CHSUserInfo.currentUserInfo.realName
        womanBtn.isSelected = CHSUserInfo.currentUserInfo.sex == "0" ? true:false
        currentCity = CHSUserInfo.currentUserInfo.city
        jobTime = CHSUserInfo.currentUserInfo.work_life
        QQNumber = CHSUserInfo.currentUserInfo.qqNumber == "" ? nil:CHSUserInfo.currentUserInfo.qqNumber
        wechatNumber = CHSUserInfo.currentUserInfo.weixinNumber == "" ? nil:CHSUserInfo.currentUserInfo.weixinNumber
        weiboNumber = CHSUserInfo.currentUserInfo.weiboNumber == "" ? nil:CHSUserInfo.currentUserInfo.weiboNumber
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
        
        self.title = "个人信息"
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
        
        if
        selectedImage ==  orignalImage &&
        nameTf.text == CHSUserInfo.currentUserInfo.realName &&
        womanBtn.isSelected == (CHSUserInfo.currentUserInfo.sex == "0" ? true:false) &&
        currentCity == CHSUserInfo.currentUserInfo.city &&
        jobTime == CHSUserInfo.currentUserInfo.work_life &&
        QQTf.text == CHSUserInfo.currentUserInfo.qqNumber &&
        wechatTf.text == CHSUserInfo.currentUserInfo.weixinNumber &&
        weiboTf.text == CHSUserInfo.currentUserInfo.weiboNumber{
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "信息未修改"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            
            let time: TimeInterval = 1.0
            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: delay) {
                _ = self.navigationController?.popViewController(animated: true)
//                self.present(CHRoHomeViewController(), animated: true, completion: nil)
            }
            
            return
        }
        
        
        if (selectedImage == nil) {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请先上传头像"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if nameTf.text!.isEmpty {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入真实姓名"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if currentCity == "请选择目前所在城市" {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请选择目前所在城市"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if jobTime == "请选择工作年限" {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请选择工作年限"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else{
            
            checkCodeHud.label.text = "正在上传头像"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            let dateStr = dateFormatter.string(from: Date())
            let imageName = "avatar" + dateStr + CHSUserInfo.currentUserInfo.userid + ".png"
            
            LoginNetUtil().uploadImage(imageName, image: selectedImage!) { (success, response) in
                if success {
                    
                    checkCodeHud.label.text = "正在创建微简历"
                    
                    LoginNetUtil().savepersonalinfo(
                        CHSUserInfo.currentUserInfo.userid,
                        avatar: imageName,
                        realname: self.nameTf.text!,
                        sex: self.womanBtn.isSelected ? "0":"1",
                        city: self.currentCity,
                        work_life: self.jobTime,
                        qq: self.QQTf.text!,
                        weixin: self.wechatTf.text!,
                        weibo: self.weiboTf.text!, handle: { (success, response) in
                            if success {
                                
                                checkCodeHud.mode = .text
                                checkCodeHud.label.text = "个人信息保存成功"
                                checkCodeHud.hide(animated: true, afterDelay: 1)
                                
                                let time: TimeInterval = 1.0
                                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                                
                                DispatchQueue.main.asyncAfter(deadline: delay) {
                                    _ = self.navigationController?.popViewController(animated: true)

//                                    self.present(CHRoHomeViewController(), animated: true, completion: nil)
                                }
                            }else{
                                
                                checkCodeHud.mode = .text
                                checkCodeHud.label.text = "个人信息保存失败"
                                checkCodeHud.hide(animated: true, afterDelay: 1)
                            }
                    })
                    
                }else{
                    
                    checkCodeHud.mode = .text
                    checkCodeHud.label.text = "上传头像失败"
                    checkCodeHud.hide(animated: true, afterDelay: 1)
                }
            }
        }
        
    }
    
    // MARK:- tableView dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "myInfoCell")
        }
        
        cell?.selectionStyle = .none
        cell?.accessoryType = .detailDisclosureButton
        switch (indexPath as NSIndexPath).section {
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                headerImg.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                headerImg.layer.cornerRadius = 25
                headerImg.clipsToBounds = true
                
                headerImg.sd_setImage(with: URL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar)!, placeholderImage: #imageLiteral(resourceName: "ic_默认头像"))

//                headerImg.image = selectedImage == nil ? UIImage(named: "temp_default_headerImg"):selectedImage
                cell?.accessoryView = headerImg
            case 1:
                nameTf.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.5, height: 50)
                nameTf.placeholder = "请输入真实姓名"
                nameTf.textAlignment = .right
                nameTf.text = nameTf.text == "" ?  nameText:nameTf.text
                cell?.accessoryView = nameTf
            case 2:
                let sexView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
                
                womanBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                womanBtn.contentHorizontalAlignment = .right
                womanBtn.setImage(UIImage(named: "ic_选择_nor"), for: UIControlState())
                womanBtn.setImage(UIImage(named: "ic_选择_sel"), for: .selected)
                womanBtn.setTitle("女", for: UIControlState())
                womanBtn.setTitleColor(UIColor.lightGray, for: UIControlState())
                womanBtn.addTarget(self, action: #selector(sexBtnClick(_:)), for: .touchUpInside)
                sexView.addSubview(womanBtn)
                
                manBtn.frame = CGRect(x: 50, y: 0, width: 50, height: 50)
                manBtn.contentHorizontalAlignment = .right
                manBtn.setImage(UIImage(named: "ic_选择_nor"), for: UIControlState())
                manBtn.setImage(UIImage(named: "ic_选择_sel"), for: .selected)
                manBtn.setTitle("男", for: UIControlState())
                manBtn.setTitleColor(UIColor.lightGray, for: UIControlState())
                manBtn.addTarget(self, action: #selector(sexBtnClick(_:)), for: .touchUpInside)
                sexView.addSubview(manBtn)
                
                womanBtn.isSelected = womanBtn.isSelected ? true:false
                manBtn.isSelected = womanBtn.isSelected ? false:true
                
                cell?.accessoryView = sexView
            case 3:
                let cityLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width*0.5, height: 50))
                cityLab.text = currentCity
                if currentCity == "请选择目前所在城市" {
                    cityLab.textColor = UIColor.lightGray
                }else{
                    cityLab.textColor = UIColor.black
                }
                cityLab.textAlignment = .right
                cell?.accessoryView = cityLab
            case 4:
                let jobTimeLab = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width*0.5, height: 50))
                jobTimeLab.text = jobTime
                if jobTime == "请选择工作年限" {
                    jobTimeLab.textColor = UIColor.lightGray
                }else{
                    jobTimeLab.textColor = UIColor.black
                }
                jobTimeLab.textAlignment = .right
                cell?.accessoryView = jobTimeLab
            default:
                cell?.accessoryView = nil
            }
        case 1:
            switch (indexPath as NSIndexPath).row {
            case 0:
                QQTf.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.5, height: 50)
                QQTf.placeholder = "请输入QQ账号"
                QQTf.textAlignment = .right
                QQTf.text = QQTf.text == "" ?  QQNumber:QQTf.text
                cell?.accessoryView = QQTf
            case 1:
                wechatTf.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.5, height: 50)
                wechatTf.placeholder = "请输入微信账号"
                wechatTf.textAlignment = .right
                wechatTf.text = wechatTf.text == "" ?  wechatNumber:wechatTf.text!
                cell?.accessoryView = wechatTf
            case 2:
                weiboTf.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.5, height: 50)
                weiboTf.placeholder = "请输入微博账号"
                weiboTf.textAlignment = .right
                weiboTf.text = weiboTf.text == "" ? weiboNumber:weiboTf.text!
                cell?.accessoryView = weiboTf
            default:
                cell?.accessoryView = nil
            }
        default:
            cell?.accessoryView = nil
        }
        
        cell?.textLabel?.text = nameArray[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        
        return cell!
    }
    
    // MARK:- tableView delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 35
        }else{
            return 0.0001
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let sectionHeaderBgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 35))
            
            let sectionHeaderLab = UILabel(frame: CGRect(x: 20, y: 0, width: screenSize.width-40, height: 35))
            sectionHeaderLab.font = UIFont.systemFont(ofSize: 15)
            sectionHeaderLab.textColor = UIColor.lightGray
            sectionHeaderLab.text = "账号关联"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ((indexPath as NSIndexPath).section,(indexPath as NSIndexPath).row) {
        case (0,0):
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "拍照", style: .default, handler: { (action) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.allowsEditing = true
                    picker.sourceType = .camera
                    self.present(picker, animated: true, completion: nil)
                }else{
                    print("无法打开相机")
                }
            })
            alert.addAction(cameraAction)
            
            let photoLibraryAction = UIAlertAction(title: "从手机相册选择", style: .default, handler: { (action) in
                
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            })
            alert.addAction(photoLibraryAction)
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
            
        case (0,3):
            
            self.present(UINavigationController(rootViewController: LoReCHSChooseCityViewController()), animated: true, completion: nil)
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
            
            pickerLab.text = "参加工作年份"
            
            pickerView.tag = 101
            pickerView.selectRow(pickSelectedRow, inComponent: 0, animated: false)
            
        default:
            break
        }
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type = info[UIImagePickerControllerMediaType] as! String
        if type != "public.image" {
            return
        }
        
        //裁剪后图片
        selectedImage = (info[UIImagePickerControllerEditedImage] as! UIImage)
        
        headerImg.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 性别按钮点击事件
    func sexBtnClick(_ sexBtn:UIButton) {
        
        if sexBtn == womanBtn {
            womanBtn.isSelected = true
            manBtn.isSelected = false
        }else{
            womanBtn.isSelected = false
            manBtn.isSelected = true
        }
    }
    // MARK: pickerView 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: pickerView 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            jobTime = pickJobTimeRequiredArray[pickerView.selectedRow(inComponent: 0)]
            self.rootTableView.reloadData()
            
            pickSelectedRow = pickerView.selectedRow(inComponent: 0)
        }
        
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
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            return pickJobTimeRequiredArray.count
        }else{
            return 0
        }
        
    }
    
    // MARK:- UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
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
