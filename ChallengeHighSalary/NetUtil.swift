//
//  ZYNetwork.swift
//  swift第三方
//
//  Created by  on 16/4/21.
//  Copyright © 2016年 张子谊. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SystemConfiguration

//创建请求类枚举
enum RequestType: Int {
    case requestTypeGet
    case requestTypePost
    case requestTypeDelegate
}
//关于网络检测枚举
let ReachabilityStatusChangedNotification = "ReachabilityStatusChangedNotification"

enum ReachabilityType: CustomStringConvertible {
    case wwan
    case wiFi
    
    var description: String {
        switch self {
        case .wwan: return "WWAN"
        case .wiFi: return "WiFi"
        }
    }
}

enum ReachabilityStatus: CustomStringConvertible  {
    case offline
    case online(ReachabilityType)
    case unknown
    
    var description: String {
        switch self {
        case .offline: return "Offline"
        case .online(let type): return "Online (\(type))"
        case .unknown: return "Unknown"
        }
    }
}
enum ResultType {
    case success
    case failure
}

//创建一个闭包(注:oc中block)
typealias sendVlesClosure = (AnyObject?, NSError?)->Void
typealias uploadClosure = (AnyObject?, NSError?,Int64?,Int64?,Int64?)->Void
class NetUtil: NSObject {
    
    static let net = NetUtil()

    //网络请求中的GET,Post,DELETE
    func request(_ type:RequestType ,URLString:String, Parameter:[String:AnyObject]?, block:@escaping sendVlesClosure) {
        if (!self.checkConnect()) {
            return
        }
        switch type {
        case .requestTypeGet:
            Alamofire.request(URLString, method: .get, parameters: Parameter).responseJSON(completionHandler: { (response) in
                block(response.result.value as AnyObject?,nil)
            })
//            Alamofire.request(.GET, URLString, parameters: Parameter).responseJSON {response in
//                block(response.result.value,nil)
//                //把得到的JSON数据转为字典
//            }
        case .requestTypePost:
            
            Alamofire.request(URLString, method: .post, parameters: Parameter).responseJSON(completionHandler: { (response) in
                block(response.result.value as AnyObject?,nil)
            })
//            Alamofire.request(.POST, URLString, parameters:Parameter).responseJSON {response in
//                
//                block(nil, response.result.error)
//                //把得到的JSON数据转为字典
//            }
        case .requestTypeDelegate:
            
            Alamofire.request(URLString, method: .delete, parameters: Parameter).responseJSON(completionHandler: { (response) in
            })
//            Alamofire.request(.DELETE, URLString, parameters: Parameter).responseJSON{responde in
//                
//            }
        }
        
    }
    
    //关于文件上传的方法
    //fileURL实例:let fileURL = NSBundle.mainBundle().URLForResource("Default",withExtension: "png")
//    func upload(_ type:RequestType,URLString:String,fileURL:URL,block:uploadClosure) {
//        //检测网络是否存在的方法
//        if (!self.checkConnect()) {
//            return
//        }
//        Alamofire.upload(.POST, URLString, file: fileURL).progress {(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
//            block(nil,nil,bytesWritten ,totalBytesWritten,totalBytesExpectedToWrite)
//            }.responseJSON { response in
//                block(response.result.value,response.result.error,nil,nil,nil)
//        }
//        
//    }
    
    func uploadWithPOST(_ URLString:String,data: Data, name: String, fileName: String, mimeType: String,block:@escaping (_ resultType:ResultType) -> Void) {
        //检测网络是否存在的方法
        if (!self.checkConnect()) {
            return
        }
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: name, fileName: fileName, mimeType: mimeType)
            
            }, to: URLString) { (response) in
                switch response {
                case .success(request: _, streamingFromDisk: _, streamFileURL: _):
                    block(.success)
                    
                case .failure(_):
                    block(.failure)
                    
                }
        }
        
        
        
//        Alamofire.upload(.POST, URLString, multipartFormData: { (multipartFormData) in
//            multipartFormData.appendBodyPart(data: data, name: name, fileName: fileName, mimeType: mimeType)
//            }) { (response) in
//                switch response {
//                case .Success( _, _, _):
//                    block(resultType: .Success)
//                    
//                case .Failure( _):
//                    block(resultType: .Failure)
//
//                }
//
//        }
    }
    
    //关于文件下载的方法
    //下载到默认路径let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
//    let des =
//    let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
//    //默认路径可以设置为空,因为有默认路径
//    func download(_ type:RequestType,URLString:String,block:uploadClosure) {
//        //检测网络是否存在的方法
//        if (!self.checkConnect()) {
//            return
//        }
//        switch type {
//        case .requestTypeGet:
//            Alamofire.download(.GET, URLString, destination: destination)
//                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
//                    block(nil,nil,bytesRead, totalBytesRead, totalBytesExpectedToRead)
//                }
//                .response { (request, response, _, error) in
//                    block(response,error,nil,nil,nil)
//            }
//            break
//        case .requestTypePost:
//            Alamofire.download(.POST, URLString, destination: destination)
//                .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
//                    block(nil,nil,bytesRead, totalBytesRead, totalBytesExpectedToRead)
//                }
//                .response { (request, response, _, error) in
//                    block(response,error,nil,nil,nil)
//            }
//        default:break
//        }
//    }
    //检测网络
    func checkConnect()->Bool {
        let status = self.connectionStatus()
        switch status{
        case .unknown,.offline:
            //print("无网络")
            return false
        case .online(.wwan):
            //print("y有网络")
            return true
        case .online(.wiFi):
            //print("有wifi请链接")
            return true
        }
    }
    //下面是关于网络检测的方法
    func connectionStatus() -> ReachabilityStatus {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, { (<#UnsafePointer<T>#>) -> Result in
//            <#code#>
//        }) else {
//            <#statements#>
//        }
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
//            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
//        }) else {
//            return .unknown
//        }
        
//        var flags : SCNetworkReachabilityFlags = []
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
//            return .unknown
//        }
        return .online(.wiFi)
    }
    
    
//    func monitorReachabilityChanges() {
//        let host = "google.com"
//        var context = SCNetworkReachabilityContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
//        let reachability = SCNetworkReachabilityCreateWithName(nil, host)!
//        
//        SCNetworkReachabilitySetCallback(reachability, { (_, flags, _) in
//            let status = ReachabilityStatus(reachabilityFlags: flags)
//            
//            NotificationCenter.default.post(name: Notification.Name(rawValue: ReachabilityStatusChangedNotification),
//                object: nil,
//                userInfo: ["Status": status.description])
//            
//            }, &context)
//        
//        SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetMain(), CFRunLoopMode.commonModes)
//    }
}
extension ReachabilityStatus {
    fileprivate init(reachabilityFlags flags: SCNetworkReachabilityFlags) {
        let connectionRequired = flags.contains(.connectionRequired)
        let isReachable = flags.contains(.reachable)
        let isWWAN = flags.contains(.isWWAN)
        
        if !connectionRequired && isReachable {
            if isWWAN {
                self = .online(.wwan)
            } else {
                self = .online(.wiFi)
            }
        } else {
            self =  .offline
        }
    }
}
