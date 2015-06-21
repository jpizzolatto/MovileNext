source 'https://github.com/CocoaPods/Specs'

platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

target 'MovileNext', :exclusive => true do
	pod 'Alamofire'
	pod 'Argo'
	pod 'Result'
	pod 'TraktModels', :git => 'https://github.com/marcelofabri/TraktModels.git'
	pod 'HanekeSwift', :git => 'https://github.com/Haneke/HanekeSwift'
end

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  
  pod 'Nimble'
  pod 'OHHTTPStubs'
end

