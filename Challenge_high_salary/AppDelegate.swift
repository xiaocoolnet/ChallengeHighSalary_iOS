//
//  AppDelegate.swift
//  Challenge_high_salary
//
//  Created by zhang on 16/8/29.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //保存获取到的本地位置
    var currLocation : CLLocation!
    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
    let locationManager : CLLocationManager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().tintColor = baseColor
        UITabBar.appearance().backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        
        UINavigationBar.appearance().barTintColor = baseColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.whiteColor()
        ]
        
        loadLocation()
        
//        NSUserDefaults.standardUserDefaults().removeObjectForKey("appVersion")
        
        // 得到当前应用的版本号
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        
        // 取出之前保存的版本号
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let appVersion = userDefaults.stringForKey("appVersion")
                
        // 如果 appVersion 为 nil 说明是第一次启动；如果 appVersion 不等于 currentAppVersion 说明是更新了
        if appVersion == nil || appVersion != currentAppVersion {
            // 保存最新的版本号
            userDefaults.setValue(currentAppVersion, forKey: "appVersion")
            
            let guideViewController = GuideViewController()
            guideViewController.guideImageArray = ["GuideImage1","GuideImage2","GuideImage3"]
            self.window?.rootViewController = guideViewController
        }else{
//            self.window?.rootViewController = FTRoHomeViewController()
            self.window?.rootViewController = UINavigationController(rootViewController: LoHomeViewController())

        }
        
        return true
    }
    
//    #pragma mark 引导页
//    -(void)setupIntroductoryPage
//    {
//    if (BBUserDefault.isNoFirstLaunch)
//    {
//    return;
//    }
//    BBUserDefault.isNoFirstLaunch=YES;
//    NSArray *images=@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3",@"introductoryPage4"];
//    [introductoryPagesHelper showIntroductoryPageView:images];
//    }
    // MARK:- 引导页
    func setupIntroductoryPage() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(isNoFirstLaunch_key)
        if NSUserDefaults.standardUserDefaults().boolForKey(isNoFirstLaunch_key) {
            return
        }
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: isNoFirstLaunch_key)
        let images = ["introductoryPage1","introductoryPage2","introductoryPage3","introductoryPage4"]
        
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CLLocationManagerDelegate
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
            locationManager.stopUpdatingLocation()
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
                
                
                
            }
            else
            {
                print(error)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("positioningCityNotification", object: nil)
        }
        
        
    }
    
}

