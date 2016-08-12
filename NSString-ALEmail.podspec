#
# Be sure to run `pod lib lint NSString-ALEmail.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NSString-ALEmail'
  s.version          = '0.1.0'
  s.summary          = 'NSString-ALEmail: A basic regex e-mail validation and disposable email detection extension/category for String/NSString classes.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Simple pod which combines following work:

	Please check for disposable list source
		https://gist.github.com/michenriksen/8710649
		https://github.com/wesbos/burner-email-providers
		https://gist.github.com/adamloving/4401361

	Please check for implementation of disposable detection
		https://github.com/FGRibreau/mailchecker
                       DESC

  s.homepage         = 'https://github.com/aligermiyanoglu/NSStringALEmail'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aligermiyanoglu' => 'anibal23736@hotmail.com' }
  s.source           = { :git => 'https://github.com/aligermiyanoglu/NSStringALEmail.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NSString-ALEmail/Classes/**/*'
  
  s.resource_bundles = {
  		'NSString-ALEmail' => ['NSString-ALEmail/Assets/*.txt']
	}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
