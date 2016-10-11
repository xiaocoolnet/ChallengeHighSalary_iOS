//
//  LoReCHSPersonalInfoViewController.swift
//  Challenge_high_salary
//
//  Created by zhang on 2016/10/10.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReCHSPersonalInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let rootTableView = UITableView()
    let headerImg = UIImageView()
    var selectedImage:UIImage?
    
    var currentCity = ""
    
    let nameArray = [["个人头像","真实姓名","性别","目前所在城市","工作年限"],["QQ","微信","微博"]]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setSubviews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(currentCityChanged(_:)), name: "currentCityChanged", object: nil)
    }
    
    func currentCityChanged(noti:NSNotification) {
        currentCity = noti.object as! String
        self.rootTableView.reloadData()
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
        }else{
            
            checkCodeHud.labelText = "正在上传头像"
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            let dateStr = dateFormatter.stringFromDate(NSDate())
            let imageName = "avatar" + dateStr + CHSUserInfo.currentUserInfo.userid + ".png"
            
            LoginNetUtil().uploadImage(imageName, image: selectedImage!) { (success, response) in
                if success {
                    
                    checkCodeHud.mode = .Text
                    checkCodeHud.labelText = "上传头像成功"
                    checkCodeHud.hide(true, afterDelay: 1)
                    
                    let time: NSTimeInterval = 1.0
                    let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                    
                    dispatch_after(delay, dispatch_get_main_queue()) {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
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
                headerImg.image = UIImage(named: "temp_default_headerImg")
                cell?.accessoryView = headerImg
            case 1:
                let nameLab = UILabel(frame: CGRectMake(0, 0, 80, 50))
                nameLab.text = "王小妞"
                nameLab.textAlignment = .Right
                cell?.accessoryView = nameLab
            case 2:
                let sexView = UIView(frame: CGRectMake(0, 0, 100, 50))
                
                let womanBtn = UIButton(frame: CGRectMake(0, 0, 50, 50))
                womanBtn.contentHorizontalAlignment = .Right
                womanBtn.setImage(UIImage(named: "ic_选择_nor"), forState: .Normal)
                womanBtn.setImage(UIImage(named: "ic_选择_sel"), forState: .Selected)
                womanBtn.setTitle("女", forState: .Normal)
                womanBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                sexView.addSubview(womanBtn)
                
                womanBtn.selected = true
                
                let manBtn = UIButton(frame: CGRectMake(50, 0, 50, 50))
                manBtn.contentHorizontalAlignment = .Right
                manBtn.setImage(UIImage(named: "ic_选择_nor"), forState: .Normal)
                manBtn.setImage(UIImage(named: "ic_选择_sel"), forState: .Selected)
                manBtn.setTitle("男", forState: .Normal)
                manBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
                sexView.addSubview(manBtn)
                
                cell?.accessoryView = sexView
            case 3:
                let cityLab = UILabel(frame: CGRectMake(0, 0, screenSize.width-200, 50))
                cityLab.text = currentCity
                cityLab.textAlignment = .Right
                cell?.accessoryView = cityLab
            case 4:
                let jobTimeLab = UILabel(frame: CGRectMake(0, 0, 50, 50))
                jobTimeLab.text = "1年"
                jobTimeLab.textAlignment = .Right
                cell?.accessoryView = jobTimeLab
            default:
                cell?.accessoryView = nil
            }
        case 1:
            switch indexPath.row {
            case 0:
                let QQTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
                QQTf.placeholder = "请输入QQ账号"
                QQTf.textAlignment = .Right
                cell?.accessoryView = QQTf
            case 1:
                let wechatTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
                wechatTf.placeholder = "请输入微信账号"
                wechatTf.textAlignment = .Right
                cell?.accessoryView = wechatTf
            case 2:
                let weiboTf = UITextField(frame: CGRectMake(0, 0, 150, 50))
                weiboTf.placeholder = "请输入微博账号"
                weiboTf.textAlignment = .Right
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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "账号关联"
        }else{
            return nil
        }
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
            
        case (0,3):
            
            self.presentViewController(UINavigationController(rootViewController: LoReCHSChooseCityViewController()), animated: true, completion: nil)
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
