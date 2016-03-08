//
//  EPICLoadingAnimationView.swift
//
//  Code generated using QuartzCode 1.39.2 on 3/5/16.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class EPICLoadingAnimationView: UIView {
	
	var updateLayerValueForCompletedAnimation : Bool = false
	var animationAdded : Bool = false
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var layers : Dictionary<String, AnyObject> = [:]
	
	
	
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
	
	var loadingAnimProgress: CGFloat = 0{
		didSet{
			if(!self.animationAdded){
				removeAllAnimations()
				addLoadingAnimation()
				self.animationAdded = true
				layer.speed = 0
				layer.timeOffset = 0
			}
			else{
				let totalDuration : CGFloat = 2
				let offset = loadingAnimProgress * totalDuration
				layer.timeOffset = CFTimeInterval(offset)
			}
		}
	}
	
	override var frame: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	override var bounds: CGRect{
		didSet{
			setupLayerFrames()
		}
	}
	
	func setupProperties(){
		
	}
	
	func setupLayers(){
		let mountain = CALayer()
		self.layer.addSublayer(mountain)
		layers["mountain"] = mountain
		let mountainBlack = CAShapeLayer()
		mountain.addSublayer(mountainBlack)
		layers["mountainBlack"] = mountainBlack
		let progress = CAShapeLayer()
		mountain.addSublayer(progress)
		layers["progress"] = progress
		let mountainMask = CAShapeLayer()
		mountain.mask = mountainMask
		layers["mountainMask"] = mountainMask
		
		let loadingText = CATextLayer()
		self.layer.addSublayer(loadingText)
		layers["loadingText"] = loadingText
		
		resetLayerPropertiesForLayerIdentifiers(nil)
		setupLayerFrames()
	}
	
	func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("mountain"){
			let mountain = layers["mountain"] as! CALayer
			mountain.opacity = 0
			
		}
		if layerIds == nil || layerIds.contains("mountainBlack"){
			let mountainBlack = layers["mountainBlack"] as! CAShapeLayer
			mountainBlack.fillColor = UIColor(red:0.0196, green: 0.0275, blue:0.0314, alpha:1).CGColor
			mountainBlack.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("progress"){
			let progress = layers["progress"] as! CAShapeLayer
			progress.fillColor = UIColor(red:0, green: 0.851, blue:0.565, alpha:1).CGColor
			progress.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("loadingText"){
			let loadingText = layers["loadingText"] as! CATextLayer
			loadingText.opacity         = 0
			loadingText.contentsScale   = UIScreen.mainScreen().scale
			loadingText.string          = "Loading…"
			loadingText.font            = "Futura-Medium"
			loadingText.fontSize        = 13
			loadingText.alignmentMode   = kCAAlignmentCenter;
			loadingText.foregroundColor = UIColor.blackColor().CGColor;
		}
		
		CATransaction.commit()
	}
	
	func setupLayerFrames(){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if let mountain : CALayer = layers["mountain"] as? CALayer{
			mountain.frame = CGRectMake(0.37308 * mountain.superlayer!.bounds.width, 0.34204 * mountain.superlayer!.bounds.height, 0.25384 * mountain.superlayer!.bounds.width, 0.31593 * mountain.superlayer!.bounds.height)
		}
		
		if let mountainBlack : CAShapeLayer = layers["mountainBlack"] as? CAShapeLayer{
			mountainBlack.frame = CGRectMake(0.11528 * mountainBlack.superlayer!.bounds.width, 0, 0.76944 * mountainBlack.superlayer!.bounds.width, 0.37093 * mountainBlack.superlayer!.bounds.height)
			mountainBlack.path  = mountainBlackPathWithBounds((layers["mountainBlack"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let progress : CAShapeLayer = layers["progress"] as? CAShapeLayer{
			progress.frame = CGRectMake(0, 0.37093 * progress.superlayer!.bounds.height,  progress.superlayer!.bounds.width, 0.62907 * progress.superlayer!.bounds.height)
			progress.path  = progressPathWithBounds((layers["progress"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let mountainMask : CAShapeLayer = layers["mountainMask"] as? CAShapeLayer{
			mountainMask.frame = CGRectMake(0.11528 * mountainMask.superlayer!.bounds.width, 0, 0.76944 * mountainMask.superlayer!.bounds.width, 0.37093 * mountainMask.superlayer!.bounds.height)
			mountainMask.path  = mountainMaskPathWithBounds((layers["mountainMask"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let loadingText : CATextLayer = layers["loadingText"] as? CATextLayer{
			loadingText.frame = CGRectMake(0.00391 * loadingText.superlayer!.bounds.width, 0.52344 * loadingText.superlayer!.bounds.height,  loadingText.superlayer!.bounds.width, 0.1875 * loadingText.superlayer!.bounds.height)
		}
		
		CATransaction.commit()
	}
	
	//MARK: - Animation Setup
	
	func addLoadingAnimation(){
		addLoadingAnimationCompletionBlock(nil)
	}
	
	func addLoadingAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
		if completionBlock != nil{
			let completionAnim = CABasicAnimation(keyPath:"completionAnim")
			completionAnim.duration = 2
			completionAnim.delegate = self
			completionAnim.setValue("Loading", forKey:"animId")
			completionAnim.setValue(false, forKey:"needEndAnim")
			layer.addAnimation(completionAnim, forKey:"Loading")
			if let anim = layer.animationForKey("Loading"){
				completionBlocks[anim] = completionBlock
			}
		}
		
		self.layer.speed = 1
		self.animationAdded = false
		
		let fillMode : String = kCAFillModeForwards
		
		let progress = layers["progress"] as! CAShapeLayer
		
		////Progress animation
		let progressTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		progressTransformAnim.values   = [NSValue(CATransform3D: CATransform3DIdentity), 
			 NSValue(CATransform3D: CATransform3DMakeTranslation(0, -0.39566 * progress.superlayer!.bounds.height, 0))]
		progressTransformAnim.keyTimes = [0, 1]
		progressTransformAnim.duration = 2
		
		let progressLoadingAnim : CAAnimationGroup = QCMethod.groupAnimations([progressTransformAnim], fillMode:fillMode)
		progress.addAnimation(progressLoadingAnim, forKey:"progressLoadingAnim")
	}
	
	func addStartAnimation(){
		addStartAnimationCompletionBlock(nil)
	}
	
	func addStartAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
		if completionBlock != nil{
			let completionAnim = CABasicAnimation(keyPath:"completionAnim")
			completionAnim.duration = 0.4
			completionAnim.delegate = self
			completionAnim.setValue("start", forKey:"animId")
			completionAnim.setValue(false, forKey:"needEndAnim")
			layer.addAnimation(completionAnim, forKey:"start")
			if let anim = layer.animationForKey("start"){
				completionBlocks[anim] = completionBlock
			}
		}
		
		self.layer.speed = 1
		self.animationAdded = false
		
		let fillMode : String = kCAFillModeForwards
		
		////Mountain animation
		let mountainOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
		mountainOpacityAnim.values   = [0, 1]
		mountainOpacityAnim.keyTimes = [0, 1]
		mountainOpacityAnim.duration = 0.4
		
		let mountain = layers["mountain"] as! CALayer
		
		let mountainTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		mountainTransformAnim.values         = [NSValue(CATransform3D: CATransform3DMakeTranslation(0, -0.1875 * mountain.superlayer!.bounds.height, 0)), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		mountainTransformAnim.keyTimes       = [0, 1]
		mountainTransformAnim.duration       = 0.4
		mountainTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0.25, 1)
		
		let mountainStartAnim : CAAnimationGroup = QCMethod.groupAnimations([mountainOpacityAnim, mountainTransformAnim], fillMode:fillMode)
		mountain.addAnimation(mountainStartAnim, forKey:"mountainStartAnim")
		
		let loadingText = layers["loadingText"] as! CATextLayer
		
		////LoadingText animation
		let loadingTextTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		loadingTextTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeTranslation(0, 0.1875 * loadingText.superlayer!.bounds.height, 0)), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		loadingTextTransformAnim.keyTimes = [0, 1]
		loadingTextTransformAnim.duration = 0.4
		loadingTextTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0.25, 1)
		
		let loadingTextOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
		loadingTextOpacityAnim.values   = [0, 1]
		loadingTextOpacityAnim.keyTimes = [0, 1]
		loadingTextOpacityAnim.duration = 0.4
		
		let loadingTextStartAnim : CAAnimationGroup = QCMethod.groupAnimations([loadingTextTransformAnim, loadingTextOpacityAnim], fillMode:fillMode)
		loadingText.addAnimation(loadingTextStartAnim, forKey:"loadingTextStartAnim")
	}
	
	func addEndAnimation(){
		addEndAnimationCompletionBlock(nil)
	}
	
	func addEndAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
		if completionBlock != nil{
			let completionAnim = CABasicAnimation(keyPath:"completionAnim")
			completionAnim.duration = 0.4
			completionAnim.delegate = self
			completionAnim.setValue("end", forKey:"animId")
			completionAnim.setValue(false, forKey:"needEndAnim")
			layer.addAnimation(completionAnim, forKey:"end")
			if let anim = layer.animationForKey("end"){
				completionBlocks[anim] = completionBlock
			}
		}
		
		resetLayerPropertiesForLayerIdentifiers(["mountain", "loadingText"])
		
		self.layer.speed = 1
		self.animationAdded = false
		
		let fillMode : String = kCAFillModeForwards
		
		////Mountain animation
		let mountainOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
		mountainOpacityAnim.values   = [1, 0]
		mountainOpacityAnim.keyTimes = [0, 1]
		mountainOpacityAnim.duration = 0.4
		
		let mountain = layers["mountain"] as! CALayer
		
		let mountainTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		mountainTransformAnim.values         = [NSValue(CATransform3D: CATransform3DIdentity), 
			 NSValue(CATransform3D: CATransform3DMakeTranslation(0, -0.1875 * mountain.superlayer!.bounds.height, 0))]
		mountainTransformAnim.keyTimes       = [0, 1]
		mountainTransformAnim.duration       = 0.4
		mountainTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.75, 0, 1, 1)
		
		let mountainEndAnim : CAAnimationGroup = QCMethod.groupAnimations([mountainOpacityAnim, mountainTransformAnim], fillMode:fillMode)
		mountain.addAnimation(mountainEndAnim, forKey:"mountainEndAnim")
		
		////LoadingText animation
		let loadingTextOpacityAnim      = CAKeyframeAnimation(keyPath:"opacity")
		loadingTextOpacityAnim.values   = [1, 0]
		loadingTextOpacityAnim.keyTimes = [0, 1]
		loadingTextOpacityAnim.duration = 0.4
		
		let loadingText = layers["loadingText"] as! CATextLayer
		
		let loadingTextTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		loadingTextTransformAnim.values   = [NSValue(CATransform3D: CATransform3DIdentity), 
			 NSValue(CATransform3D: CATransform3DMakeTranslation(0, 0.1875 * loadingText.superlayer!.bounds.height, 0))]
		loadingTextTransformAnim.keyTimes = [0, 1]
		loadingTextTransformAnim.duration = 0.4
		loadingTextTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.75, 0, 1, 1)
		
		let loadingTextEndAnim : CAAnimationGroup = QCMethod.groupAnimations([loadingTextOpacityAnim, loadingTextTransformAnim], fillMode:fillMode)
		loadingText.addAnimation(loadingTextEndAnim, forKey:"loadingTextEndAnim")
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
		if identifier == "Loading"{
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["progress"] as! CALayer).animationForKey("progressLoadingAnim"), theLayer:(layers["progress"] as! CALayer))
		}
		else if identifier == "start"{
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["mountain"] as! CALayer).animationForKey("mountainStartAnim"), theLayer:(layers["mountain"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["loadingText"] as! CALayer).animationForKey("loadingTextStartAnim"), theLayer:(layers["loadingText"] as! CALayer))
		}
		else if identifier == "end"{
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["mountain"] as! CALayer).animationForKey("mountainEndAnim"), theLayer:(layers["mountain"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["loadingText"] as! CALayer).animationForKey("loadingTextEndAnim"), theLayer:(layers["loadingText"] as! CALayer))
		}
	}
	
	func removeAnimationsForAnimationId(identifier: String){
		if identifier == "Loading"{
			(layers["progress"] as! CALayer).removeAnimationForKey("progressLoadingAnim")
		}
		else if identifier == "start"{
			(layers["mountain"] as! CALayer).removeAnimationForKey("mountainStartAnim")
			(layers["loadingText"] as! CALayer).removeAnimationForKey("loadingTextStartAnim")
		}
		else if identifier == "end"{
			(layers["mountain"] as! CALayer).removeAnimationForKey("mountainEndAnim")
			(layers["loadingText"] as! CALayer).removeAnimationForKey("loadingTextEndAnim")
		}
		self.layer.speed = 1
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
		self.layer.speed = 1
	}
	
	//MARK: - Bezier Path
	
	func mountainBlackPathWithBounds(bound: CGRect) -> UIBezierPath{
		let mountainBlackPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		mountainBlackPath.moveToPoint(CGPointMake(minX + 0.38 * w, minY + 0.72222 * h))
		mountainBlackPath.addLineToPoint(CGPointMake(minX + 0.24 * w, minY + 0.33333 * h))
		mountainBlackPath.addLineToPoint(CGPointMake(minX, minY + h))
		mountainBlackPath.addLineToPoint(CGPointMake(minX + 0.38 * w, minY + h))
		mountainBlackPath.addLineToPoint(CGPointMake(minX + w, minY + h))
		mountainBlackPath.addLineToPoint(CGPointMake(minX + 0.64 * w, minY))
		mountainBlackPath.addLineToPoint(CGPointMake(minX + 0.38 * w, minY + 0.72222 * h))
		mountainBlackPath.closePath()
		mountainBlackPath.moveToPoint(CGPointMake(minX + 0.38 * w, minY + 0.72222 * h))
		
		return mountainBlackPath;
	}
	
	func progressPathWithBounds(bound: CGRect) -> UIBezierPath{
		let progressPath = UIBezierPath(rect:bound)
		return progressPath;
	}
	
	func mountainMaskPathWithBounds(bound: CGRect) -> UIBezierPath{
		let mountainMaskPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		mountainMaskPath.moveToPoint(CGPointMake(minX + 0.38 * w, minY + 0.72222 * h))
		mountainMaskPath.addLineToPoint(CGPointMake(minX + 0.24 * w, minY + 0.33333 * h))
		mountainMaskPath.addLineToPoint(CGPointMake(minX, minY + h))
		mountainMaskPath.addLineToPoint(CGPointMake(minX + 0.38 * w, minY + h))
		mountainMaskPath.addLineToPoint(CGPointMake(minX + w, minY + h))
		mountainMaskPath.addLineToPoint(CGPointMake(minX + 0.64 * w, minY))
		mountainMaskPath.addLineToPoint(CGPointMake(minX + 0.38 * w, minY + 0.72222 * h))
		mountainMaskPath.closePath()
		mountainMaskPath.moveToPoint(CGPointMake(minX + 0.38 * w, minY + 0.72222 * h))
		
		return mountainMaskPath;
	}
	
	
}
