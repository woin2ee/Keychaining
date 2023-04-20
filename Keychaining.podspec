#
# Be sure to run `pod lib lint Keychaining.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Keychaining'
  s.version          = '0.8.0'
  s.summary          = 'Use keychain as a method chain pattern on iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  'A library that allows you to use keychains as a method chain pattern on iOS platform.'
                       DESC

  s.homepage         = 'https://github.com/woin2ee/Keychaining'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jaewon Yun' => 'woin2ee@gmail.com' }
  s.source           = { :git => 'https://github.com/woin2ee/Keychaining.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # `any` keyword is available since Swift 5.6
  # Required to use Swift 5.6 is macOS Monterey 12
  # macOS Monterey 12 supports iOS 12.4 and later.
  s.ios.deployment_target = '12.4'
  
  s.swift_versions = '5.7'

  s.source_files = 'Sources/*.swift'
  
  # s.resource_bundles = {
  #   'Keychaining' => ['Keychaining/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
