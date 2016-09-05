//
//  ViewController.swift
//  SocialLogin
//
//  Created by Felipe Cesar on 08/24/2016.
//  Copyright (c) 2016 Felipe Cesar. All rights reserved.
//

import UIKit
import SocialLogin

class ViewController: UIViewController, SocialLoginDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    
    SocialLogin.addServiceNamed("Facebook", clientID:"258109087879382", clientSecret: "15bc563714a50f5d04270dbb3aace301")
    SocialLogin.addServiceNamed("Linkedin", clientID:"258109087879382", clientSecret: "15bc563714a50f5d04270dbb3aace301")
    SocialLogin.addServiceNamed("MicrosoftLive", clientID:"258109087879382", clientSecret: "15bc563714a50f5d04270dbb3aace301")
    SocialLogin.addServiceNamed("Yahoo", clientID:"258109087879382", clientSecret: "15bc563714a50f5d04270dbb3aace301")
    SocialLogin.addServiceNamed("instagram", clientID:"258109087879382", clientSecret: "15bc563714a50f5d04270dbb3aace301")

    SocialLogin.addServiceNamed("Twitter", clientID: "cv7AjsB3dGd9kNwP8WTKMIROs", clientSecret: "YecLEn7vaEbgKiagx2xzEAAkfYgfesWu7dtQ31EcrAMxiVa01T")
    SocialLogin.shouldPresentNativeLogin = true
    SocialLogin.delegate = self
    SocialLogin.performSegueToSocialLoginVC(self);
    
    
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func socialLoginDidAuthenticatedWithService(service:Service , accessToken: String, refreshToken:String, rawState:String){
  
    print("TOKENS PRINT", accessToken, "---", refreshToken, rawState)
    
  }
  
  
  func socialLoginDidFailWithError(error:ErrorType){
    print("Error callback", error)
  }
  
  func socialLoginViewDidPressLoginButtonWith(username:String?, password:String?){
    print("pressed", username, password)
  }
  func socialLoginShouldDismissAfterLoginbutton()->Bool{
    return false
  }

}
