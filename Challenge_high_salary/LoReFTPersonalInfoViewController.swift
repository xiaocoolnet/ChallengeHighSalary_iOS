//
//  LoReFTPersonalInfoViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/10/10.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReFTPersonalInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LoReFTInfoInputViewControllerDelegate {
    
    let rootTableView = UITableView()
    let headerImg = UIImageView()
    var selectedImage:UIImage?
    
    let nameArray = [["个人头像","真实姓名"],["我的职位","接收简历邮箱","当前公司"],["QQ","微信","微博"]]
    
    var nameText:String? {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    var positionText:String? {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    var emailText:String? {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    var companyText:String? {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
    let QQTf = UITextField()
    var QQNumber:String?
    
    let wechatTf = UITextField()
    var wechatNumber:String?
    
    let weiboTf = UITextField()
    var weiboNumber:String?
    
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
    }
    
    // MARK: 加载数据
    func loadData() {
        
        selectedImage = CHSUserInfo.currentUserInfo.avatar == "" ? nil:UIImage(data: NSData(contentsOfURL: NSURL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar)!)!)
        nameText = CHSUserInfo.currentUserInfo.realName == "" ? nil:CHSUserInfo.currentUserInfo.realName
        positionText = CHSUserInfo.currentUserInfo.myjob == "" ? nil:CHSUserInfo.currentUserInfo.myjob
        emailText = CHSUserInfo.currentUserInfo.email == "" ? nil:CHSUserInfo.currentUserInfo.email
        companyText = CHSUserInfo.currentUserInfo.company == "" ? nil:CHSUserInfo.currentUserInfo.company
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
        postPositionBtn.setTitle("保存", forState: .Normal)
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
        }else if nameText == nil {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入真实姓名"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if positionText == nil {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入职位名"
            checkCodeHud.hide(true, afterDelay: 1)
            return
        }else if companyText == nil {
            
            checkCodeHud.mode = .Text
            checkCodeHud.labelText = "请输入公司名"
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
                    
                    checkCodeHud.labelText = "正在保存个人信息"
                    
                    LoginNetUtil().savecompanyinfo(
                        CHSUserInfo.currentUserInfo.userid,
                        avatar: imageName,
                        realname: self.nameText!,
                        myjob: self.positionText!,
                        email: self.emailText == nil ? "":self.emailText!,
                        company: self.companyText!,
                        qq: self.QQTf.text!,
                        weixin: self.wechatTf.text!,
                        weibo: self.weiboTf.text!,
                        handle: { (success, response) in
                            
                            if success {
                                
                                checkCodeHud.mode = .Text
                                checkCodeHud.labelText = "保存个人信息成功"
                                checkCodeHud.hide(true, afterDelay: 1)
                                
                                let time: NSTimeInterval = 1.0
                                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                                
                                dispatch_after(delay, dispatch_get_main_queue()) {
                                    self.presentViewController(FTRoHomeViewController(), animated: true, completion: nil)
                                }
                            }else{
                                
                                checkCodeHud.mode = .Text
                                checkCodeHud.labelText = "保存个人信息失败"
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
    
    // MARK: LoReFTInfoInputViewControllerDelegate
    func LoReFTInfoInputClickSaveBtn(infoType: InfoType, text: String) {
        switch infoType {
        case .Name:
            nameText = text
        case .Position:
            positionText = text
        case .Email:
            emailText = text
        case .CompanyName:
            companyText = text
        default:
            break
        }
    }
    
    // MARK:- tableView dataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("myInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "myInfoCell")
        }
        
        cell?.selectionStyle = .None
        cell?.accessoryType = .DisclosureIndicator
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
                cell?.detailTextLabel?.font = UIFont.systemFontOfSize(16)
                cell?.detailTextLabel?.textAlignment = .Right
                
                if (nameText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.blackColor()
                    cell?.detailTextLabel?.text = nameText!
                }else{
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.text = "请输入真实姓名"
                }
//                let nameTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
//                nameTf.placeholder = "请输入真实姓名"
//                nameTf.textAlignment = .Right
                cell?.accessoryView = nil
            default:
                cell?.accessoryView = nil
            }
        case 1:
            
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(16)
            cell?.detailTextLabel?.textAlignment = .Right
            cell?.detailTextLabel?.text = "选填"
            cell?.accessoryView = nil
            
            switch indexPath.row {
            case 0:
                if (positionText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.blackColor()
                    cell?.detailTextLabel?.text = positionText!
                }else{
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.text = "请输入我的职位"
                }
            case 1:
                if (emailText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.blackColor()
                    cell?.detailTextLabel?.text = emailText!
                }else{
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.text = "选填"
                }
            case 2:
                if (companyText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.blackColor()
                    cell?.detailTextLabel?.text = companyText!
                }else{
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.text = "请输入公司名称"
                }
            default:
                break
            }
        case 2:
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
        }else if section == 2 {
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
            sectionHeaderLab.text = "我的职业信息"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else if section == 2 {
            
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
        case (0,1):
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .Name
            vc.selfTitle = "姓名"
            vc.placeHolder = "请输入真实姓名"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.blackColor() ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = "请填写您的真实的姓名"
            vc.hudTipText = "请输入真实姓名"
            vc.maxCount = 4
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        case (1,0):
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .Position
            vc.selfTitle = "职位选择"
            vc.placeHolder = "请输入职位名"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.blackColor() ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = "请填写您的现任职位，不能包含特殊符号"
            vc.hudTipText = "请输入职位名"
            vc.maxCount = 10
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        case (1,1):
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .Email
            vc.selfTitle = "职位选择"
            vc.placeHolder = "请输入职位名"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.blackColor() ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = "请填写您的现任职位，不能包含特殊符号"
            vc.hudTipText = "请输入职位名"
            vc.maxCount = 20
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        case (1,2):
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .CompanyName
            vc.selfTitle = "当前公司"
            vc.placeHolder = "请输入公司全称"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.blackColor() ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = "公司全称是您所在公司的营业执照或劳动合同上的公司名称，请确保您的填写完全匹配"
            vc.hudTipText = "请输入公司全称"
            vc.maxCount = 50
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    // MARK: 上传图片
    func uploadImage() {
        
        
        
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
