//
//  ChChHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChHomeViewController: UIViewController, LFLUISegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate, AMapLocationManagerDelegate {
    
    let cityBtn = ImageBtn()
    
    let rootScrollView = UIScrollView()
    
    var jobList = [JobInfoDataModel]()
    
    var companyList = [Company_infoDataModel]()
    
    var salaryDrop = DropDown()
    var redEnvelopeDrop = DropDown()
    let findJobTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .grouped)
    
    var scaleDrop = DropDown()
    var nearbyDrop = DropDown()
    let findEmployerTableView = UITableView(frame: CGRect(x: screenSize.width, y: 0, width: screenSize.width, height: screenSize.height-20-44-49-37), style: .plain)
    
    var locationManager = AMapLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO:
        UserDefaults.standard.removeObject(forKey: myCity_key)

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        setNavigationBar()
        setSubviews()
        loadData()
        
    }
    
    var hud = MBProgressHUD()
    var hudShowFlag = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false

        // 自定义下拉列表样式
        customizeDropDown()
        
        if UserDefaults.standard.string(forKey: myCity_key) == nil {
            
//            if hudShowFlag {
//
//            }
            hud.hide(false)
            
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.labelText = "正在获取当前位置"
            hud.removeFromSuperViewOnHide = true
            
            self.loadLocation()
//            self.navigationController?.pushViewController(ChChCityViewController(), animated: true)
        }else{
            
            myCity = UserDefaults.standard.string(forKey: myCity_key)!
            
            cityBtn.resetdata(myCity, #imageLiteral(resourceName: "城市下拉箭头"))

//            cityBtn.setTitle(myCity, for: UIControlState())
//            adjustBtnsTitleLabelAndImgaeView(cityBtn)
        }

    }
    
    // MARK: 加载数据
    func loadData() {
        CHSNetUtil().getjoblist(CHSUserInfo.currentUserInfo.userid) { (success, response) in
            if success {
                self.jobList = (response as! [JobInfoDataModel]?)!
                self.findJobTableView.reloadData()
            }else{
                
            }
        }
        
        CHSNetUtil().getCompanyList { (success, response) in
            if success {
                self.companyList = (response as! [Company_infoDataModel]?)!
                self.findEmployerTableView.reloadData()
            }else{
                
            }
        }
        
//        PublicNetUtil().getDictionaryList(parentid: "5") { (success, reponse) in
//            <#code#>
//        }
//        
//        PublicNetUtil().getDictionaryList(parentid: "5") { (success, reponse) in
//            <#code#>
//        }
        
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        // 城市按钮
        cityBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        cityBtn.resetdata(myCity, #imageLiteral(resourceName: "城市下拉箭头"))
        cityBtn.lb_titleColor = UIColor.white
//        cityBtn.contentHorizontalAlignment = .left
//        cityBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        cityBtn.setTitle(myCity, for: UIControlState())
//        cityBtn.setImage(UIImage(named: "城市下拉箭头"), for: UIControlState())
//        exchangeBtnImageAndTitle(cityBtn, margin: 5)
//        adjustBtnsTitleLabelAndImgaeView(cityBtn)
        cityBtn.addTarget(self, action: #selector(cityBtnClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityBtn)
        
        // rightBarButtonItems
        let retrievalBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        retrievalBtn.setImage(UIImage(named: "ic_筛选"), for: UIControlState())
        retrievalBtn.addTarget(self, action: #selector(retrievalBtnClick), for: .touchUpInside)
        let retrievalItem = UIBarButtonItem(customView: retrievalBtn)
        
        let searchBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        searchBtn.setImage(UIImage(named: "ic_搜索"), for: UIControlState())
        searchBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        let searchItem = UIBarButtonItem(customView: searchBtn)

        self.navigationItem.rightBarButtonItems = [searchItem,retrievalItem]
        
        
        // Init views with rects with height and y pos
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        
        // Use autoresizing to restrict the bounds to the area that the titleview allows
        titleView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue|UIViewAutoresizing.flexibleLeftMargin.rawValue|UIViewAutoresizing.flexibleRightMargin.rawValue)
        
        titleView.autoresizesSubviews = true
        
        
        let seg = UISegmentedControl(items: ["找工作","找雇主"])
        seg.frame = CGRect(x: 0, y: 10, width: 120, height: 24)
        seg.addTarget(self, action: #selector(self.segValueChanged(_:)), for: .valueChanged)
        seg.selectedSegmentIndex = 0
        
        seg.autoresizingMask = titleView.autoresizingMask
        
        
        
        let leftViewbounds = self.navigationItem.leftBarButtonItem?.customView?.bounds
        
        let rightViewbounds = self.navigationItem.rightBarButtonItem?.customView?.bounds
        
        var maxWidth = (leftViewbounds?.size.width)! > (rightViewbounds?.size.width)! ? (leftViewbounds?.size.width)! : (rightViewbounds?.size.width)!
        
        maxWidth += 15//leftview 左右都有间隙，左边是5像素，右边是8像素，加2个像素的阀值 5 ＋ 8 ＋ 2
        
        var frame = seg.frame
        
        frame.size.width = min(screenSize.width - maxWidth * 2, seg.frame.width)
        
        seg.frame = frame
        
        frame = titleView.frame
        
        frame.size.width = min(screenSize.width - maxWidth * 2, seg.frame.width)
        
        titleView.frame = frame
        
        // Add as the nav bar's titleview
        
        titleView.addSubview(seg)
        
        self.navigationItem.titleView = titleView
    }
    
    // MARK: 城市按钮点击事件
    func cityBtnClick() {
        self.navigationController?.pushViewController(ChChCityViewController(), animated: true)

//        self.navigationController?.pushViewController(SingleLocationAloneViewController(), animated: true)

    }
    
    // MARK: 检索按钮点击事件
    func retrievalBtnClick() {
        print("ChChHomeViewController searchBtnClick")
        
        let retrievalController = CHSChRetrievalViewController()
        retrievalController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(retrievalController, animated: true)
    }
    
    // MARK: 搜索按钮点击事件
    func searchBtnClick() {
        print("ChChHomeViewController searchBtnClick")
        
        let searchController = ChChSearchViewController()
        searchController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchController, animated: true)
    }
    
    // MARK: seg 点击事件
    func segValueChanged(_ seg:UISegmentedControl) {
        print(seg.selectedSegmentIndex)
        
        self.rootScrollView.contentOffset = CGPoint(x: CGFloat(seg.selectedSegmentIndex)*screenSize.width, y: 0)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        rootScrollView.frame = CGRect(x: 0, y: 64,width: screenSize.width ,height: screenSize.height-49-64)
        rootScrollView.contentSize = CGSize(width: screenSize.width*2, height: screenSize.height-49-64)
        rootScrollView.isScrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        setSubviews_findJob()
        setSubviews_findEmployer()
    }
    
    // MARK: 设置子视图_找工作
    func setSubviews_findJob() {
        
        
        // 薪资
        let salaryBtn = ImageBtn(frame: CGRect(x: 0, y: 0, width: (screenSize.width)/6, height: 37))
        salaryBtn?.resetdataCenter("薪资", #imageLiteral(resourceName: "ic_下拉"))
//        let salaryBtn = UIButton()
//        salaryBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        salaryBtn.setTitle("薪资", for: UIControlState())
//        salaryBtn.setImage(UIImage(named: "ic_下拉"), for: UIControlState())
//        exchangeBtnImageAndTitle(salaryBtn, margin: 5)
        
        // 薪资 下拉
        salaryDrop.anchorView = salaryBtn
        
        salaryDrop.bottomOffset = CGPoint(x: 0, y: 37)
        salaryDrop.width = screenSize.width
        salaryDrop.direction = .bottom
        
        salaryDrop.dataSource = ["不限","1万以下","1~2万","2~3万","3~4万","4~5万","5万以上"]
        
        // 下拉列表选中后的回调方法
        salaryDrop.selectionAction = { (index, item) in
            salaryBtn?.resetdataCenter(item, #imageLiteral(resourceName: "ic_下拉"))

//            salaryBtn.setTitle(item, for: UIControlState())
//            
//            adjustBtnsTitleLabelAndImgaeView(salaryBtn)
            
        }
        
        // 红包
        let redEnvelopeBtn = ImageBtn(frame: CGRect(x: 0, y: 0, width: (screenSize.width)/6, height: 37))
        redEnvelopeBtn?.resetdataCenter("红包", #imageLiteral(resourceName: "ic_下拉"))
//        let redEnvelopeBtn = UIButton()
//        redEnvelopeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        redEnvelopeBtn.setTitle("红包", for: UIControlState())
//        redEnvelopeBtn.setImage(UIImage(named: "ic_下拉"), for: UIControlState())
//        exchangeBtnImageAndTitle(redEnvelopeBtn, margin: 5)
        
        // 红包 下拉
        redEnvelopeDrop.anchorView = redEnvelopeBtn
        
        redEnvelopeDrop.bottomOffset = CGPoint(x: 0, y: 37)
        redEnvelopeDrop.width = screenSize.width
        redEnvelopeDrop.direction = .bottom
        
        redEnvelopeDrop.dataSource = ["全部","职位红包","面试红包","就职红包"]
        
        // 下拉列表选中后的回调方法
        redEnvelopeDrop.selectionAction = { (index, item) in
            
            redEnvelopeBtn?.resetdataCenter(item, #imageLiteral(resourceName: "ic_下拉"))

//            redEnvelopeBtn.setTitle(item, for: UIControlState())
//            
//            adjustBtnsTitleLabelAndImgaeView(redEnvelopeBtn)

        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segment(withFrame: CGRect(x: 0, y: 0,width: screenSize.width ,height: 37), titleArray: ["最新","最热","最近","评价",salaryBtn as Any,redEnvelopeBtn as Any], defaultSelect: 0)!
        segChoose.tag = 101
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.black, selectTitleColor: baseColor, backGroundColor: UIColor.white, titleFontSize: 14)
        segChoose.delegate = self
        self.rootScrollView.addSubview(segChoose)
        
        // tableView
        findJobTableView.frame = CGRect(x: 0, y: segChoose.frame.maxY, width: screenSize.width, height: screenSize.height-20-44-49-37)
        findJobTableView.register(UINib.init(nibName: "ChChFindJobTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindJobTableViewCell")
        findJobTableView.separatorStyle = .none
        findJobTableView.rowHeight = 140
        findJobTableView.tag = 101
        findJobTableView.dataSource = self
        findJobTableView.delegate = self
        self.rootScrollView.addSubview(findJobTableView)
    }
    
    // MARK: 设置子视图_找雇主
    func setSubviews_findEmployer() {
        
        // 规模
        let scaleBtn = ImageBtn(frame: CGRect(x: 0, y: 0, width: (screenSize.width)/3, height: 37))
        scaleBtn?.resetdataCenter("规模", #imageLiteral(resourceName: "ic_下拉"))
//        let scaleBtn = UIButton()
//        scaleBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        scaleBtn.setTitle("规模", for: UIControlState())
//        scaleBtn.setImage(UIImage(named: "ic_下拉"), for: UIControlState())
//        exchangeBtnImageAndTitle(scaleBtn, margin: 5)
        
        // 规模 下拉
        scaleDrop.anchorView = scaleBtn
        
        scaleDrop.bottomOffset = CGPoint(x: 0, y: 37)
        scaleDrop.width = screenSize.width
        scaleDrop.direction = .bottom
        
        scaleDrop.dataSource = ["不限","一人","2人","3人"]
        
        // 下拉列表选中后的回调方法
        scaleDrop.selectionAction = { (index, item) in
            
            scaleBtn?.resetdataCenter(item, #imageLiteral(resourceName: "ic_下拉"))

//            scaleBtn.setTitle(item, for: UIControlState())
//            
//            adjustBtnsTitleLabelAndImgaeView(scaleBtn)

        }
        
        // 附近
        let nearbyBtn = ImageBtn(frame: CGRect(x: 0, y: 0, width: (screenSize.width)/3, height: 37))
        nearbyBtn?.resetdataCenter("附近", #imageLiteral(resourceName: "ic_下拉"))

//        let nearbyBtn = UIButton()
//        nearbyBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        nearbyBtn.setTitle("附近", for: UIControlState())
//        nearbyBtn.setImage(UIImage(named: "ic_下拉"), for: UIControlState())
//        exchangeBtnImageAndTitle(nearbyBtn, margin: 5)
        
        // 附近 下拉
        nearbyDrop.anchorView = nearbyBtn
        
        nearbyDrop.bottomOffset = CGPoint(x: 0, y: 37)
        nearbyDrop.width = screenSize.width
        nearbyDrop.direction = .bottom
        
        nearbyDrop.dataSource = ["测试用","一米","两米","三米"]
        
        // 下拉列表选中后的回调方法
        nearbyDrop.selectionAction = { (index, item) in
            
            nearbyBtn?.resetdataCenter(item, #imageLiteral(resourceName: "ic_下拉"))

//            nearbyBtn.setTitle(item, for: UIControlState())
//            
//            adjustBtnsTitleLabelAndImgaeView(nearbyBtn)

        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segment(withFrame: CGRect(x: screenSize.width, y: 0,width: screenSize.width ,height: 37), titleArray: ["最新",scaleBtn as Any,nearbyBtn as Any], defaultSelect: 0)!
        segChoose.tag = 102
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.black, selectTitleColor: baseColor, backGroundColor: UIColor.white, titleFontSize: 14)
        segChoose.delegate = self
        self.rootScrollView.addSubview(segChoose)
        
        // tableView
        findEmployerTableView.frame = CGRect(x: screenSize.width, y: segChoose.frame.maxY, width: screenSize.width, height: screenSize.height-20-44-49-37)
        findEmployerTableView.register(UINib.init(nibName: "ChChFindEmployerTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindEmployerTableViewCell")
        findEmployerTableView.separatorStyle = .none
        findEmployerTableView.rowHeight = 250
        findEmployerTableView.tag = 102
        findEmployerTableView.dataSource = self
        findEmployerTableView.delegate = self
        self.rootScrollView.addSubview(findEmployerTableView)
    }
    
    // MARK:自定义下拉列表样式
    func customizeDropDown() {
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 45
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
		appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadiu = 0
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 0
        appearance.animationduration = 0.25
        appearance.textColor = .darkGray
        appearance.textFont = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: LFLUISegmentedControlDelegate
    func uisegumentSelectionChange(_ selection: Int, segmentTag: Int) {
        print("ChChHomeViewController click \(selection) item")
        
        if segmentTag == 101 {
            
            if selection == 4 {
                _ = salaryDrop.show()
            }else if selection == 5 {
                _ = redEnvelopeDrop.show()
            }
        }else if segmentTag == 102 {
            
            if selection == 1 {
                _ = scaleDrop.show()
            }else if selection == 2 {
                _ = nearbyDrop.show()
            }
        }
    }
    
    // MARK: UITableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101 {
            return 1
        }else{
            return self.companyList.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 101 {
            return self.jobList.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 101 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChChFindJobTableViewCell") as! ChChFindJobTableViewCell
            cell.selectionStyle = .none
            
            cell.jobInfo = self.jobList[(indexPath as NSIndexPath).section]
            cell.companyBtn.tag = (indexPath as NSIndexPath).section
            cell.companyBtn.addTarget(self, action: #selector(companyBtnClick(_:)), for: .touchUpInside)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChChFindEmployerTableViewCell") as! ChChFindEmployerTableViewCell
            cell.selectionStyle = .none
            
            cell.companyInfo = self.companyList[(indexPath as NSIndexPath).row]
            cell.jobsCountBtn.tag = (indexPath as NSIndexPath).row
            cell.jobsCountBtn.addTarget(self, action: #selector(jobsCountBtnClick(_:)), for: .touchUpInside)
            return cell
        }
        
    }
    
    // MARK: UITableView Delegate
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 101 {
            let personalInfoVC = CHSChPersonalInfoViewController()
            personalInfoVC.jobInfo = self.jobList[(indexPath as NSIndexPath).section]
            
            self.navigationController?.pushViewController(personalInfoVC, animated: true)
        }else{
            let btn = UIButton()
            btn.tag = (indexPath as NSIndexPath).row
            self.companyBtnClick(btn)
        }
    }
    
    // MARK:- companyBtnClick
    func companyBtnClick(_ companyBtn:UIButton) {
        
        let companyHomeVC = CHSChCompanyHomeViewController()
        companyHomeVC.jobInfoUserid = self.jobList[companyBtn.tag].userid ?? ""
        self.navigationController?.pushViewController(companyHomeVC, animated: true)
    }
    
    // MARK:- jobsCountBtnClick
    func jobsCountBtnClick(_ jobsCountBtn:UIButton) {
        
        let companyPositionListVC = CHSChCompanyPositionListViewController()
        companyPositionListVC.company_infoJobs = self.companyList[jobsCountBtn.tag].jobs!
        self.navigationController?.pushViewController(companyPositionListVC, animated: true)
    }
    
    
    // MARK: - 定位
    func loadLocation() {
        
        self.locationManager.delegate = self
        
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.allowsBackgroundLocationUpdates = false
        
        
        // 如果需要持续定位返回逆地理编码信息，（自 V2.2.0版本起支持）需要做如下设置：
        self.locationManager.locatingWithReGeocode = true
        self.locationManager.startUpdatingLocation()
        
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        
        print("location:", location)
        
        
        if let location = location {
            
            if let regeocode = reGeocode {
                
                if  !AMapLocationDataAvailableForCoordinate(location.coordinate) {
                    
                    self.locationManager.stopUpdatingLocation()
                    
                    hud.mode = .text
                    hud.labelText = "不支持的位置"
                    hud.detailsLabelText = "该软件仅支持中国,请手动选择一个城市"
                    hud.hide(true, afterDelay: 1)
                    
                    let time: TimeInterval = 1.0
                    let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        
                        self.navigationController?.pushViewController(ChChCityViewController(), animated: true)
                        
                    }
                }
                
                self.locationManager.stopUpdatingLocation()
                
                UserDefaults.standard.set(changeCityName(cityName: regeocode.city ?? regeocode.province), forKey: positioningCity_key)
                UserDefaults.standard.set(changeCityName(cityName: regeocode.city ?? regeocode.province), forKey: myCity_key)
                positioningCity = UserDefaults.standard.string(forKey: positioningCity_key)!
                myCity = positioningCity
                cityBtn.resetdata(myCity, #imageLiteral(resourceName: "城市下拉箭头"))
                
                //                self.cityBtn.setTitle(myCity, for: UIControlState())
                //                adjustBtnsTitleLabelAndImgaeView(self.cityBtn)
                
                UserDefaults.standard.set(changeCityName(cityName: regeocode.city ?? regeocode.province), forKey: positioningCity_key)
                positioningCity = UserDefaults.standard.string(forKey: positioningCity_key)!
                
                if UserDefaults.standard.string(forKey: myCity_key) == nil {
                    
                    UserDefaults.standard.set(changeCityName(cityName: regeocode.city ?? regeocode.province), forKey: myCity_key)
                    
                    myCity = UserDefaults.standard.string(forKey: myCity_key)!
                }
                
                cityBtn.resetdata(myCity, #imageLiteral(resourceName: "城市下拉箭头"))
                hud.hide(true)

                
            }
            else {
                print("lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy)m")
                
            }
        }
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        
        self.locationManager.stopUpdatingLocation()
        
        hud.mode = .text
        hud.labelText = "定位失败"
        hud.hide(true, afterDelay: 1)
        
        let time: TimeInterval = 1.0
        let delay = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            self.navigationController?.pushViewController(ChChCityViewController(), animated: true)
            
        }
        
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


