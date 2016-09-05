//
//  LoginViewController.swift
//  Pods
//
//  Created by Felipe Cesar on 24/08/16.
//
//

import UIKit
import Foundation
import FoldingTabBar
import CloudrailSI

class LoginTabBarController: YALFoldingTabBarController, YALTabBarDelegate,UITabBarControllerDelegate{
  
  private var serviceName: Service? = nil

  // MARK - properties
  var setServices : [Int] = []
  var leftService : Int = -1
  var rightService : Int = -1
  
  var service : protocol<ProfileProtocol>? = nil // just for the moment
  var sideBarActivated : Bool = false;
  var usedServicesCount = 0
  
  var didAuthenticated : Bool? = nil
  
  var bundle : NSBundle {
    get{
      let podBundle = NSBundle(forClass: LoginTabBarController.self)
    //TODO: proper unwrapping
      let bundleURL = podBundle.URLForResource("SocialLogin", withExtension: "bundle")
      return  NSBundle(URL: bundleURL!)!
    }
  }
  
  // MARK: - ViewController Methods
  override public func viewDidLoad() {
      super.viewDidLoad()

      self.setupInitialBarIcons()
      self.setupInitialBarValues()
  }
  
  public override func viewDidAppear(animated: Bool) {
     self.setTabBarVisible(true, animated: true)
  }
  
