platform :ios, '8.0'
use_frameworks!

target 'ChallengeHighSalary' do
#  pod 'Alamofire', '~> 4.0.1'
#  pod 'D3Model', '~> 2.0.3'
  pod 'AFNetworking', '~> 3.1.0'
  pod 'HandyJSON', '~> 1.2.1'
  pod 'PagingMenuController', '~> 1.4.0'
  pod 'PickerView', '~> 0.2.3'
  pod 'SDWebImage', '~>3.8'
  pod 'Pgyer', '2.8.4'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
#              config.build_settings['ENABLE_BITCODE'] = 'NO'
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end
end
