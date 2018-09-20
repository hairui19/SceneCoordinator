#
# Be sure to run `pod lib lint SceneCoordinator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SceneCoordinator'
  s.version          = '0.1.0'
  s.summary          = 'A convenient and simple way of navigating to and from ViewControllers
."'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A convenient and simple way of navigating to and from ViewControllers. 
  * Router
  * Coordinator
  * Scenes
                       DESC

  s.homepage         = 'https://github.com/hairui19/SceneCoordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'linhairui19@' => 'linhairui19@gmail.com' }
  s.source           = { :git => 'https://github.com/hairui19/SceneCoordinator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = "4.2"
  s.source_files = 'SceneCoordinator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SceneCoordinator' => ['SceneCoordinator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
