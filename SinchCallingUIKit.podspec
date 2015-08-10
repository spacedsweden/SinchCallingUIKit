#
# Be sure to run `pod lib lint SinchCallingUIKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SinchCallingUIKit"
  s.version          = "0.1.10"
  s.summary          = "A UI framework to help you build calling apps super quick"
  s.description      = "Use this add calling to your app in minutes, includes a ios8 like calling screen to help you build quick prototypes."
s.homepage         = "https://github.com/spacedsweden/SinchCallingUIKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "d" => "christian@sinch.com" }
  s.source           = { :git => "https://github.com/sinch/SinchCallingUIKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/sinchdev'

  s.platform     = :ios, '8.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
'SinchCallingUIKit' => ['Pod/Resources/**/*.{png,wav,xib}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SinchRTC'
  s.dependency 'SinchService'

end
