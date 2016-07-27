#
# Be sure to run `pod lib lint ParallexBanner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ParallexBanner'
  s.version          = '0.1.0'
  s.summary          = 'A banner to show images with parallex effect'
  s.description      = <<-DESC
This is a banner to show images with parallex effect.It support both local and Web Image.
                       DESC

  s.homepage         = 'https://github.com/LeoMobileDeveloper/ParallexBanner'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leo' => 'leomobiledeveloper@gmail.com' }
  s.source           = { :git => 'https://github.com/LeoMobileDeveloper/ParallexBanner.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ParallexBanner/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'Kingfisher'
end
