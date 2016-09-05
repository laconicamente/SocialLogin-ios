//
//  SocialLogin.swift
//  Pods
//
//  Created by Felipe Cesar on 25/08/16.
//
//

import UIKit
import CloudrailSI

private let navigationID = "navigation"
private let tabBarID = "tabbar"
private let storyboardName = "SocialLogin"

public protocol SocialLoginDelegate {
  
  func socialLoginDidAuthenticatedWithService(service:Service , accessToken: String, refreshToken:String, rawState:String)
  func socialLoginShouldDismissAfterLoginbutton()->Bool
  func socialLoginViewDidPressLoginButtonWith(username:String?, password:String?)
  func socialLoginDidFailWithError(error:ErrorType)
}

extension SocialLoginDelegate{
  func socialLoginDidFailWithError(error:ErrorType){}
  func socialLoginViewDidPressLoginButtonWith(username:String?, password:String?){}
  func socialLoginShouldDismissAfterLoginbutton()->Bool{ return true}
}

public class SocialLogin: NSObject {
  
  public static var shouldPresentNativeLogin : Bool = false
  public static var delegate : SocialLoginDelegate? = nil
  
  //MARK - Public Methods
  public static func addServiceNamed(_ serviceName: String , clientID:String, clientSecret: String){
    let service = Service(name: serviceName, clientID: clientID, clientSecret: clientSecret)
    SocialLogin.addService(service)
  }
  
  public static func addService(_ service:Service){
    SocialLoginController.sharedInstance.addService(service)
  }
  
  //MARK - start use case
  public static func performSegueToSocialLoginVC(caller: UIViewController) {
    
    // setting the delegate
    
    SocialLoginController.sharedInstance.socialLoginDelegate = self.delegate
    
    //loading storyboard and its initial VC
    let podBundle = NSBundle(forClass: LoginTabBarController.self)
    let bundleURL = podBundle.URLForResource("SocialLogin", withExtension: "bundle")
    let bundle = NSBundle(URL: bundleURL!)!
    let storyboard = UIStoryboard(name: "SocialLogin", bundle: bundle)
    
    
  
    var viewController : UIViewController? = nil;
    
    if self.shouldPresentNativeLogin == false {
      viewController = storyboard.instantiateViewControllerWithIdentifier(navigationID)
    }else{
      viewController = storyboard.instantiateInitialViewController()! //as! UINavigationController
    }
    
    
    let transition = CATransition()
    transition.duration = 0.5
    transition.type = kCATransitionFade
    transition.subtype = kCATransitionFromBottom
    caller.view.window?.layer .addAnimation(transition, forKey: kCATransition)
    
    caller.presentViewController(viewController!, animated: false, completion: nil)
//    SocialLoginController.sharedInstance.socialLoginDelegate = nil

    //clearing cache
//    for cookie in NSHTTPCookieStorage .sharedHTTPCookieStorage().cookies! {
//      NSHTTPCookieStorage .sharedHTTPCookieStorage().deleteCookie(cookie)
//    }
  }
}

// MARK - Service Structure
public struct Service {
  var name : String
  var clientID : String
  var clientSecret : String
}

public enum ServiceName : String {
  case Facebook = "facebook",
  Twitter = "twitter",
  GooglePlus = "googleplus",
  Slack = "slack",
  Yahoo = "yahoo",
  MicrosoftLive = "microsoftlive",
  Instagram = "instagram",
  GitHub = "github",
  LinkedIn = "linkedin"
}

