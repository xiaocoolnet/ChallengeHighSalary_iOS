//
//  ChChCityViewController.swift
//  ChallengeHighSalary
//
//  Created by zhang on 16/9/7.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class ChChCityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChChCityTableViewCellDelegate {

    let rootTableView = UITableView()
    
    var cityDict = [String:Array<String>]()
    var cityIndexArray = Array<String>()
    
    var locationManager = AMapLocationManager()
    var locationError:String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadData()
        setSubView()
        
        loadLocation()
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
        
        if myCity == "城市" {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud?.mode = .text
            hud?.labelText = "请选择您的城市"
            hud?.removeFromSuperViewOnHide = true
            
            hud?.hide(true, afterDelay: 1)
        }else{
            
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK:- 设置子视图
    func setSubView() {
        
        self.title = "更多城市"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_返回_white"), style: .done, target: self, action: #selector(popViewcontroller))
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: 70))
        searchBar.placeholder = "输入城市或拼音查询"
        searchBar.barTintColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        self.view.addSubview(searchBar)
        
        
        rootTableView.frame = CGRect(x: 0, y: searchBar.frame.maxY, width: screenSize.width, height: screenSize.height-searchBar.frame.maxY)
        rootTableView.sectionIndexColor = UIColor.gray
        rootTableView.sectionIndexBackgroundColor = UIColor.clear
        rootTableView.rowHeight = 200
        rootTableView.separatorStyle = .none
        rootTableView.dataSource = self
        rootTableView.delegate = self
        rootTableView.register(ChChCityTableViewCell.self, forCellReuseIdentifier: "ChChCityTableViewCell")
        self.view.addSubview(rootTableView)
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

        cell.setBtns((cityDict[cityIndexArray[(indexPath as NSIndexPath).section]] ?? [])!, indexPath: indexPath)
        cell.delegate = self
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
    
    // MARK: ChChCityTableViewCellDelegate
    func cityTableViewCellCityBtnClick(_ cityBtn: UIButton, indexPath: IndexPath, index:Int) {
        print(cityBtn.currentTitle)
        
        if (indexPath as NSIndexPath).section == 0 && (cityBtn.currentTitle == "未知" || self.locationError != nil) {

            self.loadLocation()
        }else{
            
            UserDefaults.standard.setValue(cityBtn.currentTitle, forKey: myCity_key)
            myCity = (UserDefaults.standard.string(forKey: myCity_key) ?? myCity)!
            let _ = self.navigationController?.popViewController(animated: true)
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


extension ChChCityViewController: AMapLocationManagerDelegate {
    func loadLocation() {
        
        self.locationManager = AMapLocationManager()
        self.locationManager.delegate = self
        
        // 如果需要持续定位返回逆地理编码信息，（自 V2.2.0版本起支持）需要做如下设置：
        self.locationManager.locatingWithReGeocode = true
        self.locationManager.startUpdatingLocation()
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        
        print("location:", location)
        
        if let location = location {
            
            if let regeocode = reGeocode {
                
                self.locationError = nil
                
                self.locationManager.stopUpdatingLocation()
                
                UserDefaults.standard.set(changeCityName(cityName: (regeocode.city ?? regeocode.province)), forKey: positioningCity_key)
                positioningCity = UserDefaults.standard.string(forKey: positioningCity_key)!
                self.cityDict[self.cityIndexArray[0]] = [positioningCity]
                self.rootTableView.reloadData()
                
                print("\(regeocode.formattedAddress) \n \(regeocode.citycode!)-\(regeocode.adcode!)-\(location.horizontalAccuracy)m")
            }
            else {
                print("lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy)m")
            }
            
        }
    }
    
    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {
        
        if (error) != nil {
            self.locationManager.stopUpdatingLocation()
            
            self.locationError = "定位失败，点击重试"
            self.cityDict[self.cityIndexArray[0]] = ["定位失败，点击重试"]
            self.rootTableView.reloadData()
            
            return
            
        }

    }
}

//extension ChChCityViewController {
//    
//   
//    
//    func getLocation() {
//        
//        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
//        
//        self.locationManager.requestLocation(withReGeocode: true) { (location, regeocode, error) in
//            
//            if let error = error {
//                
//                self.loactionError = error.localizedDescription
//                self.cityDict[self.cityIndexArray[0]] = [error.localizedDescription]
//                self.rootTableView.reloadData()
//                
//                return
//                
//            }
//            
//            print("location:", location)
//            
//            if let location = location {
//                
//                if let regeocode = regeocode {
//                    
//                    UserDefaults.standard.set(regeocode.city ?? regeocode.province, forKey: positioningCity_key)
//                    positioningCity = UserDefaults.standard.string(forKey: positioningCity_key)!
//                    self.cityDict[self.cityIndexArray[0]] = [positioningCity]
//                    self.rootTableView.reloadData()
//                    
//                    print("\(regeocode.formattedAddress) \n \(regeocode.citycode!)-\(regeocode.adcode!)-\(location.horizontalAccuracy)m")
//                }
//                else {
//                    print("lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy)m")
//                }
//
//            }
//        }
//    }
//    
//}
