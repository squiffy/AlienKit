#
# Be sure to run `pod lib lint AlienKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "AlienKit"
  s.version          = "0.1.0"
  s.summary          = "Swift API for Reddit"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        Heres a swift API for reddit. The few API wrappers that
                        exist did not satisfy my needs. This is here to remedy that.
                       DESC

  s.homepage         = "https://github.com/squiffy/AlienKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "squiffy" => "squiffypwn@gmail.com" }
  s.source           = { :git => "https://github.com/squiffy/AlienKit.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'AlienKit' => ['Pod/Assets/*.png']
  }

  s.dependency 'Alamofire', '~> 3.0'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
