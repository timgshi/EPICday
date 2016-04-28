import UIKit

class loadingViewController: UIViewController {
    
    @IBOutlet weak var animationView: EPICLoadingAnimationView!
    override func viewWillAppear(animated: Bool) {
        animationView.addStartAnimationCompletionBlock({
            (value : Bool) in
            self.animationView.addLoadingAnimationCompletionBlock({
                (value :Bool) in
                
                self.animationView.addEndAnimationCompletionBlock({
                    (value :Bool) in
                    self.performSegueWithIdentifier("segueToMainView", sender: self)
                })
                
            })
        })
    }
    
}