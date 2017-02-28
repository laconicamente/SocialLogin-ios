Pod::Spec.new do |s|
  s.name             = 'SocialLogin'
  s.version          = '0.1.1'
  s.summary          = 'Social Login uses CloudRail SDK with the objective to ease authentications processes'

  s.description      = <<-DESC
  Social Login uses CloudRail SDK with the objective to ease authentications processes in services such Facebook, Instagram, Twitter, linkedIn, GooglePlus, Yahoo, GitHub, Slack, MicrosoftLive. Only the client ID and client secret are needed.
DESC

  s.homepage         = 'https://github.com/CloudRail/SocialLogin-ios'
   s.screenshots     = 'https://s14.postimg.io/fh4su5bap/Simulator_Screen_Shot_06_Sep_2016_15_23_28.png', 'https://s14.postimg.io/58cbobn8x/Simulator_Screen_Shot_06_Sep_2016_15_23_51.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Felipe Cesar' => 'felipe.cesar@cloudrail.com' }
  s.source           = { :git => 'https://github.com/CloudRail/SocialLogin-ios.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/CloudRail'

  s.ios.deployment_target = '9.3'

  s.source_files = 'SocialLogin/Classes/**/*.{swift,m,h}'
  s.resource_bundles = {
    'SocialLogin' => ['SocialLogin/Classes/**/*.{storyboard,xib}','SocialLogin/Assets/**/*.{png,jpg,jpeg}']
  }

  s.frameworks = 'UIKit'
  s.dependency 'cloudrail-si-ios-sdk', '~> 5.4.4'
  s.dependency 'FoldingTabBar'


end
