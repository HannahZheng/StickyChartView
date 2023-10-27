platform :ios, '13.0'

#source 'https://github.com/CocoaPods/Specs.git'

target 'StickyChartDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

 pod 'SnapKit', '~> 5.6.0'
 pod 'MJRefresh', '~> 3.7.5'

 end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
