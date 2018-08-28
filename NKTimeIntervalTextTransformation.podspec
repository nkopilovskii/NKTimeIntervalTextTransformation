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
  This framework provides the means for converting the numerical value of the time interval between two dates into a meaningful verbal form. Conversion occurs based on rules that are set by the user of the framework.
  
  The framework contains:
  -  structure `NKTextTimeIntervalConfiguration`, which contains rules for converting a numerical value to a string format, performs transformations based on the specified rules;
  -  `TimeInterval` extension that computes the number of time components in the specified interval in the form of `Double` (`Double` is used instead of `Int` with the purpose that the user of the framework can independently set the rules for rounding or forming a line for fractional values);
  - `Date` class, which, based on date comparisons, generates a string representation of a time interval according to specified rules.
                       DESC

  s.homepage         = 'https://github.com/nkopilovskii/NKTimeIntervalTextTransformation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nkopilovskii' => 'nkopilovskii@gmail.com' }
  s.source           = { :git => 'https://github.com/nkopilovskii/NKTimeIntervalTextTransformation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/MKopilovskii'

  s.ios.deployment_target = '10.0'
  s.swift_version  = '4.0'
  s.source_files = 'NKTimeIntervalTextTransformation/Classes/**/*'
  

end
