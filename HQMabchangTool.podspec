#
# Be sure to run `pod lib lint HQMabchangTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HQMabchangTool'
  s.version          = '0.1.5'
  s.summary          = '这是一个库，测试使用。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       这个是一个库的描述，调用直接pod就行了。测试使用
                       DESC

  s.homepage         = 'git@github.com:zhengdashi/HQMabchangTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhengdaqian' => '173977958@qq.com' }
  s.source           = { :git => 'git@github.com:zhengdashi/HQMabchangTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'

  s.source_files = 'HQMabchangTool/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HQMabchangTool' => ['HQMabchangTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
