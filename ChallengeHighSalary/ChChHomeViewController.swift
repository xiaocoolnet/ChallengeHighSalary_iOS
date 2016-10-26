//
//  ChChHomeViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/5.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChHomeViewController: UIViewController, LFLUISegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate {

    //保存获取到的本地位置
    var currLocation : CLLocation!
    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
    let locationManager : CLLocationManager = CLLocationManager()
    
    
    let cityBtn = UIButton()
    
    let rootScrollView = UIScrollView()
    
    var jobList = [JobInfoDataModel]()
    
    var companyList = [Company_infoDataModel]()
    
    var salaryDrop = DropDown()
    var redEnvelopeDrop = DropDown()
    let findJobTableView = UITableView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Grouped)
    
    var scaleDrop = DropDown()
    var nearbyDrop = DropDown()
    let findEmployerTableView = UITableView(frame: CGRectMake(screenSize.width, 0, screenSize.width, screenSize.height-20-44-49-37), style: .Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
//        NSNotificationCenter.defaultCenter().addObserverForName("positioningCityNotification", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (noti) in
//            print("chchhome.. 执行")
//
//            self.cityBtn.setTitle(positioningCity, forState: .Normal)
//        })
        
        setNavigationBar()
        setSubviews()
        loadData()
        
        if NSUserDefaults.standardUserDefaults().stringForKey("myCity") == nil {
            loadLocation()
        }else{
            myCity = NSUserDefaults.standardUserDefaults().stringForKey("myCity")!
            cityBtn.setTitle(myCity, forState: .Normal)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
        
        cityBtn.setTitle(myCity, forState: .Normal)

        // 自定义下拉列表样式
        customizeDropDown()
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
    }
    
    // MARK: 设置 NavigationBar
    func setNavigationBar() {
        
        // 城市按钮
        cityBtn.frame = CGRectMake(0, 0, 100, 44)
        cityBtn.contentHorizontalAlignment = .Left
        cityBtn.setTitle(myCity, forState: .Normal)
        cityBtn.setImage(UIImage(named: "城市下拉箭头"), forState: .Normal)
        exchangeBtnImageAndTitle(cityBtn, margin: 5)
        cityBtn.addTarget(self, action: #selector(cityBtnClick), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityBtn)
        
        // UISegmentedControl
        let seg = UISegmentedControl(items: ["找工作","找雇主"])
        seg.frame = CGRectMake(0, 0, 120, 24)
        seg.addTarget(self, action: #selector(segValueChanged(_:)), forControlEvents: .ValueChanged)
        seg.selectedSegmentIndex = 0
        self.navigationItem.titleView = seg
        
        // rightBarButtonItems
        let retrievalBtn = UIButton(frame: CGRectMake(0, 0, 24, 24))
        retrievalBtn.setImage(UIImage(named: "ic_筛选"), forState: .Normal)
        retrievalBtn.addTarget(self, action: #selector(retrievalBtnClick), forControlEvents: .TouchUpInside)
        let retrievalItem = UIBarButtonItem(customView: retrievalBtn)
        
        let searchBtn = UIButton(frame: CGRectMake(0, 0, 24, 24))
        searchBtn.setImage(UIImage(named: "ic_搜索"), forState: .Normal)
        searchBtn.addTarget(self, action: #selector(searchBtnClick), forControlEvents: .TouchUpInside)
        let searchItem = UIBarButtonItem(customView: searchBtn)

        self.navigationItem.rightBarButtonItems = [searchItem,retrievalItem]
    }
    
    // MARK: 城市按钮点击事件
    func cityBtnClick() {
        self.navigationController?.pushViewController(ChChCityViewController(), animated: true)
    }
    
    // MARK: 检索按钮点击事件
    func retrievalBtnClick() {
        print("ChChHomeViewController searchBtnClick")
        self.navigationController?.pushViewController(CHSChRetrievalViewController(), animated: true)
    }
    
    // MARK: 搜索按钮点击事件
    func searchBtnClick() {
        print("ChChHomeViewController searchBtnClick")
        self.navigationController?.pushViewController(ChChSearchViewController(), animated: true)
    }
    
    // MARK: seg 点击事件
    func segValueChanged(seg:UISegmentedControl) {
        print(seg.selectedSegmentIndex)
        
        self.rootScrollView.contentOffset = CGPointMake(CGFloat(seg.selectedSegmentIndex)*screenSize.width, 0)
    }
    
    // MARK: 设置子视图
    func setSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        rootScrollView.frame = CGRectMake(0, 64,screenSize.width ,screenSize.height-49-64)
        rootScrollView.contentSize = CGSizeMake(screenSize.width*2, screenSize.height-49-64)
        rootScrollView.scrollEnabled = false
        self.view.addSubview(rootScrollView)
        
        setSubviews_findJob()
        setSubviews_findEmployer()
    }
    
    // MARK: 设置子视图_找工作
    func setSubviews_findJob() {
        
        // 薪资
        let salaryBtn = UIButton()
        salaryBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        salaryBtn.setTitle("薪资", forState: .Normal)
        salaryBtn.setImage(UIImage(named: "ic_下拉"), forState: .Normal)
        exchangeBtnImageAndTitle(salaryBtn, margin: 5)
        
        // 薪资 下拉
        salaryDrop.anchorView = salaryBtn
        
        salaryDrop.bottomOffset = CGPoint(x: 0, y: 37)
        salaryDrop.width = screenSize.width
        salaryDrop.direction = .Bottom
        
        salaryDrop.dataSource = ["不限","1万以下","1~2万","2~3万","3~4万","4~5万","5万以上"]
        
        // 下拉列表选中后的回调方法
        salaryDrop.selectionAction = { (index, item) in
            
            salaryBtn.setTitle(item, forState: .Normal)
        }
        
        // 红包
        let redEnvelopeBtn = UIButton()
        redEnvelopeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        redEnvelopeBtn.setTitle("红包", forState: .Normal)
        redEnvelopeBtn.setImage(UIImage(named: "ic_下拉"), forState: .Normal)
        exchangeBtnImageAndTitle(redEnvelopeBtn, margin: 5)
        
        // 红包 下拉
        redEnvelopeDrop.anchorView = redEnvelopeBtn
        
        redEnvelopeDrop.bottomOffset = CGPoint(x: 0, y: 37)
        redEnvelopeDrop.width = screenSize.width
        redEnvelopeDrop.direction = .Bottom
        
        redEnvelopeDrop.dataSource = ["测试用","大红包","小红包","不大不小的红包"]
        
        // 下拉列表选中后的回调方法
        redEnvelopeDrop.selectionAction = { (index, item) in
            
            redEnvelopeBtn.setTitle(item, forState: .Normal)
        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segmentWithFrame(CGRectMake(0, 0,screenSize.width ,37), titleArray: ["最新","最热","最近","评价",salaryBtn,redEnvelopeBtn], defaultSelect: 0)
        segChoose.tag = 101
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.blackColor(), selectTitleColor: baseColor, backGroundColor: UIColor.whiteColor(), titleFontSize: 14)
        segChoose.delegate = self
        self.rootScrollView.addSubview(segChoose)
        
        // tableView
        findJobTableView.frame = CGRectMake(0, CGRectGetMaxY(segChoose.frame), screenSize.width, screenSize.height-20-44-49-37)
        findJobTableView.registerNib(UINib.init(nibName: "ChChFindJobTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindJobTableViewCell")
        findJobTableView.separatorStyle = .None
        findJobTableView.rowHeight = 140
        findJobTableView.tag = 101
        findJobTableView.dataSource = self
        findJobTableView.delegate = self
        self.rootScrollView.addSubview(findJobTableView)
    }
    
    // MARK: 设置子视图_找雇主
    func setSubviews_findEmployer() {
        
        // 规模
        let scaleBtn = UIButton()
        scaleBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        scaleBtn.setTitle("规模", forState: .Normal)
        scaleBtn.setImage(UIImage(named: "ic_下拉"), forState: .Normal)
        exchangeBtnImageAndTitle(scaleBtn, margin: 5)
        
        // 规模 下拉
        scaleDrop.anchorView = scaleBtn
        
        scaleDrop.bottomOffset = CGPoint(x: 0, y: 37)
        scaleDrop.width = screenSize.width
        scaleDrop.direction = .Bottom
        
        scaleDrop.dataSource = ["不限","一人","2人","3人"]
        
        // 下拉列表选中后的回调方法
        scaleDrop.selectionAction = { (index, item) in
            
            scaleBtn.setTitle(item, forState: .Normal)
        }
        
        // 附近
        let nearbyBtn = UIButton()
        nearbyBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        nearbyBtn.setTitle("附近", forState: .Normal)
        nearbyBtn.setImage(UIImage(named: "ic_下拉"), forState: .Normal)
        exchangeBtnImageAndTitle(nearbyBtn, margin: 5)
        
        // 附近 下拉
        nearbyDrop.anchorView = nearbyBtn
        
        nearbyDrop.bottomOffset = CGPoint(x: 0, y: 37)
        nearbyDrop.width = screenSize.width
        nearbyDrop.direction = .Bottom
        
        nearbyDrop.dataSource = ["测试用","一米","两米","三米"]
        
        // 下拉列表选中后的回调方法
        nearbyDrop.selectionAction = { (index, item) in
            
            nearbyBtn.setTitle(item, forState: .Normal)
        }
        
        // 选择菜单
        let segChoose = LFLUISegmentedControl.segmentWithFrame(CGRectMake(screenSize.width, 0,screenSize.width ,37), titleArray: ["最新",scaleBtn,nearbyBtn], defaultSelect: 0)
        segChoose.tag = 102
        segChoose.lineColor(baseColor)
        segChoose.titleColor(UIColor.blackColor(), selectTitleColor: baseColor, backGroundColor: UIColor.whiteColor(), titleFontSize: 14)
        segChoose.delegate = self
        self.rootScrollView.addSubview(segChoose)
        
        // tableView
        findEmployerTableView.frame = CGRectMake(screenSize.width, CGRectGetMaxY(segChoose.frame), screenSize.width, screenSize.height-20-44-49-37)
        findEmployerTableView.registerNib(UINib.init(nibName: "ChChFindEmployerTableViewCell", bundle: nil), forCellReuseIdentifier: "ChChFindEmployerTableViewCell")
        findEmployerTableView.separatorStyle = .None
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
        appearance.textColor = .darkGrayColor()
        appearance.textFont = UIFont.systemFontOfSize(14)
    }
    
    // MARK: LFLUISegmentedControlDelegate
    func uisegumentSelectionChange(selection: Int, segmentTag: Int) {
        print("ChChHomeViewController click \(selection) item")
        
        if segmentTag == 101 {
            
            if selection == 4 {
                salaryDrop.show()
            }else if selection == 5 {
                redEnvelopeDrop.show()
            }
        }else if segmentTag == 102 {
            
            if selection == 1 {
                scaleDrop.show()
            }else if selection == 2 {
                nearbyDrop.show()
            }
        }
    }
    
    // MARK: UITableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 101 {
            return 1
        }else{
            return self.companyList.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView.tag == 101 {
            return self.jobList.count
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 101 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ChChFindJobTableViewCell") as! ChChFindJobTableViewCell
            cell.selectionStyle = .None
            
            cell.jobInfo = self.jobList[indexPath.section]
            cell.companyBtn.tag = indexPath.section
            cell.companyBtn.addTarget(self, action: #selector(companyBtnClick(_:)), forControlEvents: .TouchUpInside)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("ChChFindEmployerTableViewCell") as! ChChFindEmployerTableViewCell
            cell.selectionStyle = .None
            
            cell.companyInfo = self.companyList[indexPath.row]
            cell.jobsCountBtn.tag = indexPath.row
            cell.jobsCountBtn.addTarget(self, action: #selector(jobsCountBtnClick(_:)), forControlEvents: .TouchUpInside)
            return cell
        }
        
    }
    
    // MARK: UITableView Delegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag == 101 {
            let personalInfoVC = CHSChPersonalInfoViewController()
            personalInfoVC.jobInfo = self.jobList[indexPath.section]
            
            self.navigationController?.pushViewController(personalInfoVC, animated: true)
        }else{
            let btn = UIButton()
            btn.tag = indexPath.row
            self.companyBtnClick(btn)
        }
    }
    
    // MARK:- companyBtnClick
    func companyBtnClick(companyBtn:UIButton) {
        
        let companyHomeVC = CHSChCompanyHomeViewController()
        companyHomeVC.jobInfoUserid = self.jobList[companyBtn.tag].userid ?? ""
        self.navigationController?.pushViewController(companyHomeVC, animated: true)
    }
    
    // MARK:- jobsCountBtnClick
    func jobsCountBtnClick(jobsCountBtn:UIButton) {
        
        let companyPositionListVC = CHSChCompanyPositionListViewController()
        companyPositionListVC.company_infoJobs = (self.companyList[jobsCountBtn.tag].jobs! ?? nil)!
        self.navigationController?.pushViewController(companyPositionListVC, animated: true)
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

extension ChChHomeViewController: CLLocationManagerDelegate
{
    
    //打开定位
    func loadLocation()
    {
        
        locationManager.delegate = self
        //定位方式
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //iOS8.0以上才可以使用
        if(UIDevice.currentDevice().systemVersion >= "8.0"){
            //始终允许访问位置信息
            locationManager.requestAlwaysAuthorization()
            //使用应用程序期间允许访问位置数据
            locationManager.requestWhenInUseAuthorization()
        }
        //开启定位
        locationManager.startUpdatingLocation()
    }
    
    
    
    //获取定位信息
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //取得locations数组的最后一个
        let location:CLLocation = locations[locations.count-1]
        currLocation = locations.last!
        //判断是否为空
        if(location.horizontalAccuracy > 0){
            let lat = Double(String(format: "%.1f", location.coordinate.latitude))
            let long = Double(String(format: "%.1f", location.coordinate.longitude))
            print("纬度:\(long!)")
            print("经度:\(lat!)")
            LonLatToCity()
            //停止定位
//            locationManager.stopUpdatingLocation()
        }
        
    }
    
    //出现错误
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print("didFinishDeferredUpdatesWithError",error)
    }
    
    ///将经纬度转换为城市名
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
            
            if(error == nil)
            {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                //城市
                let city: String = (mark.addressDictionary! as NSDictionary).valueForKey("City") as! String
                //国家
                let country: NSString = (mark.addressDictionary! as NSDictionary).valueForKey("Country") as! NSString
                //国家编码
                let CountryCode: NSString = (mark.addressDictionary! as NSDictionary).valueForKey("CountryCode") as! NSString
                //街道位置
                let FormattedAddressLines: NSString = (mark.addressDictionary! as NSDictionary).valueForKey("FormattedAddressLines")?.firstObject as! NSString
                //具体位置
                let Name: NSString = (mark.addressDictionary! as NSDictionary).valueForKey("Name") as! NSString
                //省
                var State: String = (mark.addressDictionary! as NSDictionary).valueForKey("State") as! String
                //区
                let SubLocality: NSString = (mark.addressDictionary! as NSDictionary).valueForKey("SubLocality") as! NSString
                
                
                //如果需要去掉“市”和“省”字眼
                
                State = State.stringByReplacingOccurrencesOfString("省", withString: "")
                let citynameStr = city.stringByReplacingOccurrencesOfString("市", withString: "")
                
                print(city)
                print(country)
                print(CountryCode)
                print(FormattedAddressLines)
                print(Name)
                print(State)
                print(SubLocality)
                
                print(citynameStr)
                positioningCity = citynameStr
                
                NSUserDefaults.standardUserDefaults().setValue(positioningCity, forKey: "myCity")
                myCity = positioningCity
                
                self.cityBtn.setTitle(myCity, forState: .Normal)
                
                self.locationManager.stopUpdatingLocation()

            }
            else
            {
                print(error)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("positioningCityNotification", object: nil)
        }
        
        
    }
    
}
