#
#  Be sure to run `pod spec lint HETSleepFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.name = "HETSleepFramework"
    s.version = "0.0.5"
    s.summary = "H&T开放平台SDK"
    s.ios.deployment_target = '8.0'
    s.homepage     = "https://github.com/C-Life/HETOpenSDK-for-iOS"
    s.license      = 'Apache License, Version 2.0'
    s.author       = { "Justin Yang" => "ityangjing@gmail.com" }
    s.source       = { :git => "https://github.com/C-Life/HETKunYuanDemo.git", :commit => "__GITVersion__"}
    s.requires_arc = true
    s.default_subspecs = 'HETSleepFramework'

    # 核心模块
#    s.subspec 'HETSleepFramework' do |sp|
#       sp.vendored_frameworks = 'HETSleepFramework/SDK/HETOpenSleepCoreSDK.framework'
#    end

   

    # HETOpenSleepCoreSDK
    s.subspec 'HETOpenSleepCoreSDK' do |sp|
        sp.vendored_frameworks = 'HETSleepFramework/SDK/HETOpenSleepCoreSDK.framework'
        #sp.resources = 'HETSleepFramework/SDK/HETOpenSleepCoreSDK.framework/*.{plist,car,nib,strings,storyboardc,momd}'
        #sp.resource_bundles = {
        #'HETOpenSleepCoreSDK' => ['HETSleepFramework/SDK/HETOpenSleepCoreSDK.framework/*.{plist,car,nib,strings,storyboardc,momd}'],
        #}

        sp.resource = 'HETSleepFramework/SDK/HETOpenSleepCoreSDK.bundle'
    end
    
    s.subspec 'HETBindSDK' do |sp|
        sp.vendored_frameworks = 'HETSleepFramework/SDK/HETBindSDK.framework'

        sp.resource = 'HETSleepFramework/SDK/HETBindSDK.bundle'
    end
    
    s.subspec 'HETDeviceDetailSDK' do |sp|
        sp.vendored_frameworks = 'HETSleepFramework/SDK/HETDeviceDetailSDK.framework'

        sp.resource = 'HETSleepFramework/SDK/HETDeviceDetailSDK.bundle'
    end

    s.subspec 'HETDeviceListSDK' do |sp|
        sp.vendored_frameworks = 'HETSleepFramework/SDK/HETDeviceListSDK.framework'
        sp.resource = 'HETSleepFramework/SDK/HETDeviceListSDK.bundle'
    end

    s.subspec 'HETSleepReportSDK' do |sp|
        sp.vendored_frameworks = 'HETSleepFramework/SDK/HETSleepReportSDK.framework'
        sp.resource = 'HETSleepFramework/SDK/HETSleepReportSDK.bundle'
    end

    s.subspec 'HETAirConditionBoxSDK' do |sp|
        sp.vendored_frameworks = 'HETSleepFramework/SDK/HETAirConditionBoxSDK.framework'
        sp.resource = 'HETSleepFramework/SDK/HETAirConditionBoxSDK.bundle'
    end
end
