
import UIKit

class PresentationViewController: UIViewController {

    @IBOutlet weak var parallaxView: ParallaxView!
    @IBAction func startButtonDidTouch(sender: AnyObject) {
        
//        self.getStartButton.animate()
        
        UIView.animateWithDuration(0.1, delay: 0, options:UIViewAnimationOptions.CurveEaseIn, animations: {
            self.buttonBottomConstraint.constant = -self.getStartButton.frame.height
            self.view.layoutIfNeeded()
            self.parallaxView.alpha = 0
            }, completion: {
                
                (value : Bool) in
                
                self.performSegueWithIdentifier("segueToLoading", sender: self)
                
                
        
        })
        
    }
    @IBOutlet weak var animationLoadLogoView: animateLogoView!
    @IBOutlet weak var getStartButton: SpringButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var overlayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartButton.setAttributedTitle(NSAttributedString(string: "Login with Facebook".uppercaseString, attributes:  NSDictionary.callToActionButtonAttributes(UIColor.colorEpicWhite())), forState: .Normal)

    }
    override func viewWillAppear(animated: Bool) {
        animationLoadLogoView.addIntroAnimationCompletionBlock({
            (void : Bool) in
            UIView.animateWithDuration(1, animations: {
            self.overlayView.alpha = 0
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


