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
  s.summary          = 'A short description of ParallexBanner.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/ParallexBanner'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leo' => 'leomobiledeveloper@gmail.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/ParallexBanner.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ParallexBanner/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'Kingfisher'
end
