Pod::Spec.new do |spec|

  spec.name         = "VMaxAdSdks"
  spec.version      = "0.0.35"
  spec.summary      = "Static Library for VMaxAdSdks"
  spec.description  = "Static Library for VMaxAdSdks. Its build in Objective C"
  spec.homepage     = "https://github.com/SiddhantVmax/VMaxAdSdks"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "Siddhant Nigam" => "siddhant.n@vserv.com" }
  spec.source       = { :http => "https://github.com/SiddhantVmax/VMaxAdSdks/archive/0.0.35.zip", }
  spec.platform     = :ios, "8.0"
  spec.source_files  = "VMaxAdSdks-0.0.35/VMaxAdSDK/include/*.{h,m}"
  spec.vendored_libraries = "VMaxAdSdks-0.0.35/VMaxAdSDK/lib/*.a"
  #spec.source_files  = "VMaxAdSdks-0.0.35/VMaxAdSDK/lib/*",  "VMaxAdSdks-0.0.35/VMaxAdSDK/include/*"
  ##spec.pod_target_xcconfig = {
  ##  'OTHER_LDFLAGS' => '$(inherited) -ObjC -lxml2 -fobjc-arc -lstdc++'
  ##}
  #spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64 armv7 ' }
  #spec.xcconfig = {'ARCHS' => 'i386 armv7 armv7s', 'VALID_ARCHS' => 'i386 x86_64 armv7 armv7s'}
  #spec.source_files  = "VMaxAdSDK/lib/*",  "VMaxAdSDK/include/*"
 
end


