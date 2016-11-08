//
//  FTMiMyCompanyInfoViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/17.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class FTMiMyCompanyInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate,UIPickerViewDataSource, LoReFTInfoInputViewControllerDelegate {
    
    let rootTableView = UITableView()
    
    let headerImg = UIImageView()
    var selectedImage:UIImage?
    var orignalImage:UIImage?
    
    var pickerView = UIPickerView()
    
    var pickSelectedRow = [[0],[0]]
    
    let pickPersonalCountArray = ["不限","1人","2人","3人"]
    
    let pickFinancingArray = ["未融资","A阶段","B阶段"]

    var jobTime = "请选择工作年限"
    
    let nameArray = ["公司logo","公司全称","公司官网","所属行业","人员规模","融资阶段"]
    var detailNameArray = ["","","","","",""] {
        didSet {
            self.rootTableView.reloadData()
        }
    }
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(CompanyInfoChanged(_:)), name: NSNotification.Name(rawValue: "PersonalChangeCompanyInfoNotification"), object: nil)

    }
    
    func CompanyInfoChanged(_ noti:Notification) {
        let userInfo = (noti as NSNotification).userInfo
        if (userInfo != nil) {
            if userInfo!["type"] as! String == "Categories" {
                detailNameArray[3] = userInfo!["value"] as! String
            }
        }
    }
    
    // MARK: 加载数据
    func loadData() {
        
        FTNetUtil().getMyCompany_info(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            if success {
                let companyInfoModel = response as! Company_infoDataModel
                self.selectedImage = UIImage(data: try! Data(contentsOf: URL(string: kImagePrefix+companyInfoModel.logo)!))
                self.orignalImage = self.selectedImage
                self.detailNameArray = ["",companyInfoModel.company_name,companyInfoModel.company_web,companyInfoModel.industry,companyInfoModel.count,companyInfoModel.financing]
                
            }else{
                
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
        
        self.title = "公司信息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRect(x: 0, y: 64, width: screenSize.width, height: screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showAdded(to: self.view, animated: true)!
        checkCodeHud.removeFromSuperViewOnHide = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr = dateFormatter.string(from: Date())
        let imageName = "avatar" + dateStr + CHSUserInfo.currentUserInfo.userid + ".png"
        
        checkCodeHud.labelText = "正在上传公司logo"
        
        LoginNetUtil().uploadImage(imageName, image: selectedImage!) { (success, response) in
            if success {
                
                checkCodeHud.labelText = "正在上传公司信息"
                
                FTNetUtil().company_info(
                    CHSUserInfo.currentUserInfo.userid,
                    logo: imageName,
                    company_name: self.detailNameArray[1],
                    company_web: self.detailNameArray[2],
                    industry: self.detailNameArray[3],
                    count: self.detailNameArray[4],
                    financing: self.detailNameArray[5]) { (success, response) in
                        if success {
                            
                            checkCodeHud.mode = .text
                            checkCodeHud.labelText = "公司信息保存成功"
                            checkCodeHud.hide(true, afterDelay: 1)
                            
                            let time: TimeInterval = 1.0
                            let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                            
                            DispatchQueue.main.asyncAfter(deadline: delay) {
                                _ = self.navigationController?.popViewController(animated: true)
                            }
                        }else{
                            
                            checkCodeHud.mode = .text
                            checkCodeHud.labelText = "公司信息保存失败"
                            checkCodeHud.hide(true, afterDelay: 1)
                        }
                }

            }else{
                
                checkCodeHud.mode = .text
                checkCodeHud.labelText = "上传头像失败"
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
    }
    
    // MARK:- tableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "companyInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "companyInfoCell")
        }
        cell?.accessoryType = .disclosureIndicator
        
        cell?.selectionStyle = .none
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.textAlignment = .left
        cell?.textLabel?.text = nameArray[(indexPath as NSIndexPath).row]
        
        if (indexPath as NSIndexPath).row == 0 {
            headerImg.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            headerImg.layer.cornerRadius = 20
            headerImg.backgroundColor = UIColor.orange
            cell?.accessoryView = headerImg
        }else{
            cell?.accessoryView = nil
            cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .right
            cell?.detailTextLabel?.text = detailNameArray[(indexPath as NSIndexPath).row]
        }
        
        return cell!
    }
    
    // MARK:- tableView delegate
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
            let infoInputVC = LoReFTInfoInputViewController()
            infoInputVC.infoType = .companyName
            infoInputVC.selfTitle = "公司全称"
            infoInputVC.placeHolder = "请输入公司全称"
            infoInputVC.tfText = ""
            infoInputVC.tipText = "公司全称是您所在公司的营业执照或劳动合同上的公司名称，请确保您填写完全匹配"
            infoInputVC.hudTipText = "请输入公司全称"
            infoInputVC.maxCount = 20
            
            self.navigationController?.pushViewController(infoInputVC, animated: true)
        case (0,2):
            
            let infoInputVC = LoReFTInfoInputViewController()
            infoInputVC.infoType = .companyNetUrl
            infoInputVC.selfTitle = "公司官网"
            infoInputVC.placeHolder = "请输入公司官网网址"
            infoInputVC.tfText = ""
            infoInputVC.tipText = "请正确输入你所在公司的官网！"
            infoInputVC.hudTipText = "请输入公司官网网址"
            infoInputVC.maxCount = 50
            infoInputVC.delegate = self
            
            self.navigationController?.pushViewController(infoInputVC, animated: true)
        case (0,3):
            
            let industryCategoriesVC = CHSReChooseIndustryCategoriesViewController()
            industryCategoriesVC.navTitle = "公司行业选择"
            industryCategoriesVC.vcType = .companyInfo
            
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
            case (0,4):
                pickerLab.text = "人员规模"
                
                pickerView.tag = 101
                pickerView.selectRow(pickSelectedRow[0][0], inComponent: 0, animated: false)
            case (0,5):
                pickerLab.text = "融资阶段"
                
                pickerView.tag = 102
                pickerView.selectRow(pickSelectedRow[1][0], inComponent: 0, animated: false)
            default:
                break
            }
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
    
    // MARK: LoReFTInfoInputViewControllerDelegate
    func LoReFTInfoInputClickSaveBtn(_ infoType: InfoType, text: String) {
        if infoType == .companyName {
            detailNameArray[1] = text
        }else if infoType == .companyNetUrl {
            detailNameArray[2] = text
        }
    }

    // MARK: pickerView 取消按钮点击事件
    func pickerCancelClick() {
        self.view.viewWithTag(1000)?.removeFromSuperview()
    }
    
    // MARK: pickerView 确定按钮点击事件
    func sureBtnClick() {
        
        if pickerView.tag == 101 {
            
            detailNameArray[4] = pickPersonalCountArray[pickerView.selectedRow(inComponent: 0)]
            
            pickSelectedRow[0][0] = pickerView.selectedRow(inComponent: 0)
        }else if pickerView.tag == 102 {
            
            detailNameArray[5] = pickPersonalCountArray[pickerView.selectedRow(inComponent: 0)]
            
            pickSelectedRow[1][0] = pickerView.selectedRow(inComponent: 0)
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
        }else if pickerView.tag == 102 {
            return 1
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            return pickPersonalCountArray.count
        }else if pickerView.tag == 102 {
            
            return pickFinancingArray.count
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
            
            view.text = pickPersonalCountArray[row]
        }else if pickerView.tag == 102 {
            
            view.text = pickFinancingArray[row]
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
