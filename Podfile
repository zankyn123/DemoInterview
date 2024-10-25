# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

use_frameworks!
# ignore all warnings from all pods
inhibit_all_warnings!

def shared_pods
  pod 'SwiftLint', '0.57.0'
  pod 'SwiftGen', '6.6.3'
  pod 'lottie-ios', '4.5.0'
  pod 'netfox', '1.21.0', :configurations => 'Debug'
end

target 'ProjectDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  shared_pods
 
  target 'ProjectDemoTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
