# SocialLogin

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. Then open the `.xcworkspace` file inside the example directory. Build and run the project.

## Installation

SocialLogin is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile, remember to add it to a specific target:

```ruby
pod "SocialLogin"
```

## Usage

You can add up to six services, listed here (link). On the view controller that you wish to perform the seguie to the `SocialLoginViewController`, add services using the respective enum `ServiceName`  , `clientID` and `clientSecret`. These values can be found on the developers console of each service. You can use this excellent [post](https://coursetro.com/posts/code/13/The-Ultimate-Guide-To-Social-Login-In-Android-Using-CloudRail) as a reference for getting all the necessary values.

````Swift
SocialLogin.addServiceNamed("Facebook", clientID:"CLIENT_ID", clientSecret: "CLIENT_SECRET")
SocialLogin.addServiceNamed("Linkedin", clientID:"CLIENT_ID", clientSecret: "CLIENT_SECRET")
SocialLogin.addServiceNamed("MicrosoftLive", clientID:"CLIENT_ID", clientSecret: "CLIENT_SECRET")
SocialLogin.addServiceNamed("Yahoo", clientID:"CLIENT_ID", clientSecret: "CLIENT_SECRET")
SocialLogin.addServiceNamed("Instagram", clientID:"CLIENT_ID", clientSecret: "CLIENT_SECRET")
SocialLogin.addServiceNamed("Twitter", clientID: "CLIENT_ID", clientSecret: "CLIENT_SECRET")

SocialLogin.performSegueToSocialLoginVC(self);// perform the segue

````

### Only Services

In case you dont want to implement a native login feature using the pod, you can set the `shouldPresentNativeLogin` to `false`
````Swift
SocialLogin.shouldPresentNativeLogin = false
SocialLogin.performSegueToSocialLoginVC(self);// perform the segue
````
### With Username and Password

In case you dont want to implement a native login feature using the pod, you can set the `shouldPresentNativeLogin` to `false`
````Swift
SocialLogin.shouldPresentNativeLogin = true // default
SocialLogin.performSegueToSocialLoginVC(self);// perform the segue
````

## Delegate

To actually get the maximum of the pod benefits its necessary to implement the `SocialLoginDelegate` and set it *before* performing the segue.

````Swift
class ViewController: UIViewController, SocialLoginDelegate { /* class code*/}
````
````Swift
SocialLogin.delegate = self
SocialLogin.performSegueToSocialLoginVC(self);
````

To get the accessToken you need to implement the delegate method:

````Swift
func socialLoginDidAuthenticatedWithService(service:Service , accessToken: String, refreshToken:String, rawState:String)
````
The Pod also provides other optional delegaete methods:

````Swift
public protocol SocialLoginDelegate {

func socialLoginDidAuthenticatedWithService(service:Service , accessToken: String, refreshToken:String, rawState:String)
func socialLoginShouldDismissAfterLoginbutton()->Bool
func socialLoginViewDidPressLoginButtonWith(username:String?, password:String?)
func socialLoginDidFailWithError(error:ErrorType)
}
````
##  Services List
* Facebook
* Twitter
* GitHub
* Google Plus
* Instagram
* LinkedIn
* Microsoft Live
* Slack
* Yahoo

## Author
CloudRail, support@cloudrail.com
## License
SocialLogin is available under the MIT license. See the LICENSE file for more info.
