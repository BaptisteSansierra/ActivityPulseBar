#
#  Be sure to run `pod spec lint ActivityPulseBar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "ActivityPulseBar"
  spec.version      = "1.0"
  spec.summary      = "Vertical loading indicator.."

  spec.description  = <<-DESC
ActivityPulseBar is a sleek and minimal vertical loading indicator, designed to visually represent background activity or loading states...
                   DESC

  #spec.homepage     = "https://github.com/BaptisteSansierra/ActivityPulseBar.git"
  spec.homepage     = "git@github.com:BaptisteSansierra/ActivityPulseBar.git"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "Baptiste Sansierra" => "baptiste.sansierra@gmail.com" }
  spec.ios.deployment_target = '12.0'
  spec.swift_version = '5.0'
  #spec.source           = { :git => 'https://github.com/BaptisteSansierra/ActivityPulseBar.git', :tag => spec.version.to_s }
  spec.source           = { :git => 'git@github.com:BaptisteSansierra/ActivityPulseBar.git', :tag => spec.version.to_s }
  spec.source_files = 'ActivityPulseBar/*'
  spec.frameworks = 'UIKit'

end


