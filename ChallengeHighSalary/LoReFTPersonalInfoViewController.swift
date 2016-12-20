//
//  LoReFTPersonalInfoViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/10.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReFTPersonalInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LoReFTInfoInputViewControllerDelegate {
    
    let rootTableView = TPKeyboardAvoidingTableView()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .compact)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadData()
        setSubviews()
    }
    
    // MARK: 加载数据
    func loadData() {
        
        selectedImage = CHSUserInfo.currentUserInfo.avatar == "" ? nil:UIImage(data: try! Data(contentsOf: URL(string: kImagePrefix+CHSUserInfo.currentUserInfo.avatar)!))
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        self.title = "企业信息"
        
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
        postPositionBtn.setTitle("保存", for: UIControlState())
        postPositionBtn.addTarget(self, action: #selector(clickSaveBtn), for: .touchUpInside)
        self.view.addSubview(postPositionBtn)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        if (selectedImage == nil) {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请先上传头像"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if nameText == nil {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入真实姓名"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if positionText == nil {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入职位名"
            checkCodeHud.hide(animated: true, afterDelay: 1)
            return
        }else if companyText == nil {
            
            checkCodeHud.mode = .text
            checkCodeHud.label.text = "请输入公司名"
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
                    
                    checkCodeHud.label.text = "正在保存个人信息"
                    
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
                                
                                checkCodeHud.mode = .text
                                checkCodeHud.label.text = "保存个人信息成功"
                                checkCodeHud.hide(animated: true, afterDelay: 1)
                                
                                let time: TimeInterval = 1.0
                                let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                                
                                DispatchQueue.main.asyncAfter(deadline: delay) {
                                    self.present(FTRoHomeViewController(), animated: true, completion: nil)
                                }
                            }else{
                                
                                checkCodeHud.mode = .text
                                checkCodeHud.label.text = "保存个人信息失败"
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
    
    // MARK: LoReFTInfoInputViewControllerDelegate
    func LoReFTInfoInputClickSaveBtn(_ infoType: InfoType, text: String) {
        switch infoType {
        case .name:
            nameText = text
        case .position:
            positionText = text
        case .email:
            emailText = text
        case .companyName:
            companyText = text
        default:
            break
        }
    }
    
    // MARK:- tableView dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "myInfoCell")
        }
        
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        switch (indexPath as NSIndexPath).section {
        case 0:
            switch (indexPath as NSIndexPath).row {
            case 0:
                headerImg.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
                headerImg.layer.cornerRadius = 25
                headerImg.clipsToBounds = true
                headerImg.image = selectedImage == nil ? UIImage(named: "temp_default_headerImg"):selectedImage
                cell?.accessoryView = headerImg
            case 1:
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
                cell?.detailTextLabel?.textAlignment = .right
                
                if (nameText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.black
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
            
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = "选填"
            cell?.accessoryView = nil
            
            switch (indexPath as NSIndexPath).row {
            case 0:
                if (positionText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.black
                    cell?.detailTextLabel?.text = positionText!
                }else{
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.text = "请输入我的职位"
                }
            case 1:
                if (emailText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.black
                    cell?.detailTextLabel?.text = emailText!
                }else{
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.text = "选填"
                }
            case 2:
                if (companyText != nil) {
                    cell?.detailTextLabel?.textColor = UIColor.black
                    cell?.detailTextLabel?.text = companyText!
                }else{
                    cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
                    cell?.detailTextLabel?.text = "请输入公司名称"
                }
            default:
                break
            }
        case 2:
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
        }else if section == 2 {
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
            sectionHeaderLab.text = "我的职业信息"
            sectionHeaderBgView.addSubview(sectionHeaderLab)
            
            return sectionHeaderBgView
        }else if section == 2 {
            
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
        case (0,1):
            
            let cell = tableView.cellForRow(at: indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .name
            vc.selfTitle = "姓名"
            vc.placeHolder = "请输入真实姓名"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.black ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = "请填写您的真实的姓名"
            vc.hudTipText = "请输入真实姓名"
            vc.maxCount = 4
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        case (1,0):
            
            let cell = tableView.cellForRow(at: indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .position
            vc.selfTitle = "我的职位"
            vc.placeHolder = "请输入职位名"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.black ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = "请填写您的现任职位，不能包含特殊符号"
            vc.hudTipText = "请输入职位名"
            vc.maxCount = 10
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        case (1,1):
            
            let cell = tableView.cellForRow(at: indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .email
            vc.selfTitle = "接受简历邮箱"
            vc.placeHolder = "请输入公司邮箱"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.black ? (cell?.detailTextLabel?.text)!:""
            vc.tipText = "请填写您的公司邮箱"
            vc.hudTipText = "请填写您的公司邮箱"
            vc.maxCount = 20
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        case (1,2):
            
            let cell = tableView.cellForRow(at: indexPath)
            
            let vc = LoReFTInfoInputViewController()
            vc.infoType = .companyName
            vc.selfTitle = "当前公司"
            vc.placeHolder = "请输入公司全称"
            vc.tfText = cell?.detailTextLabel?.textColor == UIColor.black ? (cell?.detailTextLabel?.text)!:""
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
