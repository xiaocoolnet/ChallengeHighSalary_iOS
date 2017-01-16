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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        loadData()
        setSubView()
    }
    
    func loadData() {
        let path = Bundle.main.path(forResource: "citydict", ofType: "plist")
        cityDict = NSDictionary(contentsOfFile: path!) as! [String:Array<String>]
        
        cityIndexArray = Array(cityDict.keys).sorted(){ $1 > $0 }
        
        
        let positioningCityArray = [positioningCity]
        let hotCityArray = ["上海","北京","广州","深圳","武汉","天津","西安","南京","杭州"]
        cityIndexArray.insert("定位", at: 0)
        cityIndexArray.insert("热门", at: 1)
        
        cityDict["定位"] = positioningCityArray
        cityDict["热门"] = hotCityArray
        
        //        self.sectionCitySpell.addObjectsFromArray(self.citySpell as [AnyObject]);
        print(cityIndexArray)
       
    }
    
    // MARK: popViewcontroller
    func popViewcontroller() {
        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- 设置子视图
    func setSubView() {
        
        self.title = "更多城市"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .Done, target: self, action: #selector(popViewcontroller))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(popViewcontroller))
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: 70))
        searchBar.placeholder = "输入城市或拼音查询"
        searchBar.barTintColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.view.addSubview(searchBar)
        
        
        let myTableView = UITableView(frame: CGRect(x: 0, y: searchBar.frame.maxY, width: screenSize.width, height: screenSize.height-searchBar.frame.maxY), style: .plain)
        myTableView.sectionIndexColor = UIColor.gray
        myTableView.sectionIndexBackgroundColor = UIColor.clear
        myTableView.rowHeight = 200
        myTableView.separatorStyle = .none
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(ChChCityTableViewCell.self, forCellReuseIdentifier: "ChChCityTableViewCell")
        self.view.addSubview(myTableView)
    }
    
    // MARK:- TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityIndexArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return cityIndexArray
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch cityIndexArray[section] {
        case "定位":
            return "定位城市"
        case "热门":
            return "热门城市"
        default:
            return cityIndexArray[section]
        }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChChCityTableViewCell") as! ChChCityTableViewCell
        cell.selectionStyle = .none
        
        cell.delegate = self
        
        cell.setBtns(cityDict[cityIndexArray[(indexPath as NSIndexPath).section]]!, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        tableView.cellForRowAtIndexPath(indexPath)
        let cityBtnMargin:CGFloat = 10
        var cityBtnX:CGFloat = cityBtnMargin
        var cityBtnY:CGFloat = cityBtnMargin
        var cityBtnWidth:CGFloat = 0
        let cityBtnHeight:CGFloat = 25
        
        for (i,city) in cityDict[cityIndexArray[(indexPath as NSIndexPath).section]]!.enumerated() {
            cityBtnWidth = calculateWidth(city, size: 14, height: cityBtnHeight)+cityBtnMargin*4
            
            
            if i+1 < cityDict[cityIndexArray[(indexPath as NSIndexPath).section]]!.count {
                
                let nextBtnWidth = calculateWidth(cityDict[cityIndexArray[(indexPath as NSIndexPath).section]]![i+1], size: 14, height: cityBtnHeight)+cityBtnMargin*4
                
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
    
    func cityTableViewCellCityBtnClick(_ cityBtn: UIButton, indexPath: IndexPath, index: Int) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "currentCityChanged"), object: cityBtn.currentTitle!)
        
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
