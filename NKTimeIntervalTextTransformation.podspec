#
# Be sure to run `pod lib lint NKTimeIntervalTextTransformation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NKTimeIntervalTextTransformation'
  s.version          = '0.1.0'
  s.summary          = 'Transformation TimeInterval between dates with customization of the declination rules'

  s.description      = <<-DESC
The framework is represented by an extension of class Date using public configuration structure of NKTextTimeIntervalConfiguration which defines the output format of a time interval in a meaningful text format with given rules for declining numeric
                       DESC

  s.homepage         = 'https://github.com/nkopilovskii/NKTimeIntervalTextTransformation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nkopilovskii' => 'nikolay.k@powercode.us' }
  s.source           = { :git => 'https://github.com/nkopilovskii/NKTimeIntervalTextTransformation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/MKopilovskii'

  s.ios.deployment_target = '10.0'
  s.swift_version  = '4.0'
  s.source_files = 'NKTimeIntervalTextTransformation/Classes/**/*'
  

end
