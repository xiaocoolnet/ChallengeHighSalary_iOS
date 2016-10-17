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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CompanyInfoChanged(_:)), name: "PersonalChangeCompanyInfoNotification", object: nil)

    }
    
    func CompanyInfoChanged(noti:NSNotification) {
        let userInfo = noti.userInfo
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
                self.selectedImage = UIImage(data: NSData(contentsOfURL: NSURL(string: kImagePrefix+companyInfoModel.logo)!)!)
                self.orignalImage = self.selectedImage
                self.detailNameArray = ["",companyInfoModel.company_name,companyInfoModel.company_web,companyInfoModel.industry,companyInfoModel.count,companyInfoModel.financing]
                
            }else{
                
            }
        }
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
        
        self.title = "公司信息"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_提交"), style: .Done, target: self, action: #selector(clickSaveBtn))
        
        rootTableView.frame = CGRectMake(0, 64, screenSize.width, screenSize.height)
        rootTableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        rootTableView.rowHeight = 50
        rootTableView.dataSource = self
        rootTableView.delegate = self
        self.view.addSubview(rootTableView)
        
        rootTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // MARK: 点击保存按钮
    func clickSaveBtn() {
        
        let checkCodeHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        checkCodeHud.removeFromSuperViewOnHide = true
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr = dateFormatter.stringFromDate(NSDate())
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
                            
                            checkCodeHud.mode = .Text
                            checkCodeHud.labelText = "公司信息保存成功"
                            checkCodeHud.hide(true, afterDelay: 1)
                            
                            let time: NSTimeInterval = 1.0
                            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                            
                            dispatch_after(delay, dispatch_get_main_queue()) {
                                self.navigationController?.popViewControllerAnimated(true)
                            }
                        }else{
                            
                            checkCodeHud.mode = .Text
                            checkCodeHud.labelText = "公司信息保存失败"
                            checkCodeHud.hide(true, afterDelay: 1)
                        }
                }

            }else{
                
                checkCodeHud.mode = .Text
                checkCodeHud.labelText = "上传头像失败"
                checkCodeHud.hide(true, afterDelay: 1)
            }
        }
    }
    
    // MARK:- tableView dataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("companyInfoCell")
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: "companyInfoCell")
        }
        cell?.accessoryType = .DisclosureIndicator
        
        cell?.selectionStyle = .None
        cell?.textLabel?.font = UIFont.systemFontOfSize(16)
        cell?.textLabel?.textColor = UIColor.blackColor()
        cell?.textLabel?.textAlignment = .Left
        cell?.textLabel?.text = nameArray[indexPath.row]
        
        if indexPath.row == 0 {
            headerImg.frame = CGRectMake(0, 0, 40, 40)
            headerImg.layer.cornerRadius = 20
            headerImg.backgroundColor = UIColor.orangeColor()
            cell?.accessoryView = headerImg
        }else{
            cell?.accessoryView = nil
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            cell?.detailTextLabel?.textColor = UIColor(red: 167/255.0, green: 167/255.0, blue: 167/255.0, alpha: 1)
            cell?.detailTextLabel?.textAlignment = .Right
            cell?.detailTextLabel?.text = detailNameArray[indexPath.row]
        }
        
        return cell!
    }
    
    // MARK:- tableView delegate
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
            let infoInputVC = LoReFTInfoInputViewController()
            infoInputVC.infoType = .CompanyName
            infoInputVC.selfTitle = "公司全称"
            infoInputVC.placeHolder = "请输入公司全称"
            infoInputVC.tfText = ""
            infoInputVC.tipText = "公司全称是您所在公司的营业执照或劳动合同上的公司名称，请确保您填写完全匹配"
            infoInputVC.hudTipText = "请输入公司全称"
            infoInputVC.maxCount = 20
            
            self.navigationController?.pushViewController(infoInputVC, animated: true)
        case (0,2):
            
            let infoInputVC = LoReFTInfoInputViewController()
            infoInputVC.infoType = .CompanyNetUrl
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
            industryCategoriesVC.vcType = .CompanyInfo
            
            self.navigationController?.pushViewController(industryCategoriesVC, animated: true)
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
    
    // MARK: LoReFTInfoInputViewControllerDelegate
    func LoReFTInfoInputClickSaveBtn(infoType: InfoType, text: String) {
        if infoType == .CompanyName {
            detailNameArray[1] = text
        }else if infoType == .CompanyNetUrl {
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
            
            detailNameArray[4] = pickPersonalCountArray[pickerView.selectedRowInComponent(0)]
            
            pickSelectedRow[0][0] = pickerView.selectedRowInComponent(0)
        }else if pickerView.tag == 102 {
            
            detailNameArray[5] = pickPersonalCountArray[pickerView.selectedRowInComponent(0)]
            
            pickSelectedRow[1][0] = pickerView.selectedRowInComponent(0)
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
        }else if pickerView.tag == 102 {
            return 1
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101 {
            
            return pickPersonalCountArray.count
        }else if pickerView.tag == 102 {
            
            return pickFinancingArray.count
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
