//
//  LoReCHSChooseCityViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 2016/10/10.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class LoReCHSChooseCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChChCityTableViewCellDelegate {
    
    var cityDict = [String:Array<String>]()
    var cityIndexArray = Array<String>()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate().loadLocation()
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadData()
        setSubView()
    }
    
    func loadData() {
        let path = NSBundle.mainBundle().pathForResource("citydict", ofType: "plist")
        cityDict = NSDictionary(contentsOfFile: path!) as! [String:Array<String>]
        
        cityIndexArray = Array(cityDict.keys).sort(){ $1 > $0 }
        
        
        let positioningCityArray = [positioningCity]
        let hotCityArray = ["上海","北京","广州","深圳","武汉","天津","西安","南京","杭州"]
        cityIndexArray.insert("定位", atIndex: 0)
        cityIndexArray.insert("热门", atIndex: 1)
        
        cityDict["定位"] = positioningCityArray
        cityDict["热门"] = hotCityArray
        
        //        self.sectionCitySpell.addObjectsFromArray(self.citySpell as [AnyObject]);
        print(cityIndexArray)
        NSNotificationCenter.defaultCenter().addObserverForName("positioningCityNotification", object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (noti) in
            print("chchcity.. 执行")
            self.cityDict["定位"] = [positioningCity]
        })
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.dismissViewControllerAnimated(true, completion: nil)
//        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubView() {
        
        self.title = "更多城市"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(popViewcontroller))
        
        let searchBar = UISearchBar(frame: CGRectMake(0, 64, screenSize.width, 70))
        searchBar.placeholder = "输入城市或拼音查询"
        searchBar.barTintColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.view.addSubview(searchBar)
        
        
        let myTableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(searchBar.frame), screenSize.width, screenSize.height-CGRectGetMaxY(searchBar.frame)), style: .Plain)
        myTableView.sectionIndexColor = UIColor.grayColor()
        myTableView.sectionIndexBackgroundColor = UIColor.clearColor()
        myTableView.rowHeight = 200
        myTableView.separatorStyle = .None
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.registerClass(ChChCityTableViewCell.self, forCellReuseIdentifier: "ChChCityTableViewCell")
        self.view.addSubview(myTableView)
    }
    
    // MARK:- TableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return cityIndexArray.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return cityIndexArray
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch cityIndexArray[section] {
        case "定位":
            return "定位城市"
        case "热门":
            return "热门城市"
        default:
            return cityIndexArray[section]
        }
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChChCityTableViewCell") as! ChChCityTableViewCell
        cell.selectionStyle = .None
        
        cell.delegate = self
        
        cell.setBtns(cityDict[cityIndexArray[indexPath.section]]!, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //        tableView.cellForRowAtIndexPath(indexPath)
        let cityBtnMargin:CGFloat = 10
        var cityBtnX:CGFloat = cityBtnMargin
        var cityBtnY:CGFloat = cityBtnMargin
        var cityBtnWidth:CGFloat = 0
        let cityBtnHeight:CGFloat = 25
        
        for (i,city) in cityDict[cityIndexArray[indexPath.section]]!.enumerate() {
            cityBtnWidth = calculateWidth(city, size: 14, height: cityBtnHeight)+cityBtnMargin*4
            
            
            if i+1 < cityDict[cityIndexArray[indexPath.section]]!.count {
                
                let nextBtnWidth = calculateWidth(cityDict[cityIndexArray[indexPath.section]]![i+1], size: 14, height: cityBtnHeight)+cityBtnMargin*4
                
                if cityBtnWidth + cityBtnX + cityBtnMargin + nextBtnWidth >= screenSize.width - 20 {
                    cityBtnX = cityBtnMargin
                    cityBtnY = cityBtnHeight + cityBtnY + cityBtnMargin
                }else{
                    
                    cityBtnX = cityBtnWidth + cityBtnX + cityBtnMargin
                }
            }
        }
        
        return cityBtnY+cityBtnHeight+cityBtnMargin
    }
    
    func cityTableViewCellCityBtnClick(cityBtn: UIButton, indexPath: NSIndexPath, index: Int) {
        NSNotificationCenter.defaultCenter().postNotificationName("currentCityChanged", object: cityBtn.currentTitle!)
        
        self.popViewcontroller()
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
