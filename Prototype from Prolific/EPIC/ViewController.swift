
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let page:CGFloat = 3
    
    var parallaxLeadingConstraints = [NSLayoutConstraint]()
    var parallaxTopConstraints = [NSLayoutConstraint]()
    
    var scrollView:UIScrollView {
        return view as! UIScrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for constraint in view.constraints {
            if constraint.firstAttribute == .Leading {
                parallaxLeadingConstraints.append(constraint)
            }else if constraint.firstAttribute == .Top {
                parallaxTopConstraints.append(constraint)
            }
        }
        //        scrollView.alwaysBounceVertical = true
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.frame.width * page, height: scrollView.frame.height)
        for view in scrollView.subviews {
            //            view.registerMotionEffectWithDept(10 * (view.frame.width / scrollView.frame.width))
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       // scrollView.contentOffset.x = -scrollView.frame.width
        
//        UIView.animateWithDuration(1.2, delay: 0, options: .CurveEaseInOut, animations: {
//            self.scrollView.contentOffset.x = 0
//            self.updateHorizontalParallaxScrollView(self.scrollView)
//            }, completion: { finished in
//                
//        })
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHorizontalParallaxScrollView(scrollView)
    }
    
    func updateHorizontalParallaxScrollView(scrollView: UIScrollView) {
        let baseMidOffsetX = scrollView.frame.midX + scrollView.contentOffset.x
        for constraint in parallaxLeadingConstraints {
            if let parallaxView = constraint.firstItem as? UIView {
                let aspectViewMidOffsetX = baseMidOffsetX * (parallaxView.frame.width  / scrollView.contentSize.width)
                let offsetX = aspectViewMidOffsetX  - scrollView.frame.midX
                constraint.constant = scrollView.contentOffset.x  - offsetX
            }
        }
        for constraint in parallaxTopConstraints {
            if let parallaxView = constraint.firstItem as? UIView {
                constraint.constant = scrollView.contentOffset.y - (0.2 *  scrollView.contentOffset.y * (parallaxView.frame.width  / scrollView.contentSize.width))
            }
        }
    }
}


