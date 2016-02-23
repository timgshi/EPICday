
import UIKit
import CoreMotion

public func limit<T : Comparable>(x:T, _ minValue: T, _ maxValue: T) -> T {
    return min(maxValue, max(minValue,x))
}


class ParallaxView: UIView,UIScrollViewDelegate {
    
    // subviews
    
    let motionManager = ParallaxMotionManager()
    
    private var parallaxOffset = UIOffsetZero
    
    private var scrollView: UIScrollView!
    
    @IBOutlet
    private var indicatorLabel: CharPageControl!
    
    let pages: CGFloat = 3
    var parallaxLeadingConstraints = [NSLayoutConstraint]()
    var parallaxTopConstraints  = [NSLayoutConstraint]()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews () {
        scrollView = NSBundle.mainBundle().loadNibNamed("ParallaxView", owner: self, options: [:]).first as! UIScrollView
        
        insertSubview(scrollView, atIndex: 0)
        
        
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        // Drawing code
        scrollView.frame = CGRect(origin: CGPointZero, size: frame.size)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([NSLayoutAttribute.Top,NSLayoutAttribute.Bottom,NSLayoutAttribute.Leading,NSLayoutAttribute.Trailing].map{
            return NSLayoutConstraint(item: scrollView,
                attribute: $0,
                relatedBy: .Equal,
                toItem: self,
                attribute: $0,
                multiplier: 1.0,
                constant: 0.0)
            })
        
        indicatorLabel.numberOfPages = pages
        indicatorLabel.currentPage = 0
        
        parallaxLeadingConstraints.removeAll()
        for constraint in scrollView.constraints {
            if constraint.firstAttribute == .Leading {
                parallaxLeadingConstraints.append(constraint)
            }else if constraint.firstAttribute == .Top {
                parallaxTopConstraints.append(constraint)
            }
        }
        
        // change to true will make a gesture parallax
        scrollView.alwaysBounceVertical = false
        
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: rect.width * pages, height: rect.height)
        
        
        scrollView.contentOffset.x = -frame.width
        layoutIfNeeded()
        let l: CGFloat = frame.width * 0.05
        
        motionManager.startGyroUpdatesWithRate(frame.width / 1800.0) { offset in
            self.parallaxOffset.horizontal  = limit(offset.horizontal + self.parallaxOffset.horizontal, -l, l)
            self.parallaxOffset.vertical    = limit(offset.vertical + self.parallaxOffset.vertical, -l, l)
            self.updatingScroll()
        }
        self.updatingScroll()
        UIView.animateWithDuration(1.2, delay: 0, options: .CurveEaseInOut, animations: {
            self.scrollView.contentOffset.x = 0
            self.updatingScroll()
            self.layoutIfNeeded()
            }, completion: { finished in
                
        })
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updatingScroll()
    }
    
    func updatingScroll() {
        indicatorLabel.currentPage = (pages * scrollView.contentOffset.x)/scrollView.contentSize.width
        let baseMidOffsetX = frame.midX + scrollView.contentOffset.x
        
        parallaxLeadingConstraints.forEach {
            if let parallaxView = $0.firstItem as? UIView {
                let ratio = (parallaxView.frame.width  / scrollView.contentSize.width)
                let aspectViewMidOffsetX = baseMidOffsetX * ratio
                let offsetX = aspectViewMidOffsetX  - frame.midX
                $0.constant = scrollView.contentOffset.x  - offsetX + (parallaxOffset.horizontal * ratio)
            }
        }
        
        
        parallaxTopConstraints.forEach {
            if let parallaxView = $0.firstItem as? UIView {
                let ratio = (parallaxView.frame.width  / scrollView.contentSize.width)
                $0.constant = scrollView.contentOffset.y - ((scrollView.contentOffset.y - parallaxOffset.vertical) * ratio)
            }
        }
        
    }
}

class ParallaxMotionManager: CMMotionManager {
    
    var motionMovingRate: CGFloat = 1
    let sensitiveRate = 0.1
    
    override init() {
        super.init()
        self.gyroUpdateInterval = 1.0/60.0
        
    }
    
    func startGyroUpdatesWithRate(movingRate: CGFloat,offsetUpdate: (UIOffset)->Void) {
        motionMovingRate = movingRate
        guard let currentQueue = NSOperationQueue.currentQueue() else {
            return
        }
        startGyroUpdatesToQueue(currentQueue) { gyroData, error in
            guard let gyroData = gyroData else {
                return
            }
            if fabs(gyroData.rotationRate.y) >= self.sensitiveRate || fabs(gyroData.rotationRate.x) >= self.sensitiveRate {
                offsetUpdate(UIOffset(
                    horizontal: self.motionMovingRate * CGFloat(-gyroData.rotationRate.y),
                    vertical: self.motionMovingRate * CGFloat(-gyroData.rotationRate.x)))
            }
        }
    }
}


