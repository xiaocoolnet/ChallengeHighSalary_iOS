platform :ios, '8.0'
use_frameworks!

target 'ChallengeHighSalary' do
  pod 'MJRefresh', '~> 3.1.12'
  pod 'AFNetworking', '~> 3.1.0'
  pod 'HandyJSON', '~> 1.4.0'
  pod 'PagingMenuController', '~> 1.4.0'
#  pod 'PickerView', '~> 0.2.3'
  pod 'SDWebImage', '~>3.8'
#  pod 'Pgyer', '2.8.4'
  pod 'BmobSDK'
  pod 'AMapLocation'  #定位 SDK
  pod 'AMap3DMap'  #3D地图 SDK（2D地图：AMap2DMap NO-IDFA版本：AMap3DMap-NO-IDFA，AMap2DMap-NO-IDFA）
  pod 'AMapSearch'
  pod 'Bugtags'
  pod 'TZImagePickerController'
  pod 'AGEmojiKeyboard'

  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
#              config.build_settings['ENABLE_BITCODE'] = 'NO'
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end
end