  override public func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }

  class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
    return UINib(
      nibName: nibNamed,
      bundle: bundle
      ).instantiateWithOwner(nil, options: nil)[0] as? UIView
  }
  
  public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    print("touches began");
  }
  
  // MARK: - TabBar Delegate
   public func tabBar(tabBar: YALFoldingTabBar!, didSelectItemAtIndex index: UInt) {
  
  }
  
  public func tabBar(tabBar: YALFoldingTabBar!, shouldSelectItemAtIndex index: UInt) -> Bool {
    self.serviceName = SocialLoginController.sharedInstance.services[self.setServices[Int(index)]]
    self.tabBarView.state = YALTabBarState.Collapsed
    self.setTabBarVisible(false, animated: true);
    self.service = SocialLoginController.sharedInstance.servicesInstances[self.setServices[Int(index)]]
    self.triggerAuthentication()
    
    print("should select >> \(index)")

    
    return false // not switch tabBarIndex
  }
  
  public func tabBarWillCollapse(tabBar: YALFoldingTabBar!){}
  public func tabBarWillExpand(tabBar: YALFoldingTabBar!){}
  public func tabBarDidCollapse(tabBar: YALFoldingTabBar!){}
  public func tabBarDidExpand(tabBar: YALFoldingTabBar!){ }
  
  public func tabBarDidSelectExtraLeftItem(tabBar: YALFoldingTabBar!){
    self.setTabBarVisible(false, animated: true);
    self.service = SocialLoginController.sharedInstance.servicesInstances[0]
    self.triggerAuthentication()
    
  }
  
  public func tabBarDidSelectExtraRightItem(tabBar: YALFoldingTabBar!){
    self.setTabBarVisible(false, animated: true);
    self.service = SocialLoginController.sharedInstance.servicesInstances[1]
    self.triggerAuthentication()
  }

  // MARK: - TabBar Setup
  private func setupInitialBarIcons(){
    self.tabBarView.tabBarViewEdgeInsets = UIEdgeInsets(top: 0, left: -100, bottom: 0, right: -100)
    let tabBarController = self
    var numberOfItems = SocialLoginController.sharedInstance.numberOfServices
    
    //CASE SOLO
    if SocialLoginController.sharedInstance.numberOfServices == 1 {
      //TODO: make proper unwrapping
      tabBarController.centerButtonImage = UIImage(named: "facebook" , inBundle: bundle, compatibleWithTraitCollection: nil)!.imageByApplyingAlpha(0.0)
      let firstItem = YALTabBarItem(
        itemImage: UIImage(named: "plus", inBundle: bundle, compatibleWithTraitCollection: nil)!,
        //TODO: make proper unwrapping
        leftItemImage: UIImage(named: SocialLoginController.sharedInstance.services[0].name.lowercaseString , inBundle: bundle, compatibleWithTraitCollection: nil)!,
        rightItemImage: nil
      )
      tabBarController.leftBarItems = [firstItem]
      self.hideCenter()
      return
    }
    
    // CASE EVEN
    tabBarController.centerButtonImage = UIImage(named: "plus" , inBundle: bundle, compatibleWithTraitCollection: nil)!
    if SocialLoginController.sharedInstance.numberOfServices == 2 ||
    SocialLoginController.sharedInstance.numberOfServices == 4 {
      self.addRemainingToTabBar()
      return
    }
    
    //CASE ODD and above
    if SocialLoginController.sharedInstance.numberOfServices == 3 ||
      SocialLoginController.sharedInstance.numberOfServices >= 5{
      self.setupSideItems()
      self.addRemainingToTabBar()
      return
    }
  }
  
  private func setupInitialBarValues(){
    let tabBarController = self
    tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    
    
    if SocialLoginController.sharedInstance.numberOfServices != 1{
      tabBarController.tabBarView.backgroundColor = UIColor.color(255, green: 175, blue: 149, alpha: 0)
      tabBarController.tabBarView.tabBarColor = UIColor.color(255, green: 175, blue: 63, alpha: 1.0)
    }
    
    tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
    tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
  }

  
  //MARK - Helper methods
  private func setupSideItems(){
    let leftImage = UIImage(named: SocialLoginController.sharedInstance.services[0].name.lowercaseString , inBundle: bundle, compatibleWithTraitCollection: nil)!
    
    var rightImage: UIImage? = nil
    
    if SocialLoginController.sharedInstance.services.count > 5 {
      rightImage = UIImage(named: SocialLoginController.sharedInstance.services[1].name.lowercaseString , inBundle: bundle, compatibleWithTraitCollection: nil)!
      self.leftService = self.usedServicesCount
      self.usedServicesCount = self.usedServicesCount+1 // increment on more
    }
    
    let firstItem = YALTabBarItem(
      itemImage: UIImage(named: "plus", inBundle: bundle, compatibleWithTraitCollection: nil)!,
      leftItemImage: leftImage,
      rightItemImage: rightImage
    )
    
    self.leftBarItems = [firstItem]
    self.rightService = self.usedServicesCount
    self.usedServicesCount = self.usedServicesCount+1 //increment used ones
  }
  
  private func addRemainingToTabBar(){
    
    var leftItems : [AnyObject!]
    var rightItems : [AnyObject!]
    
    //first case
    if  self.usedServicesCount == 0 && SocialLoginController.sharedInstance.services.count < 4{
      
      let firstItem = YALTabBarItem(
        itemImage: UIImage(named: SocialLoginController.sharedInstance.services[0].name.lowercaseString , inBundle: bundle, compatibleWithTraitCollection: nil)!,
        leftItemImage: nil,
        rightItemImage: nil
      )
      self.leftBarItems = [firstItem]
      self.setServices.append(0)
      
      let secondItem = YALTabBarItem(
        itemImage: UIImage(named: SocialLoginController.sharedInstance.services[1].name.lowercaseString , inBundle: bundle, compatibleWithTraitCollection: nil)!,
        leftItemImage: nil,
        rightItemImage: nil
      )
      self.rightBarItems = [secondItem]
      self.setServices.append(1)
      
      return
    }
    
    var firstItemLeft : UIImage?
    var firstItemRight : UIImage?
    
    if let bar = self.leftBarItems {
      if let item = self.leftBarItems.first?.leftImage {
        firstItemLeft = item
      } else {
        firstItemLeft = nil
      }
      if let item = self.leftBarItems.first?.rightImage {
        firstItemRight = item
      } else {
        firstItemRight = nil
      }
    }
    
    while self.usedServicesCount !=  SocialLoginController.sharedInstance.services.count {
      
      let firstItem = YALTabBarItem(
        
        itemImage: UIImage(named: SocialLoginController.sharedInstance.services[self.usedServicesCount].name.lowercaseString , inBundle: bundle, compatibleWithTraitCollection: nil)!,
        leftItemImage: firstItemLeft,
        rightItemImage: firstItemRight
      )
      
      if firstItemLeft != nil || self.leftBarItems == nil  { // Unwrapping
        self.leftBarItems = [firstItem]
      }else {
        var hold = self.leftBarItems
        hold.append(firstItem)
        self.leftBarItems = hold
      }
      self.setServices.append(self.usedServicesCount)
      self.usedServicesCount = self.usedServicesCount+1 //increment used ones
      
      
      let secondItem = YALTabBarItem(
        itemImage: UIImage(named: SocialLoginController.sharedInstance.services[self.usedServicesCount].name.lowercaseString , inBundle: bundle, compatibleWithTraitCollection: nil)!,
        leftItemImage: nil,
        rightItemImage: nil
      )
      
      
      if self.rightBarItems != nil { // Unwrapping
        var hold = self.rightBarItems
        hold.append(secondItem)
        self.rightBarItems = hold
      } else {
        self.rightBarItems = [secondItem]
      }
      self.setServices.append(self.usedServicesCount)
      self.usedServicesCount = self.usedServicesCount+1 //increment used ones
      
      firstItemLeft = nil
      firstItemRight = nil
    }
    
  }

  func setTabBarVisible(visible:Bool, animated:Bool) {
    //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
    
    if (tabBarIsVisible() == visible) { return }

    let frame = self.tabBar.frame
    let height = frame.size.height
    let offsetY = (visible ? -height : height)
    
    // zero duration means no animation
    let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
    
    UIView.animateWithDuration(duration) {
      self.tabBar.frame = CGRectOffset(frame, 0, offsetY)
      return
    }
  }
  
  func tabBarIsVisible() ->Bool {
    return self.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
  }

  func hideCenter() ->Void {
    let frame = self.tabBar.frame
    let height = frame.size.height
    UIView.animateWithDuration(0) {
      self.tabBar.frame = CGRectOffset(frame, frame.size.width/2-40, 0)
      return
    }
  }
  
  private func triggerAuthentication(){
  
    var myService = self.service!
    
    var referenceKeep = UIApplication.sharedApplication().keyWindow!.rootViewController!
    UIApplication.sharedApplication().keyWindow!.rootViewController = self
   
    do{
      try self.service!.fullName()
    } catch let error {
      print("Catch error \(error)")
      SocialLoginController.sharedInstance.socialLoginDelegate?.socialLoginDidFailWithError(error)
      
    }
    
    var savedString: String?
    do{
      savedString = try self.service!.saveAsString()
    } catch let error {
      print("Catch error \(error)")
      SocialLoginController.sharedInstance.socialLoginDelegate?.socialLoginDidFailWithError(error)
      
    }
    UIApplication.sharedApplication().keyWindow!.rootViewController = referenceKeep
    
    self.parseSaveString(savedString!)
    
    self.dismissViewControllerAnimated(true, completion: nil)
  
  }

  func getTopViewController() -> UIViewController {
    var topViewController = UIApplication.sharedApplication().delegate!.window!!.rootViewController!
    while (topViewController.presentedViewController != nil) {
      topViewController = topViewController.presentedViewController!
    }
    return topViewController
  }

  
  private func parseSaveString(saveString:String){
    var accessToken  = ""
    var refreshToken = ""
    do {
      var json = try NSJSONSerialization.JSONObjectWithData(saveString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .MutableContainers)
      json = json[0]
      
      if let token = json["accessToken"] as? String {
        accessToken = token
      }
      if let token = json["oauthToken"] as? String {
        accessToken = token
      }
      
      if let token = json["refreshToken"] as? String {
        refreshToken = token
      }
      if let token = json["oauthTokenSecret"] as? String {
        refreshToken = token
      }
    } catch {
      print("error serializing JSON: \(error)")
      SocialLoginController.sharedInstance.socialLoginDelegate?.socialLoginDidFailWithError(error)
    }
    
    SocialLoginController.sharedInstance.socialLoginDelegate?.socialLoginDidAuthenticatedWithService(self.serviceName!, accessToken: accessToken, refreshToken: refreshToken, rawState: saveString)
    
  }
}

extension UIImage {
  
  
  func imageByApplyingAlpha(_ alpha: CGFloat) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
    
    var ctx = UIGraphicsGetCurrentContext()!;
    var area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, .Multiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    var newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
  }
  
}

extension UIColor {
  static func color(red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
    return UIColor(
      colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
      green: Float(1.0) / Float(255.0) * Float(green),
      blue: Float(1.0) / Float(255.0) * Float(blue),
      alpha: alpha)
  }
}