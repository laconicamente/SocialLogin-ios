Pod::Spec.new do |s|
  s.name             = 'SocialLogin'
  s.version          = '0.1.0'
  s.summary          = 'Social Login uses CloudRail SDK with the objective to ease authentications processes in services such Facebook, Instagram, Twitter, linkedIn, GooglePlus, Yahoo, GitHub, Slack, MicrosoftLive. Only the client ID and client secret are needed.'

  s.description      = <<-DESC
  Social Login uses CloudRail SDK with the objective to ease authentications processes in services such Facebook, Instagram, Twitter, linkedIn, GooglePlus, Yahoo, GitHub, Slack, MicrosoftLive. Only the client ID and client secret are needed.
DESC

  s.homepage         = 'https://github.com/CloudRail/SocialLogin'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Felipe Cesar' => 'felipe.cesar@cloudrail.com' }
  s.source           = { :git => 'https://github.com/CloudRail/SocialLogin.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/CloudRail'

  s.ios.deployment_target = '9.3'

  s.source_files = 'SocialLogin/Classes/**/*.{swift,m,h}'
  s.resource_bundles = {
    'SocialLogin' => ['SocialLogin/Classes/**/*.{storyboard,xib}','SocialLogin/Assets/**/*.{png,jpg,jpeg}']
  }

  s.frameworks = 'UIKit'
  s.dependency 'cloudrail-si-ios-sdk', '~> 3.2.4'
  s.dependency 'FoldingTabBar'


end
