
import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class IntroViewController: UIViewController {

    @IBAction func startButtonDidTouch(sender: AnyObject) {
        let readPermissions = ["public_profile", "email"];
        let ref = Firebase(url: "https://incandescent-inferno-9043.firebaseio.com");
        let facebookLogin = FBSDKLoginManager();
        facebookLogin .logInWithReadPermissions(readPermissions, fromViewController: self) { (result, error) -> Void in
            if ((error) != nil) {
                print("Facebook login failed");
            } else if (result.isCancelled) {
                print("Facebook login cancelled");
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString;
                ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { (error, authData) -> Void in
                    if ((error) != nil) {
                        print("Login failed.");
                    } else {
                        print("Logged in!");
                        let cachedUserProfile = authData.providerData["cachedUserProfile"] as! [NSObject: AnyObject];
                        let newUser =
                            [
                                "provider": authData.provider,
                                "provider_id": authData.providerData["id"] as? NSString as? String,
                                "display_name": authData.providerData["displayName"] as? NSString as? String,
                                "first_name": cachedUserProfile["first_name"] as? NSString as? String,
                                "last_name": cachedUserProfile["last_name"] as? NSString as? String,
                                "email": authData.providerData["email"] as? NSString as? String,
                                "profile_image_url": authData.providerData["profileImageURL"] as? NSString as? String
                                
                            ];
                    ref.childByAppendingPath("users").childByAppendingPath(authData.uid).setValue(newUser, withCompletionBlock: { (error, ref) -> Void in
                            self.pushChannelStreamVC(true);
                        })
                    }
                });
            }
        }
    }
    @IBOutlet weak var getStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartButton.setAttributedTitle(NSAttributedString(string: "Login with Facebook".uppercaseString, attributes:  NSDictionary.callToActionButtonAttributes(UIColor.colorEpicWhite())), forState: .Normal)
        let ref = Firebase(url: "https://incandescent-inferno-9043.firebaseio.com");
        if (ref.authData != nil) {
            self.pushChannelStreamVC(false);
        }
    }
    
    func pushChannelStreamVC(animated: Bool) {
//        let streamVC = ChannelStreamViewController();
        let streamVC = UIStoryboard(name: "imageChannel", bundle: nil).instantiateInitialViewController();
        self.navigationController?.pushViewController(streamVC!, animated: animated);
    }

}

