
import CoreMotion
import UIKit

class MotionView {
    var view: UIView
    var movingRate: CGFloat = 0.0
    
    init(view: UIView,movingRate: CGFloat){
        self.view = view
        self.movingRate = movingRate
    }
}

class MotionManger: CMMotionManager {
    
    var registeredView = [MotionView]()
    
    override init() {
        super.init()
        gyroUpdateInterval = 1.0/60.0
        startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!) { gyroData, error in
            guard let gyroData = gyroData else {
                return
            }
            for view in self.registeredView {
                self.updateView(view, gyroData: gyroData)
            }
        }
    }
    
    func updateView(motionView: MotionView,gyroData: CMGyroData) {
        
        UIView.animateWithDuration(0.3, delay: 0,
            options: [.BeginFromCurrentState,.AllowUserInteraction,.CurveEaseInOut],
            animations: {

            
            }, completion: nil)
    }
    
    func registerMotionView(motionView: MotionView) {
        registeredView.append(motionView)
    }
    
    
}
