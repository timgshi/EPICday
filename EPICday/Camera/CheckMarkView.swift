//
//  checkMarkView.swift
//
//  Code generated using QuartzCode 1.39.2 on 3/3/16.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class CheckMarkView: UIView {
    
    var layers : Dictionary<String, AnyObject> = [:]
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var updateLayerValueForCompletedAnimation : Bool = true
    
    var color : UIColor!
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupProperties()
        setupLayers()
    }
    
    
    
    func setupProperties(){
        self.color = UIColor(red:0, green: 0.851, blue:0.565, alpha:1)
    }
    
    func setupLayers(){
        let bgOval = CAShapeLayer()
        bgOval.frame = CGRectMake(1, 1, 76, 76)
        bgOval.path = bgOvalPath().CGPath;
        self.layer.addSublayer(bgOval)
        layers["bgOval"] = bgOval
        
        let oval = CAShapeLayer()
        oval.frame = CGRectMake(1, 1, 76, 76)
        oval.path = ovalPath().CGPath;
        self.layer.addSublayer(oval)
        layers["oval"] = oval
        
        let checkmark = CAShapeLayer()
        checkmark.frame = CGRectMake(28.57, 31.59, 20.86, 14.82)
        checkmark.path = checkmarkPath().CGPath;
        self.layer.addSublayer(checkmark)
        layers["checkmark"] = checkmark
        
        resetLayerPropertiesForLayerIdentifiers(nil)
    }
    
    func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if layerIds == nil || layerIds.contains("bgOval"){
            let bgOval = layers["bgOval"] as! CAShapeLayer
            bgOval.fillColor   = nil
            bgOval.strokeColor = UIColor.whiteColor().CGColor
            bgOval.lineWidth   = 3
        }
        if layerIds == nil || layerIds.contains("oval"){
            let oval = layers["oval"] as! CAShapeLayer
            oval.opacity     = 0
            oval.fillColor   = nil
            oval.strokeColor = UIColor(red:0, green: 0.851, blue:0.565, alpha:1).CGColor
            oval.lineWidth   = 3
        }
        if layerIds == nil || layerIds.contains("checkmark"){
            let checkmark = layers["checkmark"] as! CAShapeLayer
            checkmark.opacity     = 0
            checkmark.fillColor   = nil
            checkmark.strokeColor = self.color.CGColor
            checkmark.lineWidth   = 3
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func runFullAnimation () {
        addStartCheckmarkAnimationCompletionBlock { (finished) in
            self.addEndCheckmarkAnimation()
        }
    }
    
    func addStartCheckmarkAnimation(){
        addStartCheckmarkAnimationCompletionBlock(nil)
    }
    
    func addStartCheckmarkAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 1
            completionAnim.delegate = self
            completionAnim.setValue("startCheckmark", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"startCheckmark")
            if let anim = layer.animationForKey("startCheckmark"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        self.layer.speed = 1
        //		self.animationAdded = false
        
        let fillMode : String = kCAFillModeForwards
        
        ////Oval animation
        let ovalStrokeStartAnim            = CAKeyframeAnimation(keyPath:"strokeStart")
        ovalStrokeStartAnim.values         = [1, 0]
        ovalStrokeStartAnim.keyTimes       = [0, 1]
        ovalStrokeStartAnim.duration       = 0.5
        ovalStrokeStartAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0, 0.5, 1)
        
        let ovalTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        ovalTransformAnim.values   = [-90 * CGFloat(M_PI/180),
                                      45 * CGFloat(M_PI/180)]
        ovalTransformAnim.keyTimes = [0, 1]
        ovalTransformAnim.duration = 0.5
        
        let ovalOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
        ovalOpacityAnim.values   = [1, 1]
        ovalOpacityAnim.keyTimes = [0, 1]
        ovalOpacityAnim.duration = 0.5
        
        let ovalStartCheckmarkAnim : CAAnimationGroup = QCMethod.groupAnimations([ovalStrokeStartAnim, ovalTransformAnim, ovalOpacityAnim], fillMode:fillMode)
        layers["oval"]?.addAnimation(ovalStartCheckmarkAnim, forKey:"ovalStartCheckmarkAnim")
        
        ////Checkmark animation
        let checkmarkStrokeEndAnim            = CAKeyframeAnimation(keyPath:"strokeEnd")
        checkmarkStrokeEndAnim.values         = [0, 1]
        checkmarkStrokeEndAnim.keyTimes       = [0, 1]
        checkmarkStrokeEndAnim.duration       = 0.5
        checkmarkStrokeEndAnim.beginTime      = 0
        checkmarkStrokeEndAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
        
        let checkmarkOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
        checkmarkOpacityAnim.values    = [1, 1]
        checkmarkOpacityAnim.keyTimes  = [0, 1]
        checkmarkOpacityAnim.duration  = 0.5
        checkmarkOpacityAnim.beginTime = 0
        
        let checkmarkStartCheckmarkAnim : CAAnimationGroup = QCMethod.groupAnimations([checkmarkStrokeEndAnim, checkmarkOpacityAnim], fillMode:fillMode)
        layers["checkmark"]?.addAnimation(checkmarkStartCheckmarkAnim, forKey:"checkmarkStartCheckmarkAnim")
    }
    
    func addEndCheckmarkAnimation(){
        addEndCheckmarkAnimationCompletionBlock(nil)
    }
    
    func addEndCheckmarkAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 0.5
            completionAnim.delegate = self
            completionAnim.setValue("endCheckmark", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"endCheckmark")
            if let anim = layer.animationForKey("endCheckmark"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        resetLayerPropertiesForLayerIdentifiers(["oval", "checkmark"])
        
        self.layer.speed = 1
        //		self.animationAdded = false
        
        let fillMode : String = kCAFillModeForwards
        
        ////Oval animation
        let ovalOpacityAnim            = CAKeyframeAnimation(keyPath:"opacity")
        ovalOpacityAnim.values         = [1, 0]
        ovalOpacityAnim.keyTimes       = [0, 1]
        ovalOpacityAnim.duration       = 0.2
        
        
        let ovalEndCheckmarkAnim : CAAnimationGroup = QCMethod.groupAnimations([ovalOpacityAnim], fillMode:fillMode)
        layers["oval"]?.addAnimation(ovalEndCheckmarkAnim, forKey:"ovalEndCheckmarkAnim")
        
        ////Checkmark animation
        let checkmarkOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
        checkmarkOpacityAnim.values   = [1, 0]
        checkmarkOpacityAnim.keyTimes = [0, 1]
        checkmarkOpacityAnim.duration = 0.2
        
        //		let checkmarkStrokeStartAnim      = CAKeyframeAnimation(keyPath:"strokeStart")
        //		checkmarkStrokeStartAnim.values   = [0, 1]
        //		checkmarkStrokeStartAnim.keyTimes = [0, 1]
        //		checkmarkStrokeStartAnim.duration = 0.5
        //		checkmarkStrokeStartAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 1, 1, 1)
        
        let checkmarkEndCheckmarkAnim : CAAnimationGroup = QCMethod.groupAnimations([checkmarkOpacityAnim], fillMode:fillMode)
        layers["checkmark"]?.addAnimation(checkmarkEndCheckmarkAnim, forKey:"checkmarkEndCheckmarkAnim")
    }
    
    //MARK: - Animation Cleanup
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValueForKey(anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
                updateLayerValuesForAnimationId(anim.valueForKey("animId") as! String)
                removeAnimationsForAnimationId(anim.valueForKey("animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValuesForAnimationId(identifier: String){
        if identifier == "startCheckmark"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["oval"] as! CALayer).animationForKey("ovalStartCheckmarkAnim"), theLayer:(layers["oval"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["checkmark"] as! CALayer).animationForKey("checkmarkStartCheckmarkAnim"), theLayer:(layers["checkmark"] as! CALayer))
        }
        else if identifier == "endCheckmark"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["oval"] as! CALayer).animationForKey("ovalEndCheckmarkAnim"), theLayer:(layers["oval"] as! CALayer))
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["checkmark"] as! CALayer).animationForKey("checkmarkEndCheckmarkAnim"), theLayer:(layers["checkmark"] as! CALayer))
        }
    }
    
    func removeAnimationsForAnimationId(identifier: String){
        if identifier == "startCheckmark"{
            (layers["oval"] as! CALayer).removeAnimationForKey("ovalStartCheckmarkAnim")
            (layers["checkmark"] as! CALayer).removeAnimationForKey("checkmarkStartCheckmarkAnim")
        }
        else if identifier == "endCheckmark"{
            (layers["oval"] as! CALayer).removeAnimationForKey("ovalEndCheckmarkAnim")
            (layers["checkmark"] as! CALayer).removeAnimationForKey("checkmarkEndCheckmarkAnim")
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
    }
    
    //MARK: - Bezier Path
    
    func bgOvalPath() -> UIBezierPath{
        let bgOvalPath = UIBezierPath()
        bgOvalPath.moveToPoint(CGPointMake(38, 0))
        bgOvalPath.addCurveToPoint(CGPointMake(0, 38), controlPoint1:CGPointMake(17.013, 0), controlPoint2:CGPointMake(0, 17.013))
        bgOvalPath.addCurveToPoint(CGPointMake(38, 76), controlPoint1:CGPointMake(0, 58.987), controlPoint2:CGPointMake(17.013, 76))
        bgOvalPath.addCurveToPoint(CGPointMake(76, 38), controlPoint1:CGPointMake(58.987, 76), controlPoint2:CGPointMake(76, 58.987))
        bgOvalPath.addCurveToPoint(CGPointMake(38, 0), controlPoint1:CGPointMake(76, 17.013), controlPoint2:CGPointMake(58.987, 0))
        
        return bgOvalPath;
    }
    
    func ovalPath() -> UIBezierPath{
        let ovalPath = UIBezierPath()
        ovalPath.moveToPoint(CGPointMake(38, 0))
        ovalPath.addCurveToPoint(CGPointMake(0, 38), controlPoint1:CGPointMake(17.013, 0), controlPoint2:CGPointMake(0, 17.013))
        ovalPath.addCurveToPoint(CGPointMake(38, 76), controlPoint1:CGPointMake(0, 58.987), controlPoint2:CGPointMake(17.013, 76))
        ovalPath.addCurveToPoint(CGPointMake(76, 38), controlPoint1:CGPointMake(58.987, 76), controlPoint2:CGPointMake(76, 58.987))
        ovalPath.addCurveToPoint(CGPointMake(38, 0), controlPoint1:CGPointMake(76, 17.013), controlPoint2:CGPointMake(58.987, 0))
        
        return ovalPath;
    }
    
    func checkmarkPath() -> UIBezierPath{
        let checkmarkPath = UIBezierPath()
        checkmarkPath.moveToPoint(CGPointMake(0, 8.782))
        checkmarkPath.addLineToPoint(CGPointMake(6.038, 14.82))
        checkmarkPath.addLineToPoint(CGPointMake(20.857, 0))
        
        return checkmarkPath;
    }
}
