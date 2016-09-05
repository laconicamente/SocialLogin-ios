//
//  ServicesTableViewController.swift
//  Pods
//
//  Created by Felipe Cesar on 01/09/16.
//
//

import UIKit
import CloudrailSI

class ServicesTableViewController: UITableViewController {
  public var service : protocol<ProfileProtocol>?
  private var serviceName: Service? = nil
  var bundle : NSBundle {
    get{
      let podBundle = NSBundle(forClass: LoginTabBarController.self)
      //TODO: proper unwrapping
      let bundleURL = podBundle.URLForResource("SocialLogin", withExtension: "bundle")
      return  NSBundle(URL: bundleURL!)!
    }
  }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SocialLoginController.sharedInstance.servicesInstances.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! ServiceCell
      var imageName = SocialLoginController.sharedInstance.services[indexPath.row].name + "-b"
      cell.serviceImage.image = UIImage(named: imageName, inBundle:bundle, compatibleWithTraitCollection: nil)
      
      return cell
    }
 

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.service = SocialLoginController.sharedInstance.servicesInstances[indexPath.row]
    self.serviceName = SocialLoginController.sharedInstance.services[indexPath.row]
    var serviceID = SocialLoginController.sharedInstance.services[indexPath.row].clientID
    var serviceSecret = SocialLoginController.sharedInstance.services[indexPath.row].clientSecret
    self.triggerAuthentication()
  }
  
  
  private func triggerAuthentication(){
    
    
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      // do some task
      // update some UI
      
      var viewController : UIViewController? = nil;
      
      if let referenceKeep = UIApplication.sharedApplication().keyWindow!.rootViewController  {
      
        viewController = referenceKeep
      
      }
      
      UIApplication.sharedApplication().keyWindow!.rootViewController = self.navigationController
      
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
      
      UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
      
      self.parseSaveString(savedString!)

      self.dismissViewControllerAnimated(true, completion: nil)
    }
    
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
