platform :ios, '12.0'
use_frameworks!

target 'GitHub' do
  pod 'Alamofire'
  pod 'SnapKit', '~> 5.6.0'

  # AlamofireImage for image caching
#  pod 'AlamofireImage', '~> 4.2'

  # Optional: Kingfisher (alternative to AlamofireImage)
   pod 'Kingfisher'
   
   target 'GitHubTests' do
     inherit! :search_paths
     pod 'Alamofire'
   end
   
   post_install do |installer|
     installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
         config.build_settings['SWIFT_VERSION'] = '5.4'
         config.build_settings['OTHER_SWIFT_FLAGS'] = ['-suppress-warnings']
       end
     end
   end
end
