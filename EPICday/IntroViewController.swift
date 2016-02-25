
import UIKit

class IntroViewController: UIViewController {

    @IBAction func startButtonDidTouch(sender: AnyObject) {
    }
    @IBOutlet weak var getStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartButton.setAttributedTitle(NSAttributedString(string: "Login with Facebook".uppercaseString, attributes:  NSDictionary.callToActionButtonAttributes(UIColor.colorEpicWhite())), forState: .Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

