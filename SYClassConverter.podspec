Pod::Spec.new do |s|
  s.name         = "SYClassConverter"
  s.version      = "0.0.1"
  s.summary      = "the conversion from one class into another one"
  s.description  = <<-DESC
			*current progress:the conversion from dictionary into a class
                   DESC
  s.homepage     = "https://github.com/satyso/SYClassConverter"
  s.author             = { "satyso" => "song4@163.com" }
  s.social_media_url = "http://weibo.com/u/1844979955/home"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/satyso/SYClassConverter.git", :tag => "0.0.1" }
  s.source_files  = 'SYClassConverter/**/*.{h,m}'
  s.frameworks = 'Foundation'
  s.requires_arc = true

  # s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  # s.dependency 'JSONKit', '~> 1.4'

end
