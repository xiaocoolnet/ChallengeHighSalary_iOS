//
//  ChallengeHighSalary-Bridging-Header.h
//  ChallengeHighSalary
//
//  Created by zhang on 16/8/30.
//  Copyright © 2016年 北京校酷网络科技公司. All rights reserved.
//

#ifndef ChallengeHighSalary_Bridging_Header_h
#define ChallengeHighSalary_Bridging_Header_h

//TencentOpenapi
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiinterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/sdkdef.h>
#import <TencentOpenAPI/TencentmessageObject.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
//WeiXin
#import "WXApi.h"

#import "BButton.h"
#import "LFLUISegmentedControl.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "UIPlaceHolderTextView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TPKeyboardAvoidingTableView.h"
//#import <PgySDK/PgyManager.h>
#import <Bugtags/Bugtags.h>

#import <BmobSDK/Bmob.h>

/********* 高德地图 *********/

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapLocationKit/AMapLocationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

/**************************/

/********* 支付宝 **********/

#import <AlipaySDK/AlipaySDK.h>

/**************************/


#import "ImageBtn.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#endif /* ChallengeHighSalary_Bridging_Header_h */
