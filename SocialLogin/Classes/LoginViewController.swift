//
//  LoginViewController.swift
//  Pods
//
//  Created by Felipe Cesar on 25/08/16.
//
//

import UIKit
import CloudrailSI

class LoginViewController: UIViewController {
  
  public var service : protocol<ProfileProtocol>?
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var userNameTextView: UITextField!
  @IBOutlet weak var logoImageView: UIImageView!
  
  @IBAction func loginButtonPressed(sender: AnyObject) {
    SocialLoginController.sharedInstance.socialLoginDelegate?.socialLoginViewDidPressLoginButtonWith(passwordTextField.text, password:userNameTextView.text)
    
    if SocialLoginController.sharedInstance.socialLoginDelegate?.socialLoginShouldDismissAfterLoginbutton()==true {
      self.tabBarController?.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
    
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.userNameTextView.endEditing(true)
    self.passwordTextField.endEditing(true)
  }

  
  override func viewDidAppear(animated: Bool) {
    
  }
  
}
