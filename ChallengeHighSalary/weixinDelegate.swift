//
//  weixinDelegate.swift
//  ChallengeHighSalary
//
//  Created by 高扬 on 2016/12/22.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

import UIKit

class weixinDelegate: NSObject,WXApiDelegate {
    /*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
     *
     * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
     * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
     * @param req 具体请求内容，是自动释放的
     */
    func onReq(_ req: BaseReq!) {
        
    }
    
    /*! @brief 发送一个sendReq后，收到微信的回应
     *
     * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
     * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
     * @param resp具体的回应内容，是自动释放的
     */
    func onResp(_ resp: BaseResp!) {
        if resp .isKind(of: PayResp.self) {
            let response = resp as! PayResp
            switch response.errCode {
            case WXSuccess.rawValue:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                print("支付成功")
            default:
                print("支付失败，retcode= \(resp.errCode)")
            }
        }
    }

}
