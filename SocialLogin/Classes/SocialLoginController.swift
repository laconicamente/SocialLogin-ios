//
//  SocialLoginController.swift
//  Pods
//
//  Created by Felipe Cesar on 26/08/16.
//
//

import UIKit
import CloudrailSI

private let sharedController = SocialLoginController()
private let maxServices = 3
private let redirectURI = "https://www.cloudrailauth.com/auth"
private let state = "STATE"


class SocialLoginController {
  
  let notificationKey = "com.sociallogin.notification"
  var socialLoginDelegate : SocialLoginDelegate? = nil;
  var logoImage : UIImage? = nil
  var services : [Service] = []
  var servicesInstances : [protocol<ProfileProtocol>] = []
  var numberOfServices: Int  { get {
    return self.servicesInstances.count
    }
  }

  //computed class var - SINGLETON
  class var sharedInstance : SocialLoginController {
    return sharedController
  }
  
  public func addService(_ service: Service) {
    self.services.append(service)
    self.servicesInstances.append(ServiceInstanceFactory.serviceClassForService(service))

  }
  
}

class ServiceInstanceFactory{
  
  static func serviceClassForService(service: Service) -> protocol<ProfileProtocol>{
    var profileProtocol : protocol<ProfileProtocol>?
    
    
    switch service.name.lowercaseString {
    case "facebook":
      profileProtocol = Facebook(clientID: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    case "twitter":
      profileProtocol = Twitter(clientID: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI)
      break
    case "googleplus":
      profileProtocol = GooglePlus(clientID: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    case "slack":
      profileProtocol = Slack(clientId: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    case "yahoo":
      profileProtocol = Yahoo(clientId: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    case "microsoftlive":
      profileProtocol = MicrosoftLive(clientID: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    case "instagram":
      profileProtocol = Instagram(clientID: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    case "github":
      profileProtocol = GitHub(clientId: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    case "linkedin":
      profileProtocol = LinkedIn(clientID: service.clientID, clientSecret: service.clientSecret, redirectUri: redirectURI, state: state)
      break
    default:
      break
    }
    return profileProtocol!
  }
  
}