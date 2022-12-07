#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fijkplayer_ijkfix.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fijkplayer_ijkfix'
  s.version          = '0.0.3'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://github.com/befovy/fijkplayer'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'wf990051004' => 'wf990051004@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  #s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  s.static_framework = true

  # @ uncomment next 3 lines to debug or use your custom ijkplayer build
  # 去除下面 3 行代码开头的注释 #，以便于进行调试或者使用自定义构建的 ijkplayer 产物 //IJKMediaPlayer
  s.preserve_paths = 'Frameworks/*.framework'
  s.vendored_frameworks = 'Frameworks/IJKMediaPlayer.framework'
  s.xcconfig = { 'LD_RUNPATH_SEARCH_PATHS' => '"$(PODS_ROOT)/Frameworks/"' }

  s.libraries = "bz2", "z", "stdc++"
  s.dependency 'Flutter'

  # s.use_frameworks!

  #s.dependency 'BIJKPlayer', '~> 0.7.16'

  s.ios.deployment_target = '8.0'
end
