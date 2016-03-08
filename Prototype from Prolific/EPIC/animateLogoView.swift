//
//  animateLogoView.swift
//
//  Code generated using QuartzCode 1.39.2 on 3/5/16.
//  www.quartzcodeapp.com
//

import UIKit

@IBDesignable
class animateLogoView: UIView {
	
	var layers : Dictionary<String, AnyObject> = [:]
	var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
	var updateLayerValueForCompletedAnimation : Bool = true
	
	
	
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
		let wholeLogo = CALayer()
		self.layer.addSublayer(wholeLogo)
		layers["wholeLogo"] = wholeLogo
		let animateMainCircle = CALayer()
		wholeLogo.addSublayer(animateMainCircle)
		layers["animateMainCircle"] = animateMainCircle
		let mainCircle = CAShapeLayer()
		animateMainCircle.addSublayer(mainCircle)
		layers["mainCircle"] = mainCircle
		let circleLineOut = CAShapeLayer()
		wholeLogo.addSublayer(circleLineOut)
		layers["circleLineOut"] = circleLineOut
		let circleLineIn = CAShapeLayer()
		wholeLogo.addSublayer(circleLineIn)
		layers["circleLineIn"] = circleLineIn
		let circleLineInStroke = CAShapeLayer()
		wholeLogo.addSublayer(circleLineInStroke)
		layers["circleLineInStroke"] = circleLineInStroke
		let wordOutEntire = CALayer()
		wholeLogo.addSublayer(wordOutEntire)
		layers["wordOutEntire"] = wordOutEntire
		let wordOutMask = CALayer()
		wordOutEntire.addSublayer(wordOutMask)
		layers["wordOutMask"] = wordOutMask
		let epicurrenceWord = CALayer()
		wordOutMask.addSublayer(epicurrenceWord)
		layers["epicurrenceWord"] = epicurrenceWord
		let path95 = CAShapeLayer()
		epicurrenceWord.addSublayer(path95)
		layers["path95"] = path95
		let path96 = CAShapeLayer()
		epicurrenceWord.addSublayer(path96)
		layers["path96"] = path96
		let path97 = CAShapeLayer()
		epicurrenceWord.addSublayer(path97)
		layers["path97"] = path97
		let path98 = CAShapeLayer()
		epicurrenceWord.addSublayer(path98)
		layers["path98"] = path98
		let path99 = CAShapeLayer()
		epicurrenceWord.addSublayer(path99)
		layers["path99"] = path99
		let path100 = CAShapeLayer()
		epicurrenceWord.addSublayer(path100)
		layers["path100"] = path100
		let path101 = CAShapeLayer()
		epicurrenceWord.addSublayer(path101)
		layers["path101"] = path101
		let path102 = CAShapeLayer()
		epicurrenceWord.addSublayer(path102)
		layers["path102"] = path102
		let path103 = CAShapeLayer()
		epicurrenceWord.addSublayer(path103)
		layers["path103"] = path103
		let path104 = CAShapeLayer()
		epicurrenceWord.addSublayer(path104)
		layers["path104"] = path104
		let path105 = CAShapeLayer()
		epicurrenceWord.addSublayer(path105)
		layers["path105"] = path105
		let theMontuesWord = CALayer()
		wordOutMask.addSublayer(theMontuesWord)
		layers["theMontuesWord"] = theMontuesWord
		let path106 = CAShapeLayer()
		theMontuesWord.addSublayer(path106)
		layers["path106"] = path106
		let path107 = CAShapeLayer()
		theMontuesWord.addSublayer(path107)
		layers["path107"] = path107
		let path108 = CAShapeLayer()
		theMontuesWord.addSublayer(path108)
		layers["path108"] = path108
		let path109 = CAShapeLayer()
		theMontuesWord.addSublayer(path109)
		layers["path109"] = path109
		let path110 = CAShapeLayer()
		theMontuesWord.addSublayer(path110)
		layers["path110"] = path110
		let path111 = CAShapeLayer()
		theMontuesWord.addSublayer(path111)
		layers["path111"] = path111
		let path112 = CAShapeLayer()
		theMontuesWord.addSublayer(path112)
		layers["path112"] = path112
		let path113 = CAShapeLayer()
		theMontuesWord.addSublayer(path113)
		layers["path113"] = path113
		let path114 = CAShapeLayer()
		theMontuesWord.addSublayer(path114)
		layers["path114"] = path114
		let path115 = CAShapeLayer()
		theMontuesWord.addSublayer(path115)
		layers["path115"] = path115
		let noOneWord = CALayer()
		wordOutMask.addSublayer(noOneWord)
		layers["noOneWord"] = noOneWord
		let path116 = CAShapeLayer()
		noOneWord.addSublayer(path116)
		layers["path116"] = path116
		let path117 = CAShapeLayer()
		noOneWord.addSublayer(path117)
		layers["path117"] = path117
		let path118 = CAShapeLayer()
		noOneWord.addSublayer(path118)
		layers["path118"] = path118
		let path119 = CAShapeLayer()
		noOneWord.addSublayer(path119)
		layers["path119"] = path119
		let yearWord = CALayer()
		wordOutMask.addSublayer(yearWord)
		layers["yearWord"] = yearWord
		let path120 = CAShapeLayer()
		yearWord.addSublayer(path120)
		layers["path120"] = path120
		let path121 = CAShapeLayer()
		yearWord.addSublayer(path121)
		layers["path121"] = path121
		let path122 = CAShapeLayer()
		yearWord.addSublayer(path122)
		layers["path122"] = path122
		let path123 = CAShapeLayer()
		yearWord.addSublayer(path123)
		layers["path123"] = path123
		let circleInBlack = CAShapeLayer()
		wholeLogo.addSublayer(circleInBlack)
		layers["circleInBlack"] = circleInBlack
		let wordInMask = CALayer()
		wholeLogo.addSublayer(wordInMask)
		layers["wordInMask"] = wordInMask
		let wordIn = CALayer()
		wordInMask.addSublayer(wordIn)
		layers["wordIn"] = wordIn
		let path67 = CAShapeLayer()
		wordIn.addSublayer(path67)
		layers["path67"] = path67
		let path68 = CAShapeLayer()
		wordIn.addSublayer(path68)
		layers["path68"] = path68
		let path69 = CAShapeLayer()
		wordIn.addSublayer(path69)
		layers["path69"] = path69
		let path70 = CAShapeLayer()
		wordIn.addSublayer(path70)
		layers["path70"] = path70
		let path71 = CAShapeLayer()
		wordIn.addSublayer(path71)
		layers["path71"] = path71
		let path72 = CAShapeLayer()
		wordIn.addSublayer(path72)
		layers["path72"] = path72
		let path73 = CAShapeLayer()
		wordIn.addSublayer(path73)
		layers["path73"] = path73
		let path74 = CAShapeLayer()
		wordIn.addSublayer(path74)
		layers["path74"] = path74
		let path75 = CAShapeLayer()
		wordIn.addSublayer(path75)
		layers["path75"] = path75
		let path76 = CAShapeLayer()
		wordIn.addSublayer(path76)
		layers["path76"] = path76
		let path77 = CAShapeLayer()
		wordIn.addSublayer(path77)
		layers["path77"] = path77
		let path78 = CAShapeLayer()
		wordIn.addSublayer(path78)
		layers["path78"] = path78
		let path79 = CAShapeLayer()
		wordIn.addSublayer(path79)
		layers["path79"] = path79
		let path80 = CAShapeLayer()
		wordIn.addSublayer(path80)
		layers["path80"] = path80
		let path81 = CAShapeLayer()
		wordIn.addSublayer(path81)
		layers["path81"] = path81
		let path82 = CAShapeLayer()
		wordIn.addSublayer(path82)
		layers["path82"] = path82
		let path83 = CAShapeLayer()
		wordIn.addSublayer(path83)
		layers["path83"] = path83
		let path84 = CAShapeLayer()
		wordIn.addSublayer(path84)
		layers["path84"] = path84
		let path85 = CAShapeLayer()
		wordIn.addSublayer(path85)
		layers["path85"] = path85
		let path86 = CAShapeLayer()
		wordIn.addSublayer(path86)
		layers["path86"] = path86
		let path87 = CAShapeLayer()
		wordIn.addSublayer(path87)
		layers["path87"] = path87
		let path88 = CAShapeLayer()
		wordIn.addSublayer(path88)
		layers["path88"] = path88
		let path89 = CAShapeLayer()
		wordIn.addSublayer(path89)
		layers["path89"] = path89
		let path90 = CAShapeLayer()
		wordIn.addSublayer(path90)
		layers["path90"] = path90
		let path91 = CAShapeLayer()
		wordIn.addSublayer(path91)
		layers["path91"] = path91
		let path92 = CAShapeLayer()
		wordIn.addSublayer(path92)
		layers["path92"] = path92
		let path93 = CAShapeLayer()
		wordIn.addSublayer(path93)
		layers["path93"] = path93
		let path94 = CAShapeLayer()
		wordIn.addSublayer(path94)
		layers["path94"] = path94
		let circleInMask = CAShapeLayer()
		wordInMask.mask = circleInMask
		layers["circleInMask"] = circleInMask
		let wordOut = CALayer()
		wholeLogo.addSublayer(wordOut)
		layers["wordOut"] = wordOut
		let markAnimate = CALayer()
		wholeLogo.addSublayer(markAnimate)
		layers["markAnimate"] = markAnimate
		let markEnd = CAShapeLayer()
		markAnimate.addSublayer(markEnd)
		layers["markEnd"] = markEnd
		let markStart = CAShapeLayer()
		markAnimate.addSublayer(markStart)
		layers["markStart"] = markStart
		
		resetLayerPropertiesForLayerIdentifiers(nil)
		setupLayerFrames()
	}
	
	func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if layerIds == nil || layerIds.contains("mainCircle"){
			let mainCircle = layers["mainCircle"] as! CAShapeLayer
			mainCircle.fillColor = UIColor(red:0.0196, green: 0.0275, blue:0.0314, alpha:1).CGColor
			mainCircle.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("circleLineOut"){
			let circleLineOut = layers["circleLineOut"] as! CAShapeLayer
			circleLineOut.opacity   = 0
			circleLineOut.fillColor = UIColor.whiteColor().CGColor
			circleLineOut.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("circleLineIn"){
			let circleLineIn = layers["circleLineIn"] as! CAShapeLayer
			circleLineIn.opacity   = 0
			circleLineIn.fillColor = UIColor.whiteColor().CGColor
			circleLineIn.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("circleLineInStroke"){
			let circleLineInStroke = layers["circleLineInStroke"] as! CAShapeLayer
			circleLineInStroke.opacity     = 0
			circleLineInStroke.fillColor   = nil
			circleLineInStroke.strokeColor = UIColor.whiteColor().CGColor
			circleLineInStroke.lineWidth   = 1.5
		}
		if layerIds == nil || layerIds.contains("wordOutMask"){
			let wordOutMask = layers["wordOutMask"] as! CALayer
			wordOutMask.opacity = 0
			
		}
		if layerIds == nil || layerIds.contains("path95"){
			let path95 = layers["path95"] as! CAShapeLayer
			path95.fillColor = UIColor.whiteColor().CGColor
			path95.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path96"){
			let path96 = layers["path96"] as! CAShapeLayer
			path96.fillColor = UIColor.whiteColor().CGColor
			path96.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path97"){
			let path97 = layers["path97"] as! CAShapeLayer
			path97.fillColor = UIColor.whiteColor().CGColor
			path97.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path98"){
			let path98 = layers["path98"] as! CAShapeLayer
			path98.fillColor = UIColor.whiteColor().CGColor
			path98.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path99"){
			let path99 = layers["path99"] as! CAShapeLayer
			path99.fillColor = UIColor.whiteColor().CGColor
			path99.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path100"){
			let path100 = layers["path100"] as! CAShapeLayer
			path100.fillColor = UIColor.whiteColor().CGColor
			path100.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path101"){
			let path101 = layers["path101"] as! CAShapeLayer
			path101.fillColor = UIColor.whiteColor().CGColor
			path101.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path102"){
			let path102 = layers["path102"] as! CAShapeLayer
			path102.fillColor = UIColor.whiteColor().CGColor
			path102.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path103"){
			let path103 = layers["path103"] as! CAShapeLayer
			path103.fillColor = UIColor.whiteColor().CGColor
			path103.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path104"){
			let path104 = layers["path104"] as! CAShapeLayer
			path104.fillColor = UIColor.whiteColor().CGColor
			path104.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path105"){
			let path105 = layers["path105"] as! CAShapeLayer
			path105.fillColor = UIColor.whiteColor().CGColor
			path105.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path106"){
			let path106 = layers["path106"] as! CAShapeLayer
			path106.fillColor = UIColor.whiteColor().CGColor
			path106.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path107"){
			let path107 = layers["path107"] as! CAShapeLayer
			path107.fillColor = UIColor.whiteColor().CGColor
			path107.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path108"){
			let path108 = layers["path108"] as! CAShapeLayer
			path108.fillColor = UIColor.whiteColor().CGColor
			path108.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path109"){
			let path109 = layers["path109"] as! CAShapeLayer
			path109.fillColor = UIColor.whiteColor().CGColor
			path109.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path110"){
			let path110 = layers["path110"] as! CAShapeLayer
			path110.fillColor = UIColor.whiteColor().CGColor
			path110.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path111"){
			let path111 = layers["path111"] as! CAShapeLayer
			path111.fillColor = UIColor.whiteColor().CGColor
			path111.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path112"){
			let path112 = layers["path112"] as! CAShapeLayer
			path112.fillColor = UIColor.whiteColor().CGColor
			path112.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path113"){
			let path113 = layers["path113"] as! CAShapeLayer
			path113.fillColor = UIColor.whiteColor().CGColor
			path113.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path114"){
			let path114 = layers["path114"] as! CAShapeLayer
			path114.fillColor = UIColor.whiteColor().CGColor
			path114.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path115"){
			let path115 = layers["path115"] as! CAShapeLayer
			path115.fillColor = UIColor.whiteColor().CGColor
			path115.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path116"){
			let path116 = layers["path116"] as! CAShapeLayer
			path116.fillColor = UIColor.whiteColor().CGColor
			path116.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path117"){
			let path117 = layers["path117"] as! CAShapeLayer
			path117.fillColor = UIColor.whiteColor().CGColor
			path117.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path118"){
			let path118 = layers["path118"] as! CAShapeLayer
			path118.fillColor = UIColor.whiteColor().CGColor
			path118.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path119"){
			let path119 = layers["path119"] as! CAShapeLayer
			path119.fillColor = UIColor.whiteColor().CGColor
			path119.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path120"){
			let path120 = layers["path120"] as! CAShapeLayer
			path120.fillColor = UIColor.whiteColor().CGColor
			path120.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path121"){
			let path121 = layers["path121"] as! CAShapeLayer
			path121.fillColor = UIColor.whiteColor().CGColor
			path121.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path122"){
			let path122 = layers["path122"] as! CAShapeLayer
			path122.fillColor = UIColor.whiteColor().CGColor
			path122.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path123"){
			let path123 = layers["path123"] as! CAShapeLayer
			path123.fillColor = UIColor.whiteColor().CGColor
			path123.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("circleInBlack"){
			let circleInBlack = layers["circleInBlack"] as! CAShapeLayer
			circleInBlack.fillColor = UIColor(red:0.0196, green: 0.0275, blue:0.0275, alpha:1).CGColor
			circleInBlack.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("wordIn"){
			let wordIn = layers["wordIn"] as! CALayer
			wordIn.opacity = 0
			
		}
		if layerIds == nil || layerIds.contains("path67"){
			let path67 = layers["path67"] as! CAShapeLayer
			path67.fillColor = UIColor.whiteColor().CGColor
			path67.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path68"){
			let path68 = layers["path68"] as! CAShapeLayer
			path68.fillColor = UIColor.whiteColor().CGColor
			path68.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path69"){
			let path69 = layers["path69"] as! CAShapeLayer
			path69.fillColor = UIColor.whiteColor().CGColor
			path69.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path70"){
			let path70 = layers["path70"] as! CAShapeLayer
			path70.fillColor = UIColor.whiteColor().CGColor
			path70.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path71"){
			let path71 = layers["path71"] as! CAShapeLayer
			path71.fillColor = UIColor.whiteColor().CGColor
			path71.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path72"){
			let path72 = layers["path72"] as! CAShapeLayer
			path72.fillColor = UIColor.whiteColor().CGColor
			path72.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path73"){
			let path73 = layers["path73"] as! CAShapeLayer
			path73.fillColor = UIColor.whiteColor().CGColor
			path73.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path74"){
			let path74 = layers["path74"] as! CAShapeLayer
			path74.fillColor = UIColor.whiteColor().CGColor
			path74.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path75"){
			let path75 = layers["path75"] as! CAShapeLayer
			path75.fillColor = UIColor.whiteColor().CGColor
			path75.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path76"){
			let path76 = layers["path76"] as! CAShapeLayer
			path76.fillColor = UIColor.whiteColor().CGColor
			path76.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path77"){
			let path77 = layers["path77"] as! CAShapeLayer
			path77.fillColor = UIColor.whiteColor().CGColor
			path77.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path78"){
			let path78 = layers["path78"] as! CAShapeLayer
			path78.fillColor = UIColor.whiteColor().CGColor
			path78.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path79"){
			let path79 = layers["path79"] as! CAShapeLayer
			path79.fillColor = UIColor.whiteColor().CGColor
			path79.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path80"){
			let path80 = layers["path80"] as! CAShapeLayer
			path80.fillColor = UIColor.whiteColor().CGColor
			path80.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path81"){
			let path81 = layers["path81"] as! CAShapeLayer
			path81.fillColor = UIColor.whiteColor().CGColor
			path81.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path82"){
			let path82 = layers["path82"] as! CAShapeLayer
			path82.fillColor = UIColor.whiteColor().CGColor
			path82.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path83"){
			let path83 = layers["path83"] as! CAShapeLayer
			path83.fillColor = UIColor.whiteColor().CGColor
			path83.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path84"){
			let path84 = layers["path84"] as! CAShapeLayer
			path84.fillColor = UIColor.whiteColor().CGColor
			path84.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path85"){
			let path85 = layers["path85"] as! CAShapeLayer
			path85.fillColor = UIColor.whiteColor().CGColor
			path85.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path86"){
			let path86 = layers["path86"] as! CAShapeLayer
			path86.fillColor = UIColor.whiteColor().CGColor
			path86.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path87"){
			let path87 = layers["path87"] as! CAShapeLayer
			path87.fillColor = UIColor.whiteColor().CGColor
			path87.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path88"){
			let path88 = layers["path88"] as! CAShapeLayer
			path88.fillColor = UIColor.whiteColor().CGColor
			path88.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path89"){
			let path89 = layers["path89"] as! CAShapeLayer
			path89.fillColor = UIColor.whiteColor().CGColor
			path89.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path90"){
			let path90 = layers["path90"] as! CAShapeLayer
			path90.fillColor = UIColor.whiteColor().CGColor
			path90.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path91"){
			let path91 = layers["path91"] as! CAShapeLayer
			path91.fillColor = UIColor.whiteColor().CGColor
			path91.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path92"){
			let path92 = layers["path92"] as! CAShapeLayer
			path92.fillColor = UIColor.whiteColor().CGColor
			path92.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path93"){
			let path93 = layers["path93"] as! CAShapeLayer
			path93.fillColor = UIColor.whiteColor().CGColor
			path93.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("path94"){
			let path94 = layers["path94"] as! CAShapeLayer
			path94.fillColor = UIColor.whiteColor().CGColor
			path94.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("wordOut"){
			let wordOut = layers["wordOut"] as! CALayer
			wordOut.hidden = true
			
		}
		if layerIds == nil || layerIds.contains("markEnd"){
			let markEnd = layers["markEnd"] as! CAShapeLayer
			markEnd.hidden    = true
			markEnd.fillColor = UIColor.whiteColor().CGColor
			markEnd.lineWidth = 0
		}
		if layerIds == nil || layerIds.contains("markStart"){
			let markStart = layers["markStart"] as! CAShapeLayer
			markStart.fillColor = UIColor.whiteColor().CGColor
			markStart.lineWidth = 0
		}
		
		CATransaction.commit()
	}
	
	func setupLayerFrames(){
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		if let wholeLogo : CALayer = layers["wholeLogo"] as? CALayer{
			wholeLogo.frame = CGRectMake(0.125 * wholeLogo.superlayer!.bounds.width, 0.125 * wholeLogo.superlayer!.bounds.height, 0.75 * wholeLogo.superlayer!.bounds.width, 0.97854 * wholeLogo.superlayer!.bounds.height)
		}
		
		if let animateMainCircle : CALayer = layers["animateMainCircle"] as? CALayer{
			animateMainCircle.frame = CGRectMake(0, 0,  animateMainCircle.superlayer!.bounds.width, 0.76645 * animateMainCircle.superlayer!.bounds.height)
		}
		
		if let mainCircle : CAShapeLayer = layers["mainCircle"] as? CAShapeLayer{
			mainCircle.frame = CGRectMake(0, 0,  mainCircle.superlayer!.bounds.width, 1 * mainCircle.superlayer!.bounds.height)
			mainCircle.path  = mainCirclePathWithBounds((layers["mainCircle"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let circleLineOut : CAShapeLayer = layers["circleLineOut"] as? CAShapeLayer{
			circleLineOut.frame = CGRectMake(0.03875 * circleLineOut.superlayer!.bounds.width, 0.0297 * circleLineOut.superlayer!.bounds.height, 0.9225 * circleLineOut.superlayer!.bounds.width, 0.70705 * circleLineOut.superlayer!.bounds.height)
			circleLineOut.path  = circleLineOutPathWithBounds((layers["circleLineOut"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let circleLineIn : CAShapeLayer = layers["circleLineIn"] as? CAShapeLayer{
			circleLineIn.frame = CGRectMake(0.20917 * circleLineIn.superlayer!.bounds.width, 0.16032 * circleLineIn.superlayer!.bounds.height, 0.58167 * circleLineIn.superlayer!.bounds.width, 0.44582 * circleLineIn.superlayer!.bounds.height)
			circleLineIn.path  = circleLineInPathWithBounds((layers["circleLineIn"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let circleLineInStroke : CAShapeLayer = layers["circleLineInStroke"] as? CAShapeLayer{
			circleLineInStroke.frame = CGRectMake(0.21208 * circleLineInStroke.superlayer!.bounds.width, 0.16255 * circleLineInStroke.superlayer!.bounds.height, 0.57583 * circleLineInStroke.superlayer!.bounds.width, 0.44135 * circleLineInStroke.superlayer!.bounds.height)
			circleLineInStroke.path  = circleLineInStrokePathWithBounds((layers["circleLineInStroke"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let wordOutEntire : CALayer = layers["wordOutEntire"] as? CALayer{
			wordOutEntire.frame = CGRectMake(0.08583 * wordOutEntire.superlayer!.bounds.width, 0.06941 * wordOutEntire.superlayer!.bounds.height, 0.83333 * wordOutEntire.superlayer!.bounds.width, 0.6204 * wordOutEntire.superlayer!.bounds.height)
		}
		
		if let wordOutMask : CALayer = layers["wordOutMask"] as? CALayer{
			wordOutMask.frame = CGRectMake(0, 0,  wordOutMask.superlayer!.bounds.width, 1 * wordOutMask.superlayer!.bounds.height)
		}
		
		if let epicurrenceWord : CALayer = layers["epicurrenceWord"] as? CALayer{
			epicurrenceWord.frame = CGRectMake(0.0115 * epicurrenceWord.superlayer!.bounds.width, 0, 0.967 * epicurrenceWord.superlayer!.bounds.width, 0.4384 * epicurrenceWord.superlayer!.bounds.height)
		}
		
		if let path95 : CAShapeLayer = layers["path95"] as? CAShapeLayer{
			path95.frame = CGRectMake(0.09669 * path95.superlayer!.bounds.width, 0.42583 * path95.superlayer!.bounds.height, 0.08118 * path95.superlayer!.bounds.width, 0.14442 * path95.superlayer!.bounds.height)
			path95.path  = path95PathWithBounds((layers["path95"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path96 : CAShapeLayer = layers["path96"] as? CAShapeLayer{
			path96.frame = CGRectMake(0, 0.84736 * path96.superlayer!.bounds.height, 0.10031 * path96.superlayer!.bounds.width, 0.15264 * path96.superlayer!.bounds.height)
			path96.path  = path96PathWithBounds((layers["path96"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path97 : CAShapeLayer = layers["path97"] as? CAShapeLayer{
			path97.frame = CGRectMake(0.03723 * path97.superlayer!.bounds.width, 0.59341 * path97.superlayer!.bounds.height, 0.08738 * path97.superlayer!.bounds.width, 0.17997 * path97.superlayer!.bounds.height)
			path97.path  = path97PathWithBounds((layers["path97"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path98 : CAShapeLayer = layers["path98"] as? CAShapeLayer{
			path98.frame = CGRectMake(0.1788 * path98.superlayer!.bounds.width, 0.19452 * path98.superlayer!.bounds.height, 0.09679 * path98.superlayer!.bounds.width, 0.22199 * path98.superlayer!.bounds.height)
			path98.path  = path98PathWithBounds((layers["path98"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path99 : CAShapeLayer = layers["path99"] as? CAShapeLayer{
			path99.frame = CGRectMake(0.29266 * path99.superlayer!.bounds.width, 0.03718 * path99.superlayer!.bounds.height, 0.09059 * path99.superlayer!.bounds.width, 0.23743 * path99.superlayer!.bounds.height)
			path99.path  = path99PathWithBounds((layers["path99"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path100 : CAShapeLayer = layers["path100"] as? CAShapeLayer{
			path100.frame = CGRectMake(0.43692 * path100.superlayer!.bounds.width, 0, 0.06722 * path100.superlayer!.bounds.width, 0.21213 * path100.superlayer!.bounds.height)
			path100.path  = path100PathWithBounds((layers["path100"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path101 : CAShapeLayer = layers["path101"] as? CAShapeLayer{
			path101.frame = CGRectMake(0.55067 * path101.superlayer!.bounds.width, 0.00548 * path101.superlayer!.bounds.height, 0.06307 * path101.superlayer!.bounds.width, 0.23014 * path101.superlayer!.bounds.height)
			path101.path  = path101PathWithBounds((layers["path101"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path102 : CAShapeLayer = layers["path102"] as? CAShapeLayer{
			path102.frame = CGRectMake(0.65408 * path102.superlayer!.bounds.width, 0.07945 * path102.superlayer!.bounds.height, 0.08221 * path102.superlayer!.bounds.width, 0.23718 * path102.superlayer!.bounds.height)
			path102.path  = path102PathWithBounds((layers["path102"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path103 : CAShapeLayer = layers["path103"] as? CAShapeLayer{
			path103.frame = CGRectMake(0.74922 * path103.superlayer!.bounds.width, 0.22622 * path103.superlayer!.bounds.height, 0.11944 * path103.superlayer!.bounds.width, 0.28767 * path103.superlayer!.bounds.height)
			path103.path  = path103PathWithBounds((layers["path103"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path104 : CAShapeLayer = layers["path104"] as? CAShapeLayer{
			path104.frame = CGRectMake(0.85928 * path104.superlayer!.bounds.width, 0.53898 * path104.superlayer!.bounds.height, 0.09758 * path104.superlayer!.bounds.width, 0.21562 * path104.superlayer!.bounds.height)
			path104.path  = path104PathWithBounds((layers["path104"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path105 : CAShapeLayer = layers["path105"] as? CAShapeLayer{
			path105.frame = CGRectMake(0.89866 * path105.superlayer!.bounds.width, 0.84149 * path105.superlayer!.bounds.height, 0.10134 * path105.superlayer!.bounds.width, 0.15734 * path105.superlayer!.bounds.height)
			path105.path  = path105PathWithBounds((layers["path105"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let theMontuesWord : CALayer = layers["theMontuesWord"] as? CALayer{
			theMontuesWord.frame = CGRectMake(0.06 * theMontuesWord.superlayer!.bounds.width, 0.65305 * theMontuesWord.superlayer!.bounds.height, 0.87496 * theMontuesWord.superlayer!.bounds.width, 0.34695 * theMontuesWord.superlayer!.bounds.height)
		}
		
		if let path106 : CAShapeLayer = layers["path106"] as? CAShapeLayer{
			path106.frame = CGRectMake(0, 0, 0.09143 * path106.superlayer!.bounds.width, 0.17359 * path106.superlayer!.bounds.height)
			path106.path  = path106PathWithBounds((layers["path106"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path107 : CAShapeLayer = layers["path107"] as? CAShapeLayer{
			path107.frame = CGRectMake(0.04514 * path107.superlayer!.bounds.width, 0.23145 * path107.superlayer!.bounds.height, 0.108 * path107.superlayer!.bounds.width, 0.27003 * path107.superlayer!.bounds.height)
			path107.path  = path107PathWithBounds((layers["path107"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path108 : CAShapeLayer = layers["path108"] as? CAShapeLayer{
			path108.frame = CGRectMake(0.13315 * path108.superlayer!.bounds.width, 0.45994 * path108.superlayer!.bounds.height, 0.09086 * path108.superlayer!.bounds.width, 0.24629 * path108.superlayer!.bounds.height)
			path108.path  = path108PathWithBounds((layers["path108"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path109 : CAShapeLayer = layers["path109"] as? CAShapeLayer{
			path109.frame = CGRectMake(0.28973 * path109.superlayer!.bounds.width, 0.68398 * path109.superlayer!.bounds.height, 0.10058 * path109.superlayer!.bounds.width, 0.28042 * path109.superlayer!.bounds.height)
			path109.path  = path109PathWithBounds((layers["path109"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path110 : CAShapeLayer = layers["path110"] as? CAShapeLayer{
			path110.frame = CGRectMake(0.44283 * path110.superlayer!.bounds.width, 0.76706 * path110.superlayer!.bounds.height, 0.09153 * path110.superlayer!.bounds.width, 0.23294 * path110.superlayer!.bounds.height)
			path110.path  = path110PathWithBounds((layers["path110"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path111 : CAShapeLayer = layers["path111"] as? CAShapeLayer{
			path111.frame = CGRectMake(0.57888 * path111.superlayer!.bounds.width, 0.71068 * path111.superlayer!.bounds.height, 0.09315 * path111.superlayer!.bounds.width, 0.26113 * path111.superlayer!.bounds.height)
			path111.path  = path111PathWithBounds((layers["path111"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path112 : CAShapeLayer = layers["path112"] as? CAShapeLayer{
			path112.frame = CGRectMake(0.68746 * path112.superlayer!.bounds.width, 0.59941 * path112.superlayer!.bounds.height, 0.07086 * path112.superlayer!.bounds.width, 0.23887 * path112.superlayer!.bounds.height)
			path112.path  = path112PathWithBounds((layers["path112"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path113 : CAShapeLayer = layers["path113"] as? CAShapeLayer{
			path113.frame = CGRectMake(0.77375 * path113.superlayer!.bounds.width, 0.42582 * path113.superlayer!.bounds.height, 0.09632 * path113.superlayer!.bounds.width, 0.25544 * path113.superlayer!.bounds.height)
			path113.path  = path113PathWithBounds((layers["path113"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path114 : CAShapeLayer = layers["path114"] as? CAShapeLayer{
			path114.frame = CGRectMake(0.85775 * path114.superlayer!.bounds.width, 0.23442 * path114.superlayer!.bounds.height, 0.09543 * path114.superlayer!.bounds.width, 0.22849 * path114.superlayer!.bounds.height)
			path114.path  = path114PathWithBounds((layers["path114"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path115 : CAShapeLayer = layers["path115"] as? CAShapeLayer{
			path115.frame = CGRectMake(0.91287 * path115.superlayer!.bounds.width, 0.03561 * path115.superlayer!.bounds.height, 0.08713 * path115.superlayer!.bounds.width, 0.18089 * path115.superlayer!.bounds.height)
			path115.path  = path115PathWithBounds((layers["path115"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let noOneWord : CALayer = layers["noOneWord"] as? CALayer{
			noOneWord.frame = CGRectMake(0, 0.5429 * noOneWord.superlayer!.bounds.height, 0.1085 * noOneWord.superlayer!.bounds.width, 0.02883 * noOneWord.superlayer!.bounds.height)
		}
		
		if let path116 : CAShapeLayer = layers["path116"] as? CAShapeLayer{
			path116.frame = CGRectMake(0, 0, 0.20737 * path116.superlayer!.bounds.width, 0.98214 * path116.superlayer!.bounds.height)
			path116.path  = path116PathWithBounds((layers["path116"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path117 : CAShapeLayer = layers["path117"] as? CAShapeLayer{
			path117.frame = CGRectMake(0.33641 * path117.superlayer!.bounds.width, 0, 0.23963 * path117.superlayer!.bounds.width,  path117.superlayer!.bounds.height)
			path117.path  = path117PathWithBounds((layers["path117"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path118 : CAShapeLayer = layers["path118"] as? CAShapeLayer{
			path118.frame = CGRectMake(0.70046 * path118.superlayer!.bounds.width, 0.76786 * path118.superlayer!.bounds.height, 0.0553 * path118.superlayer!.bounds.width, 0.21429 * path118.superlayer!.bounds.height)
			path118.path  = path118PathWithBounds((layers["path118"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path119 : CAShapeLayer = layers["path119"] as? CAShapeLayer{
			path119.frame = CGRectMake(0.92166 * path119.superlayer!.bounds.width, 0.01786 * path119.superlayer!.bounds.height, 0.07834 * path119.superlayer!.bounds.width, 0.94643 * path119.superlayer!.bounds.height)
			path119.path  = path119PathWithBounds((layers["path119"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let yearWord : CALayer = layers["yearWord"] as? CALayer{
			yearWord.frame = CGRectMake(0.8905 * yearWord.superlayer!.bounds.width, 0.54187 * yearWord.superlayer!.bounds.height, 0.1095 * yearWord.superlayer!.bounds.width, 0.02986 * yearWord.superlayer!.bounds.height)
		}
		
		if let path120 : CAShapeLayer = layers["path120"] as? CAShapeLayer{
			path120.frame = CGRectMake(0, 0.01724 * path120.superlayer!.bounds.height, 0.16438 * path120.superlayer!.bounds.width, 0.94828 * path120.superlayer!.bounds.height)
			path120.path  = path120PathWithBounds((layers["path120"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path121 : CAShapeLayer = layers["path121"] as? CAShapeLayer{
			path121.frame = CGRectMake(0.27397 * path121.superlayer!.bounds.width, 0.03448 * path121.superlayer!.bounds.height, 0.17352 * path121.superlayer!.bounds.width, 0.96552 * path121.superlayer!.bounds.height)
			path121.path  = path121PathWithBounds((layers["path121"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path122 : CAShapeLayer = layers["path122"] as? CAShapeLayer{
			path122.frame = CGRectMake(0.59361 * path122.superlayer!.bounds.width, 0.05172 * path122.superlayer!.bounds.height, 0.07763 * path122.superlayer!.bounds.width, 0.91379 * path122.superlayer!.bounds.height)
			path122.path  = path122PathWithBounds((layers["path122"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path123 : CAShapeLayer = layers["path123"] as? CAShapeLayer{
			path123.frame = CGRectMake(0.82648 * path123.superlayer!.bounds.width, 0, 0.17352 * path123.superlayer!.bounds.width, 0.98276 * path123.superlayer!.bounds.height)
			path123.path  = path123PathWithBounds((layers["path123"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let circleInBlack : CAShapeLayer = layers["circleInBlack"] as? CAShapeLayer{
			circleInBlack.frame = CGRectMake(0.21542 * circleInBlack.superlayer!.bounds.width, 0.16511 * circleInBlack.superlayer!.bounds.height, 0.56917 * circleInBlack.superlayer!.bounds.width, 0.43624 * circleInBlack.superlayer!.bounds.height)
			circleInBlack.path  = circleInBlackPathWithBounds((layers["circleInBlack"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let wordInMask : CALayer = layers["wordInMask"] as? CALayer{
			wordInMask.frame = CGRectMake(0.21542 * wordInMask.superlayer!.bounds.width, 0.16511 * wordInMask.superlayer!.bounds.height, 0.56917 * wordInMask.superlayer!.bounds.width, 0.43624 * wordInMask.superlayer!.bounds.height)
		}
		
		if let wordIn : CALayer = layers["wordIn"] as? CALayer{
			wordIn.frame = CGRectMake(0.09663 * wordIn.superlayer!.bounds.width, 0.09956 * wordIn.superlayer!.bounds.height, 0.8082 * wordIn.superlayer!.bounds.width, 0.80527 * wordIn.superlayer!.bounds.height)
		}
		
		if let path67 : CAShapeLayer = layers["path67"] as? CAShapeLayer{
			path67.frame = CGRectMake(0.81884 * path67.superlayer!.bounds.width, 0.75091 * path67.superlayer!.bounds.height, 0.08243 * path67.superlayer!.bounds.width, 0.05 * path67.superlayer!.bounds.height)
			path67.path  = path67PathWithBounds((layers["path67"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path68 : CAShapeLayer = layers["path68"] as? CAShapeLayer{
			path68.frame = CGRectMake(0.74909 * path68.superlayer!.bounds.width, 0.80636 * path68.superlayer!.bounds.height, 0.07337 * path68.superlayer!.bounds.width, 0.07818 * path68.superlayer!.bounds.height)
			path68.path  = path68PathWithBounds((layers["path68"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path69 : CAShapeLayer = layers["path69"] as? CAShapeLayer{
			path69.frame = CGRectMake(0.6721 * path69.superlayer!.bounds.width, 0.86818 * path69.superlayer!.bounds.height, 0.07699 * path69.superlayer!.bounds.width, 0.08455 * path69.superlayer!.bounds.height)
			path69.path  = path69PathWithBounds((layers["path69"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path70 : CAShapeLayer = layers["path70"] as? CAShapeLayer{
			path70.frame = CGRectMake(0.5933 * path70.superlayer!.bounds.width, 0.90455 * path70.superlayer!.bounds.height, 0.0625 * path70.superlayer!.bounds.width, 0.08091 * path70.superlayer!.bounds.height)
			path70.path  = path70PathWithBounds((layers["path70"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path71 : CAShapeLayer = layers["path71"] as? CAShapeLayer{
			path71.frame = CGRectMake(0.46105 * path71.superlayer!.bounds.width, 0.92727 * path71.superlayer!.bounds.height, 0.05254 * path71.superlayer!.bounds.width, 0.07273 * path71.superlayer!.bounds.height)
			path71.path  = path71PathWithBounds((layers["path71"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path72 : CAShapeLayer = layers["path72"] as? CAShapeLayer{
			path72.frame = CGRectMake(0.37772 * path72.superlayer!.bounds.width, 0.91 * path72.superlayer!.bounds.height, 0.0625 * path72.superlayer!.bounds.width, 0.07818 * path72.superlayer!.bounds.height)
			path72.path  = path72PathWithBounds((layers["path72"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path73 : CAShapeLayer = layers["path73"] as? CAShapeLayer{
			path73.frame = CGRectMake(0.2654 * path73.superlayer!.bounds.width, 0.87636 * path73.superlayer!.bounds.height, 0.07699 * path73.superlayer!.bounds.width, 0.08727 * path73.superlayer!.bounds.height)
			path73.path  = path73PathWithBounds((layers["path73"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path74 : CAShapeLayer = layers["path74"] as? CAShapeLayer{
			path74.frame = CGRectMake(0.17594 * path74.superlayer!.bounds.width, 0.82641 * path74.superlayer!.bounds.height, 0.07113 * path74.superlayer!.bounds.width, 0.0733 * path74.superlayer!.bounds.height)
			path74.path  = path74PathWithBounds((layers["path74"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path75 : CAShapeLayer = layers["path75"] as? CAShapeLayer{
			path75.frame = CGRectMake(0.09511 * path75.superlayer!.bounds.width, 0.74818 * path75.superlayer!.bounds.height, 0.08333 * path75.superlayer!.bounds.width, 0.08 * path75.superlayer!.bounds.height)
			path75.path  = path75PathWithBounds((layers["path75"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path76 : CAShapeLayer = layers["path76"] as? CAShapeLayer{
			path76.frame = CGRectMake(0.02258 * path76.superlayer!.bounds.width, 0.61702 * path76.superlayer!.bounds.height, 0.07451 * path76.superlayer!.bounds.width, 0.06237 * path76.superlayer!.bounds.height)
			path76.path  = path76PathWithBounds((layers["path76"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path77 : CAShapeLayer = layers["path77"] as? CAShapeLayer{
			path77.frame = CGRectMake(0.00181 * path77.superlayer!.bounds.width, 0.51636 * path77.superlayer!.bounds.height, 0.07609 * path77.superlayer!.bounds.width, 0.06455 * path77.superlayer!.bounds.height)
			path77.path  = path77PathWithBounds((layers["path77"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path78 : CAShapeLayer = layers["path78"] as? CAShapeLayer{
			path78.frame = CGRectMake(0, 0.43545 * path78.superlayer!.bounds.height, 0.07609 * path78.superlayer!.bounds.width, 0.04364 * path78.superlayer!.bounds.height)
			path78.path  = path78PathWithBounds((layers["path78"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path79 : CAShapeLayer = layers["path79"] as? CAShapeLayer{
			path79.frame = CGRectMake(0.01359 * path79.superlayer!.bounds.width, 0.37182 * path79.superlayer!.bounds.height, 0.07156 * path79.superlayer!.bounds.width, 0.02364 * path79.superlayer!.bounds.height)
			path79.path  = path79PathWithBounds((layers["path79"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path80 : CAShapeLayer = layers["path80"] as? CAShapeLayer{
			path80.frame = CGRectMake(0.03261 * path80.superlayer!.bounds.width, 0.27727 * path80.superlayer!.bounds.height, 0.06884 * path80.superlayer!.bounds.width, 0.06636 * path80.superlayer!.bounds.height)
			path80.path  = path80PathWithBounds((layers["path80"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path81 : CAShapeLayer = layers["path81"] as? CAShapeLayer{
			path81.frame = CGRectMake(0.08615 * path81.superlayer!.bounds.width, 0.19036 * path81.superlayer!.bounds.height, 0.07316 * path81.superlayer!.bounds.width, 0.07019 * path81.superlayer!.bounds.height)
			path81.path  = path81PathWithBounds((layers["path81"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path82 : CAShapeLayer = layers["path82"] as? CAShapeLayer{
			path82.frame = CGRectMake(0.15399 * path82.superlayer!.bounds.width, 0.10978 * path82.superlayer!.bounds.height, 0.08605 * path82.superlayer!.bounds.width, 0.07841 * path82.superlayer!.bounds.height)
			path82.path  = path82PathWithBounds((layers["path82"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path83 : CAShapeLayer = layers["path83"] as? CAShapeLayer{
			path83.frame = CGRectMake(0.23913 * path83.superlayer!.bounds.width, 0.04273 * path83.superlayer!.bounds.height, 0.08152 * path83.superlayer!.bounds.width, 0.08818 * path83.superlayer!.bounds.height)
			path83.path  = path83PathWithBounds((layers["path83"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path84 : CAShapeLayer = layers["path84"] as? CAShapeLayer{
			path84.frame = CGRectMake(0.34149 * path84.superlayer!.bounds.width, 0.01818 * path84.superlayer!.bounds.height, 0.02899 * path84.superlayer!.bounds.width, 0.07091 * path84.superlayer!.bounds.height)
			path84.path  = path84PathWithBounds((layers["path84"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path85 : CAShapeLayer = layers["path85"] as? CAShapeLayer{
			path85.frame = CGRectMake(0.40761 * path85.superlayer!.bounds.width, 0, 0.06341 * path85.superlayer!.bounds.width, 0.07636 * path85.superlayer!.bounds.height)
			path85.path  = path85PathWithBounds((layers["path85"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path86 : CAShapeLayer = layers["path86"] as? CAShapeLayer{
			path86.frame = CGRectMake(0.56431 * path86.superlayer!.bounds.width, 0.00091 * path86.superlayer!.bounds.height, 0.06793 * path86.superlayer!.bounds.width, 0.08364 * path86.superlayer!.bounds.height)
			path86.path  = path86PathWithBounds((layers["path86"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path87 : CAShapeLayer = layers["path87"] as? CAShapeLayer{
			path87.frame = CGRectMake(0.66783 * path87.superlayer!.bounds.width, 0.0401 * path87.superlayer!.bounds.height, 0.06854 * path87.superlayer!.bounds.width, 0.07539 * path87.superlayer!.bounds.height)
			path87.path  = path87PathWithBounds((layers["path87"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path88 : CAShapeLayer = layers["path88"] as? CAShapeLayer{
			path88.frame = CGRectMake(0.75091 * path88.superlayer!.bounds.width, 0.09273 * path88.superlayer!.bounds.height, 0.07515 * path88.superlayer!.bounds.width, 0.08727 * path88.superlayer!.bounds.height)
			path88.path  = path88PathWithBounds((layers["path88"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path89 : CAShapeLayer = layers["path89"] as? CAShapeLayer{
			path89.frame = CGRectMake(0.8288 * path89.superlayer!.bounds.width, 0.15818 * path89.superlayer!.bounds.height, 0.07337 * path89.superlayer!.bounds.width, 0.06909 * path89.superlayer!.bounds.height)
			path89.path  = path89PathWithBounds((layers["path89"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path90 : CAShapeLayer = layers["path90"] as? CAShapeLayer{
			path90.frame = CGRectMake(0.86775 * path90.superlayer!.bounds.width, 0.24273 * path90.superlayer!.bounds.height, 0.08786 * path90.superlayer!.bounds.width, 0.07909 * path90.superlayer!.bounds.height)
			path90.path  = path90PathWithBounds((layers["path90"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path91 : CAShapeLayer = layers["path91"] as? CAShapeLayer{
			path91.frame = CGRectMake(0.90964 * path91.superlayer!.bounds.width, 0.34924 * path91.superlayer!.bounds.height, 0.07548 * path91.superlayer!.bounds.width, 0.05779 * path91.superlayer!.bounds.height)
			path91.path  = path91PathWithBounds((layers["path91"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path92 : CAShapeLayer = layers["path92"] as? CAShapeLayer{
			path92.frame = CGRectMake(0.92572 * path92.superlayer!.bounds.width, 0.43818 * path92.superlayer!.bounds.height, 0.07428 * path92.superlayer!.bounds.width, 0.05273 * path92.superlayer!.bounds.height)
			path92.path  = path92PathWithBounds((layers["path92"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path93 : CAShapeLayer = layers["path93"] as? CAShapeLayer{
			path93.frame = CGRectMake(0.91938 * path93.superlayer!.bounds.width, 0.51727 * path93.superlayer!.bounds.height, 0.07609 * path93.superlayer!.bounds.width, 0.06455 * path93.superlayer!.bounds.height)
			path93.path  = path93PathWithBounds((layers["path93"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let path94 : CAShapeLayer = layers["path94"] as? CAShapeLayer{
			path94.frame = CGRectMake(0.89402 * path94.superlayer!.bounds.width, 0.61909 * path94.superlayer!.bounds.height, 0.08424 * path94.superlayer!.bounds.width, 0.0634 * path94.superlayer!.bounds.height)
			path94.path  = path94PathWithBounds((layers["path94"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let circleInMask : CAShapeLayer = layers["circleInMask"] as? CAShapeLayer{
			circleInMask.frame = CGRectMake(0, 0,  circleInMask.superlayer!.bounds.width, 1 * circleInMask.superlayer!.bounds.height)
			circleInMask.path  = circleInMaskPathWithBounds((layers["circleInMask"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let wordOut : CALayer = layers["wordOut"] as? CALayer{
			wordOut.frame = CGRectMake(0.5025 * wordOut.superlayer!.bounds.width, 0.84032 * wordOut.superlayer!.bounds.height, 0.20833 * wordOut.superlayer!.bounds.width, 0.15968 * wordOut.superlayer!.bounds.height)
		}
		
		if let markAnimate : CALayer = layers["markAnimate"] as? CALayer{
			markAnimate.frame = CGRectMake(0.485 * markAnimate.superlayer!.bounds.width, 0.30051 * markAnimate.superlayer!.bounds.height, 0.03125 * markAnimate.superlayer!.bounds.width, 0.16351 * markAnimate.superlayer!.bounds.height)
		}
		
		if let markEnd : CAShapeLayer = layers["markEnd"] as? CAShapeLayer{
			markEnd.frame = CGRectMake(0, 0,  markEnd.superlayer!.bounds.width,  markEnd.superlayer!.bounds.height)
			markEnd.path  = markEndPathWithBounds((layers["markEnd"] as! CAShapeLayer).bounds).CGPath;
		}
		
		if let markStart : CAShapeLayer = layers["markStart"] as? CAShapeLayer{
			markStart.frame = CGRectMake(0.38 * markStart.superlayer!.bounds.width, 0.00391 * markStart.superlayer!.bounds.height, 0.2 * markStart.superlayer!.bounds.width, 0.99219 * markStart.superlayer!.bounds.height)
			markStart.path  = markStartPathWithBounds((layers["markStart"] as! CAShapeLayer).bounds).CGPath;
		}
		
		CATransaction.commit()
	}
	
	//MARK: - Animation Setup
	
	func addIntroAnimation(){
		addIntroAnimationCompletionBlock(nil)
	}
	
	func addIntroAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
		addIntroAnimationTotalDuration(3, completionBlock:completionBlock)
	}
	
	func addIntroAnimationTotalDuration(totalDuration: CFTimeInterval, completionBlock: ((finished: Bool) -> Void)?){
		if completionBlock != nil{
			let completionAnim = CABasicAnimation(keyPath:"completionAnim")
			completionAnim.duration = totalDuration
			completionAnim.delegate = self
			completionAnim.setValue("intro", forKey:"animId")
			completionAnim.setValue(false, forKey:"needEndAnim")
			layer.addAnimation(completionAnim, forKey:"intro")
			if let anim = layer.animationForKey("intro"){
				completionBlocks[anim] = completionBlock
			}
		}
		
		resetLayerPropertiesForLayerIdentifiers(["wholeLogo", "animateMainCircle", "mainCircle", "circleLineOut", "circleLineIn", "wordOutMask", "wordIn", "markAnimate", "markStart"])
		
		self.layer.speed = 1
//		self.animationAdded = false
		
		let fillMode : String = kCAFillModeForwards
		
		let wholeLogo = layers["wholeLogo"] as! CALayer
		
		////WholeLogo animation
		let wholeLogoTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		wholeLogoTransformAnim.values         = [NSValue(CATransform3D: CATransform3DMakeScale(2, 2, 1)), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		wholeLogoTransformAnim.keyTimes       = [0, 1]
		wholeLogoTransformAnim.duration       = totalDuration
		wholeLogoTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
		
		let wholeLogoIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([wholeLogoTransformAnim], fillMode:fillMode)
		wholeLogo.addAnimation(wholeLogoIntroAnim, forKey:"wholeLogoIntroAnim")
		
		let animateMainCircle = layers["animateMainCircle"] as! CALayer
		
		////AnimateMainCircle animation
		let animateMainCircleTransformAnim    = CAKeyframeAnimation(keyPath:"transform")
		animateMainCircleTransformAnim.values = [NSValue(CATransform3D: CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, -1)), 
			 NSValue(CATransform3D: CATransform3DMakeScale(0.25, 0.25, 1))]
		animateMainCircleTransformAnim.keyTimes = [0, 1]
		animateMainCircleTransformAnim.duration = 0.75 * totalDuration
		animateMainCircleTransformAnim.beginTime = 0.167 * totalDuration
		animateMainCircleTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
		
		let animateMainCircleIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([animateMainCircleTransformAnim], fillMode:fillMode)
		animateMainCircle.addAnimation(animateMainCircleIntroAnim, forKey:"animateMainCircleIntroAnim")
		
		let mainCircle = layers["mainCircle"] as! CAShapeLayer
		
		////MainCircle animation
		let mainCircleTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		mainCircleTransformAnim.values   = [NSValue(CATransform3D: CATransform3DMakeScale(4, 4, 1)), 
			 NSValue(CATransform3D: CATransform3DMakeScale(4, 4, 1))]
		mainCircleTransformAnim.keyTimes = [0, 1]
		mainCircleTransformAnim.duration = 0.917 * totalDuration
		
		let mainCircleIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([mainCircleTransformAnim], fillMode:fillMode)
		mainCircle.addAnimation(mainCircleIntroAnim, forKey:"mainCircleIntroAnim")
		
		let circleLineOut = layers["circleLineOut"] as! CAShapeLayer
		
		////CircleLineOut animation
		let circleLineOutTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
		circleLineOutTransformAnim.values    = [NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(2, 2, 1), CATransform3DMakeRotation(-CGFloat(M_PI_4), 0, 0, 1))), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		circleLineOutTransformAnim.keyTimes  = [0, 1]
		circleLineOutTransformAnim.duration  = 0.608 * totalDuration
		circleLineOutTransformAnim.beginTime = 0.167 * totalDuration
		circleLineOutTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
		
		let circleLineOutOpacityAnim       = CAKeyframeAnimation(keyPath:"opacity")
		circleLineOutOpacityAnim.values    = [0, 1]
		circleLineOutOpacityAnim.keyTimes  = [0, 1]
		circleLineOutOpacityAnim.duration  = 0.608 * totalDuration
		circleLineOutOpacityAnim.beginTime = 0.167 * totalDuration
		circleLineOutOpacityAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0.25, 1)
		
		let circleLineOutIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([circleLineOutTransformAnim, circleLineOutOpacityAnim], fillMode:fillMode)
		circleLineOut.addAnimation(circleLineOutIntroAnim, forKey:"circleLineOutIntroAnim")
		
		////CircleLineIn animation
		let circleLineInOpacityAnim            = CAKeyframeAnimation(keyPath:"opacity")
		circleLineInOpacityAnim.values         = [0, 1]
		circleLineInOpacityAnim.keyTimes       = [0, 1]
		circleLineInOpacityAnim.duration       = 0.5 * totalDuration
		circleLineInOpacityAnim.beginTime      = 0.167 * totalDuration
		circleLineInOpacityAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
		
		let circleLineInIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([circleLineInOpacityAnim], fillMode:fillMode)
		layers["circleLineIn"]?.addAnimation(circleLineInIntroAnim, forKey:"circleLineInIntroAnim")
		
		let wordOutMask = layers["wordOutMask"] as! CALayer
		
		////WordOutMask animation
		let wordOutMaskTransformAnim       = CAKeyframeAnimation(keyPath:"transform")
		wordOutMaskTransformAnim.values    = [NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(0.7, 0.7, 1), CATransform3DMakeRotation(-CGFloat(M_PI_4), 0, 0, 1))), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		wordOutMaskTransformAnim.keyTimes  = [0, 1]
		wordOutMaskTransformAnim.duration  = 0.608 * totalDuration
		wordOutMaskTransformAnim.beginTime = 0.167 * totalDuration
		wordOutMaskTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
		
		let wordOutMaskOpacityAnim            = CAKeyframeAnimation(keyPath:"opacity")
		wordOutMaskOpacityAnim.values         = [0, 1]
		wordOutMaskOpacityAnim.keyTimes       = [0, 1]
		wordOutMaskOpacityAnim.duration       = 0.608 * totalDuration
		wordOutMaskOpacityAnim.beginTime      = 0.167 * totalDuration
		wordOutMaskOpacityAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0.25, 1)
		
		let wordOutMaskIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([wordOutMaskTransformAnim, wordOutMaskOpacityAnim], fillMode:fillMode)
		wordOutMask.addAnimation(wordOutMaskIntroAnim, forKey:"wordOutMaskIntroAnim")
		
		let wordIn = layers["wordIn"] as! CALayer
		
		////WordIn animation
		let wordInTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		wordInTransformAnim.values         = [NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.6, 1.6, 1), CATransform3DMakeRotation(45 * CGFloat(M_PI/180), 0, -0, 1))), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		wordInTransformAnim.keyTimes       = [0, 1]
		wordInTransformAnim.duration       = 0.5 * totalDuration
		wordInTransformAnim.beginTime      = 0.167 * totalDuration
		wordInTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 1, 1, 1)
		
		let wordInOpacityAnim            = CAKeyframeAnimation(keyPath:"opacity")
		wordInOpacityAnim.values         = [0, 1]
		wordInOpacityAnim.keyTimes       = [0, 1]
		wordInOpacityAnim.duration       = 0.5 * totalDuration
		wordInOpacityAnim.beginTime      = 0.167 * totalDuration
		wordInOpacityAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0, 1)
		
		let wordInIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([wordInTransformAnim, wordInOpacityAnim], fillMode:fillMode)
		wordIn.addAnimation(wordInIntroAnim, forKey:"wordInIntroAnim")
		
		let markAnimate = layers["markAnimate"] as! CALayer
		
		////MarkAnimate animation
		let markAnimateTransformAnim      = CAKeyframeAnimation(keyPath:"transform")
		markAnimateTransformAnim.values   = [NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(4, 4, 1), CATransform3DMakeRotation(-CGFloat(M_PI), 0, 0, 1))), 
			 NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(0.666, 0.666, 1), CATransform3DMakeRotation(-CGFloat(M_PI), 0, 0, 0)))]
		markAnimateTransformAnim.keyTimes = [0, 1]
		markAnimateTransformAnim.duration = 0.667 * totalDuration
		markAnimateTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 1, 1, 1)
		
		let markAnimateIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([markAnimateTransformAnim], fillMode:fillMode)
		markAnimate.addAnimation(markAnimateIntroAnim, forKey:"markAnimateIntroAnim")
		
		////MarkStart animation
		let markStartPathAnim            = CAKeyframeAnimation(keyPath:"path")
		markStartPathAnim.values         = [QCMethod.alignToBottomPath(markStartPathWithBounds((layers["markStart"] as! CAShapeLayer).bounds), layer:layers["markStart"] as! CALayer).CGPath, QCMethod.alignToBottomPath(markEndPathWithBounds((layers["markEnd"] as! CAShapeLayer).bounds), layer:layers["markStart"] as! CALayer).CGPath]
		markStartPathAnim.keyTimes       = [0, 1]
		markStartPathAnim.duration       = 0.583 * totalDuration
		markStartPathAnim.beginTime      = 0.083 * totalDuration
		markStartPathAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.7, 0, 0.3, 1)
		
		let markStart = layers["markStart"] as! CAShapeLayer
		
		let markStartAnchorPointAnim       = CAKeyframeAnimation(keyPath:"anchorPoint")
		markStartAnchorPointAnim.values    = [NSValue(CGPoint: CGPointMake(0.5, 0.75)), NSValue(CGPoint: CGPointMake(2.0, 0.75))]
		markStartAnchorPointAnim.keyTimes  = [0, 1]
		markStartAnchorPointAnim.duration  = 0.583 * totalDuration
		markStartAnchorPointAnim.beginTime = 0.083 * totalDuration
		markStartAnchorPointAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.7, 0, 0.3, 1)
		
		let markStartTransformAnim            = CAKeyframeAnimation(keyPath:"transform")
		markStartTransformAnim.values         = [NSValue(CATransform3D: CATransform3DMakeScale(1, 0, 1)), 
			 NSValue(CATransform3D: CATransform3DIdentity)]
		markStartTransformAnim.keyTimes       = [0, 1]
		markStartTransformAnim.duration       = 0.333 * totalDuration
		markStartTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0, 1, 1, 1)
		
		let markStartIntroAnim : CAAnimationGroup = QCMethod.groupAnimations([markStartPathAnim, markStartAnchorPointAnim, markStartTransformAnim], fillMode:fillMode)
		markStart.addAnimation(markStartIntroAnim, forKey:"markStartIntroAnim")
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
		if identifier == "intro"{
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["wholeLogo"] as! CALayer).animationForKey("wholeLogoIntroAnim"), theLayer:(layers["wholeLogo"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["animateMainCircle"] as! CALayer).animationForKey("animateMainCircleIntroAnim"), theLayer:(layers["animateMainCircle"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["mainCircle"] as! CALayer).animationForKey("mainCircleIntroAnim"), theLayer:(layers["mainCircle"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["circleLineOut"] as! CALayer).animationForKey("circleLineOutIntroAnim"), theLayer:(layers["circleLineOut"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["circleLineIn"] as! CALayer).animationForKey("circleLineInIntroAnim"), theLayer:(layers["circleLineIn"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["wordOutMask"] as! CALayer).animationForKey("wordOutMaskIntroAnim"), theLayer:(layers["wordOutMask"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["wordIn"] as! CALayer).animationForKey("wordInIntroAnim"), theLayer:(layers["wordIn"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["markAnimate"] as! CALayer).animationForKey("markAnimateIntroAnim"), theLayer:(layers["markAnimate"] as! CALayer))
			QCMethod.updateValueFromPresentationLayerForAnimation((layers["markStart"] as! CALayer).animationForKey("markStartIntroAnim"), theLayer:(layers["markStart"] as! CALayer))
		}
	}
	
	func removeAnimationsForAnimationId(identifier: String){
		if identifier == "intro"{
			(layers["wholeLogo"] as! CALayer).removeAnimationForKey("wholeLogoIntroAnim")
			(layers["animateMainCircle"] as! CALayer).removeAnimationForKey("animateMainCircleIntroAnim")
			(layers["mainCircle"] as! CALayer).removeAnimationForKey("mainCircleIntroAnim")
			(layers["circleLineOut"] as! CALayer).removeAnimationForKey("circleLineOutIntroAnim")
			(layers["circleLineIn"] as! CALayer).removeAnimationForKey("circleLineInIntroAnim")
			(layers["wordOutMask"] as! CALayer).removeAnimationForKey("wordOutMaskIntroAnim")
			(layers["wordIn"] as! CALayer).removeAnimationForKey("wordInIntroAnim")
			(layers["markAnimate"] as! CALayer).removeAnimationForKey("markAnimateIntroAnim")
			(layers["markStart"] as! CALayer).removeAnimationForKey("markStartIntroAnim")
		}
	}
	
	func removeAllAnimations(){
		for layer in layers.values{
			(layer as! CALayer).removeAllAnimations()
		}
	}
	
	//MARK: - Bezier Path
	
	func mainCirclePathWithBounds(bound: CGRect) -> UIBezierPath{
		let mainCirclePath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		mainCirclePath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		mainCirclePath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.77614 * h), controlPoint2:CGPointMake(minX + 0.77614 * w, minY + h))
		mainCirclePath.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.22386 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.77614 * h))
		mainCirclePath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.22386 * h), controlPoint2:CGPointMake(minX + 0.22386 * w, minY))
		mainCirclePath.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.77614 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.22386 * h))
		mainCirclePath.closePath()
		mainCirclePath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		
		return mainCirclePath;
	}
	
	func circleLineOutPathWithBounds(bound: CGRect) -> UIBezierPath{
		let circleLineOutPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		circleLineOutPath.moveToPoint(CGPointMake(minX + 0.5 * w, minY + h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.14634 * w, minY + 0.85366 * h), controlPoint1:CGPointMake(minX + 0.36631 * w, minY + h), controlPoint2:CGPointMake(minX + 0.24074 * w, minY + 0.94806 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.05194 * w, minY + 0.75926 * h), controlPoint2:CGPointMake(minX, minY + 0.63369 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.14634 * w, minY + 0.14634 * h), controlPoint1:CGPointMake(minX, minY + 0.36631 * h), controlPoint2:CGPointMake(minX + 0.05194 * w, minY + 0.24074 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX + 0.24074 * w, minY + 0.05194 * h), controlPoint2:CGPointMake(minX + 0.36631 * w, minY))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.85366 * w, minY + 0.14634 * h), controlPoint1:CGPointMake(minX + 0.63369 * w, minY), controlPoint2:CGPointMake(minX + 0.75926 * w, minY + 0.05194 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.94806 * w, minY + 0.24074 * h), controlPoint2:CGPointMake(minX + w, minY + 0.36631 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.85366 * w, minY + 0.85366 * h), controlPoint1:CGPointMake(minX + w, minY + 0.63369 * h), controlPoint2:CGPointMake(minX + 0.94806 * w, minY + 0.75926 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + 0.75926 * w, minY + 0.94806 * h), controlPoint2:CGPointMake(minX + 0.63369 * w, minY + h))
		circleLineOutPath.closePath()
		circleLineOutPath.moveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.00678 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.15131 * w, minY + 0.15131 * h), controlPoint1:CGPointMake(minX + 0.36811 * w, minY + 0.00678 * h), controlPoint2:CGPointMake(minX + 0.24435 * w, minY + 0.05827 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.00678 * w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.05827 * w, minY + 0.24435 * h), controlPoint2:CGPointMake(minX + 0.00678 * w, minY + 0.36811 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.15131 * w, minY + 0.84869 * h), controlPoint1:CGPointMake(minX + 0.00678 * w, minY + 0.63189 * h), controlPoint2:CGPointMake(minX + 0.05827 * w, minY + 0.75565 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.99322 * h), controlPoint1:CGPointMake(minX + 0.24435 * w, minY + 0.94173 * h), controlPoint2:CGPointMake(minX + 0.36811 * w, minY + 0.99322 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.84869 * w, minY + 0.84869 * h), controlPoint1:CGPointMake(minX + 0.63189 * w, minY + 0.99322 * h), controlPoint2:CGPointMake(minX + 0.75565 * w, minY + 0.94173 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.99322 * w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.94173 * w, minY + 0.75565 * h), controlPoint2:CGPointMake(minX + 0.99322 * w, minY + 0.63189 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.84869 * w, minY + 0.15131 * h), controlPoint1:CGPointMake(minX + 0.99322 * w, minY + 0.36811 * h), controlPoint2:CGPointMake(minX + 0.94173 * w, minY + 0.24435 * h))
		circleLineOutPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.00678 * h), controlPoint1:CGPointMake(minX + 0.75565 * w, minY + 0.05827 * h), controlPoint2:CGPointMake(minX + 0.63189 * w, minY + 0.00678 * h))
		circleLineOutPath.closePath()
		circleLineOutPath.moveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.00678 * h))
		
		return circleLineOutPath;
	}
	
	func circleLineInPathWithBounds(bound: CGRect) -> UIBezierPath{
		let circleLineInPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		circleLineInPath.moveToPoint(CGPointMake(minX + 0.5 * w, minY + h))
		circleLineInPath.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.22421 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.77579 * h))
		circleLineInPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.22421 * h), controlPoint2:CGPointMake(minX + 0.22421 * w, minY))
		circleLineInPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.77579 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.22421 * h))
		circleLineInPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.77579 * h), controlPoint2:CGPointMake(minX + 0.77579 * w, minY + h))
		circleLineInPath.closePath()
		circleLineInPath.moveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.01074 * h))
		circleLineInPath.addCurveToPoint(CGPointMake(minX + 0.01074 * w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.22994 * w, minY + 0.01074 * h), controlPoint2:CGPointMake(minX + 0.01074 * w, minY + 0.23066 * h))
		circleLineInPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.98926 * h), controlPoint1:CGPointMake(minX + 0.01074 * w, minY + 0.77006 * h), controlPoint2:CGPointMake(minX + 0.23066 * w, minY + 0.98926 * h))
		circleLineInPath.addCurveToPoint(CGPointMake(minX + 0.98926 * w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.77006 * w, minY + 0.98926 * h), controlPoint2:CGPointMake(minX + 0.98926 * w, minY + 0.76934 * h))
		circleLineInPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.01074 * h), controlPoint1:CGPointMake(minX + 0.98926 * w, minY + 0.22994 * h), controlPoint2:CGPointMake(minX + 0.77006 * w, minY + 0.01074 * h))
		circleLineInPath.closePath()
		circleLineInPath.moveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.01074 * h))
		
		return circleLineInPath;
	}
	
	func circleLineInStrokePathWithBounds(bound: CGRect) -> UIBezierPath{
		let circleLineInStrokePath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		circleLineInStrokePath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		circleLineInStrokePath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.77614 * h), controlPoint2:CGPointMake(minX + 0.77614 * w, minY + h))
		circleLineInStrokePath.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.22386 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.77614 * h))
		circleLineInStrokePath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.22386 * h), controlPoint2:CGPointMake(minX + 0.22386 * w, minY))
		circleLineInStrokePath.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.77614 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.22386 * h))
		circleLineInStrokePath.closePath()
		circleLineInStrokePath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		
		return circleLineInStrokePath;
	}
	
	func path95PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path95Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path95Path.moveToPoint(CGPointMake(minX + 0.93631 * w, minY + h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.70701 * w, minY + 0.66667 * h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.63057 * w, minY + 0.77236 * h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.36943 * w, minY + 0.39837 * h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.29299 * w, minY + 0.50407 * h))
		path95Path.addLineToPoint(CGPointMake(minX, minY + 0.07317 * h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.07006 * w, minY))
		path95Path.addLineToPoint(CGPointMake(minX + 0.29299 * w, minY + 0.33333 * h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.36943 * w, minY + 0.22764 * h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.63057 * w, minY + 0.60163 * h))
		path95Path.addLineToPoint(CGPointMake(minX + 0.70701 * w, minY + 0.49593 * h))
		path95Path.addLineToPoint(CGPointMake(minX + w, minY + 0.92683 * h))
		path95Path.closePath()
		path95Path.moveToPoint(CGPointMake(minX + 0.93631 * w, minY + h))
		
		return path95Path;
	}
	
	func path96PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path96Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path96Path.moveToPoint(CGPointMake(minX, minY + 0.70769 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.10309 * w, minY))
		path96Path.addLineToPoint(CGPointMake(minX + 0.20103 * w, minY + 0.03077 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.11856 * w, minY + 0.57692 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.37629 * w, minY + 0.66154 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.45876 * w, minY + 0.11538 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.5567 * w, minY + 0.14615 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.47423 * w, minY + 0.69231 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.81959 * w, minY + 0.80769 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.90206 * w, minY + 0.26154 * h))
		path96Path.addLineToPoint(CGPointMake(minX + w, minY + 0.29231 * h))
		path96Path.addLineToPoint(CGPointMake(minX + 0.89691 * w, minY + h))
		path96Path.addLineToPoint(CGPointMake(minX, minY + 0.70769 * h))
		path96Path.closePath()
		path96Path.moveToPoint(CGPointMake(minX, minY + 0.70769 * h))
		
		return path96Path;
	}
	
	func path97PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path97Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path97Path.moveToPoint(CGPointMake(minX + w, minY + 0.87604 * h))
		path97Path.addLineToPoint(CGPointMake(minX + 0.94675 * w, minY + h))
		path97Path.addLineToPoint(CGPointMake(minX, minY + 0.47807 * h))
		path97Path.addLineToPoint(CGPointMake(minX + 0.08284 * w, minY + 0.29539 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.10059 * w, minY + 0.26277 * h), controlPoint1:CGPointMake(minX + 0.08876 * w, minY + 0.28234 * h), controlPoint2:CGPointMake(minX + 0.09467 * w, minY + 0.2693 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.26627 * w, minY + 0.0279 * h), controlPoint1:CGPointMake(minX + 0.14793 * w, minY + 0.15839 * h), controlPoint2:CGPointMake(minX + 0.18935 * w, minY + 0.07357 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.52663 * w, minY + 0.04095 * h), controlPoint1:CGPointMake(minX + 0.33728 * w, minY + -0.01124 * h), controlPoint2:CGPointMake(minX + 0.43787 * w, minY + -0.01124 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.69231 * w, minY + 0.26277 * h), controlPoint1:CGPointMake(minX + 0.6213 * w, minY + 0.09314 * h), controlPoint2:CGPointMake(minX + 0.68047 * w, minY + 0.17796 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.6213 * w, minY + 0.54983 * h), controlPoint1:CGPointMake(minX + 0.70414 * w, minY + 0.36063 * h), controlPoint2:CGPointMake(minX + 0.66864 * w, minY + 0.44545 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.60355 * w, minY + 0.58245 * h), controlPoint1:CGPointMake(minX + 0.61538 * w, minY + 0.56288 * h), controlPoint2:CGPointMake(minX + 0.60947 * w, minY + 0.57593 * h))
		path97Path.addLineToPoint(CGPointMake(minX + 0.57396 * w, minY + 0.6477 * h))
		path97Path.addLineToPoint(CGPointMake(minX + w, minY + 0.87604 * h))
		path97Path.closePath()
		path97Path.moveToPoint(CGPointMake(minX + 0.50296 * w, minY + 0.51721 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.47337 * w, minY + 0.16491 * h), controlPoint1:CGPointMake(minX + 0.5858 * w, minY + 0.34106 * h), controlPoint2:CGPointMake(minX + 0.60355 * w, minY + 0.23668 * h))
		path97Path.addCurveToPoint(CGPointMake(minX + 0.18935 * w, minY + 0.34106 * h), controlPoint1:CGPointMake(minX + 0.33728 * w, minY + 0.08662 * h), controlPoint2:CGPointMake(minX + 0.26627 * w, minY + 0.16491 * h))
		path97Path.addLineToPoint(CGPointMake(minX + 0.15976 * w, minY + 0.4063 * h))
		path97Path.addLineToPoint(CGPointMake(minX + 0.47337 * w, minY + 0.58245 * h))
		path97Path.addLineToPoint(CGPointMake(minX + 0.50296 * w, minY + 0.51721 * h))
		path97Path.closePath()
		path97Path.moveToPoint(CGPointMake(minX + 0.50296 * w, minY + 0.51721 * h))
		
		return path97Path;
	}
	
	func path98PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path98Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path98Path.moveToPoint(CGPointMake(minX + 0.26813 * w, minY + 0.19571 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.12389 * w, minY + 0.4496 * h), controlPoint1:CGPointMake(minX + 0.188 * w, minY + 0.25389 * h), controlPoint2:CGPointMake(minX + 0.13458 * w, minY + 0.3491 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.20937 * w, minY + 0.73523 * h), controlPoint1:CGPointMake(minX + 0.11321 * w, minY + 0.55539 * h), controlPoint2:CGPointMake(minX + 0.13992 * w, minY + 0.6506 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.39634 * w, minY + 0.87275 * h), controlPoint1:CGPointMake(minX + 0.26279 * w, minY + 0.80399 * h), controlPoint2:CGPointMake(minX + 0.32689 * w, minY + 0.85159 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.75426 * w, minY + 0.81457 * h), controlPoint1:CGPointMake(minX + 0.52455 * w, minY + 0.90978 * h), controlPoint2:CGPointMake(minX + 0.65276 * w, minY + 0.88862 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.90918 * w, minY + 0.50778 * h), controlPoint1:CGPointMake(minX + 0.85042 * w, minY + 0.74051 * h), controlPoint2:CGPointMake(minX + 0.90384 * w, minY + 0.64002 * h))
		path98Path.addLineToPoint(CGPointMake(minX + w, minY + 0.62415 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.80768 * w, minY + 0.8992 * h), controlPoint1:CGPointMake(minX + 0.96795 * w, minY + 0.73523 * h), controlPoint2:CGPointMake(minX + 0.8985 * w, minY + 0.83043 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.52989 * w, minY + 0.9997 * h), controlPoint1:CGPointMake(minX + 0.72755 * w, minY + 0.96267 * h), controlPoint2:CGPointMake(minX + 0.63139 * w, minY + 0.99441 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.10787 * w, minY + 0.80399 * h), controlPoint1:CGPointMake(minX + 0.35895 * w, minY + 1.00498 * h), controlPoint2:CGPointMake(minX + 0.21471 * w, minY + 0.94151 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.00637 * w, minY + 0.42844 * h), controlPoint1:CGPointMake(minX + 0.01705 * w, minY + 0.68762 * h), controlPoint2:CGPointMake(minX + -0.015 * w, minY + 0.56596 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.20403 * w, minY + 0.10579 * h), controlPoint1:CGPointMake(minX + 0.02774 * w, minY + 0.29621 * h), controlPoint2:CGPointMake(minX + 0.09184 * w, minY + 0.19042 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.51387 * w, minY), controlPoint1:CGPointMake(minX + 0.29484 * w, minY + 0.03703 * h), controlPoint2:CGPointMake(minX + 0.39634 * w, minY + 0.00529 * h))
		path98Path.addLineToPoint(CGPointMake(minX + 0.60468 * w, minY + 0.11637 * h))
		path98Path.addCurveToPoint(CGPointMake(minX + 0.26813 * w, minY + 0.19571 * h), controlPoint1:CGPointMake(minX + 0.47647 * w, minY + 0.09521 * h), controlPoint2:CGPointMake(minX + 0.36429 * w, minY + 0.12166 * h))
		path98Path.closePath()
		path98Path.moveToPoint(CGPointMake(minX + 0.26813 * w, minY + 0.19571 * h))
		
		return path98Path;
	}
	
	func path99PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path99Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path99Path.moveToPoint(CGPointMake(minX + 0.11415 * w, minY + 0.19781 * h))
		path99Path.addLineToPoint(CGPointMake(minX + 0.33105 * w, minY + 0.71213 * h))
		path99Path.addCurveToPoint(CGPointMake(minX + 0.69063 * w, minY + 0.87532 * h), controlPoint1:CGPointMake(minX + 0.39954 * w, minY + 0.88027 * h), controlPoint2:CGPointMake(minX + 0.51369 * w, minY + 0.92972 * h))
		path99Path.addCurveToPoint(CGPointMake(minX + 0.84474 * w, minY + 0.54893 * h), controlPoint1:CGPointMake(minX + 0.86757 * w, minY + 0.82093 * h), controlPoint2:CGPointMake(minX + 0.91323 * w, minY + 0.71707 * h))
		path99Path.addLineToPoint(CGPointMake(minX + 0.62785 * w, minY + 0.03462 * h))
		path99Path.addLineToPoint(CGPointMake(minX + 0.742 * w, minY))
		path99Path.addLineToPoint(CGPointMake(minX + 0.95889 * w, minY + 0.51431 * h))
		path99Path.addCurveToPoint(CGPointMake(minX + 0.73058 * w, minY + 0.96929 * h), controlPoint1:CGPointMake(minX + 1.05592 * w, minY + 0.73685 * h), controlPoint2:CGPointMake(minX + 0.98172 * w, minY + 0.89016 * h))
		path99Path.addCurveToPoint(CGPointMake(minX + 0.21689 * w, minY + 0.75169 * h), controlPoint1:CGPointMake(minX + 0.47945 * w, minY + 1.04841 * h), controlPoint2:CGPointMake(minX + 0.31392 * w, minY + 0.97423 * h))
		path99Path.addLineToPoint(CGPointMake(minX, minY + 0.23738 * h))
		path99Path.addLineToPoint(CGPointMake(minX + 0.11415 * w, minY + 0.19781 * h))
		path99Path.closePath()
		path99Path.moveToPoint(CGPointMake(minX + 0.11415 * w, minY + 0.19781 * h))
		
		return path99Path;
	}
	
	func path100PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path100Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path100Path.moveToPoint(CGPointMake(minX, minY + 0.0203 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.27692 * w, minY + 0.00369 * h))
		path100Path.addCurveToPoint(CGPointMake(minX + 0.31538 * w, minY + 0.00369 * h), controlPoint1:CGPointMake(minX + 0.29231 * w, minY + 0.00369 * h), controlPoint2:CGPointMake(minX + 0.30769 * w, minY + 0.00369 * h))
		path100Path.addCurveToPoint(CGPointMake(minX + 0.63846 * w, minY + 0.0369 * h), controlPoint1:CGPointMake(minX + 0.44615 * w, minY + -0.00185 * h), controlPoint2:CGPointMake(minX + 0.54615 * w, minY + -0.00738 * h))
		path100Path.addCurveToPoint(CGPointMake(minX + 0.79231 * w, minY + 0.24723 * h), controlPoint1:CGPointMake(minX + 0.72308 * w, minY + 0.07565 * h), controlPoint2:CGPointMake(minX + 0.77692 * w, minY + 0.15314 * h))
		path100Path.addCurveToPoint(CGPointMake(minX + 0.45385 * w, minY + 0.51292 * h), controlPoint1:CGPointMake(minX + 0.80769 * w, minY + 0.40775 * h), controlPoint2:CGPointMake(minX + 0.69231 * w, minY + 0.50185 * h))
		path100Path.addCurveToPoint(CGPointMake(minX + 0.42308 * w, minY + 0.51292 * h), controlPoint1:CGPointMake(minX + 0.44615 * w, minY + 0.51292 * h), controlPoint2:CGPointMake(minX + 0.43846 * w, minY + 0.51292 * h))
		path100Path.addLineToPoint(CGPointMake(minX + w, minY + 0.95018 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.79231 * w, minY + 0.96125 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.23846 * w, minY + 0.51845 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.21538 * w, minY + 0.51845 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.26923 * w, minY + 0.98893 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.10769 * w, minY + h))
		path100Path.addLineToPoint(CGPointMake(minX, minY + 0.0203 * h))
		path100Path.closePath()
		path100Path.moveToPoint(CGPointMake(minX + 0.20769 * w, minY + 0.44096 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.33077 * w, minY + 0.43542 * h))
		path100Path.addCurveToPoint(CGPointMake(minX + 0.63077 * w, minY + 0.2583 * h), controlPoint1:CGPointMake(minX + 0.54615 * w, minY + 0.42435 * h), controlPoint2:CGPointMake(minX + 0.64615 * w, minY + 0.39668 * h))
		path100Path.addCurveToPoint(CGPointMake(minX + 0.29231 * w, minY + 0.10332 * h), controlPoint1:CGPointMake(minX + 0.61538 * w, minY + 0.11439 * h), controlPoint2:CGPointMake(minX + 0.50769 * w, minY + 0.09225 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.16923 * w, minY + 0.10886 * h))
		path100Path.addLineToPoint(CGPointMake(minX + 0.20769 * w, minY + 0.44096 * h))
		path100Path.closePath()
		path100Path.moveToPoint(CGPointMake(minX + 0.20769 * w, minY + 0.44096 * h))
		
		return path100Path;
	}
	
	func path101PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path101Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path101Path.moveToPoint(CGPointMake(minX + 0.25413 * w, minY))
		path101Path.addLineToPoint(CGPointMake(minX + 0.54925 * w, minY + 0.03061 * h))
		path101Path.addCurveToPoint(CGPointMake(minX + 0.59024 * w, minY + 0.03571 * h), controlPoint1:CGPointMake(minX + 0.56564 * w, minY + 0.03061 * h), controlPoint2:CGPointMake(minX + 0.58204 * w, minY + 0.03571 * h))
		path101Path.addCurveToPoint(CGPointMake(minX + 0.90995 * w, minY + 0.11735 * h), controlPoint1:CGPointMake(minX + 0.7296 * w, minY + 0.05102 * h), controlPoint2:CGPointMake(minX + 0.82797 * w, minY + 0.06633 * h))
		path101Path.addCurveToPoint(CGPointMake(minX + 0.99193 * w, minY + 0.33163 * h), controlPoint1:CGPointMake(minX + 0.98373 * w, minY + 0.16837 * h), controlPoint2:CGPointMake(minX + 1.01652 * w, minY + 0.2449 * h))
		path101Path.addCurveToPoint(CGPointMake(minX + 0.54105 * w, minY + 0.51531 * h), controlPoint1:CGPointMake(minX + 0.95094 * w, minY + 0.47959 * h), controlPoint2:CGPointMake(minX + 0.79518 * w, minY + 0.54082 * h))
		path101Path.addCurveToPoint(CGPointMake(minX + 0.50826 * w, minY + 0.5102 * h), controlPoint1:CGPointMake(minX + 0.53285 * w, minY + 0.51531 * h), controlPoint2:CGPointMake(minX + 0.52465 * w, minY + 0.51531 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.94274 * w, minY + h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.7214 * w, minY + 0.97449 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.31151 * w, minY + 0.4898 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.28692 * w, minY + 0.48469 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.16395 * w, minY + 0.91327 * h))
		path101Path.addLineToPoint(CGPointMake(minX, minY + 0.89286 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.25413 * w, minY))
		path101Path.closePath()
		path101Path.moveToPoint(CGPointMake(minX + 0.31151 * w, minY + 0.40816 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.44268 * w, minY + 0.42347 * h))
		path101Path.addCurveToPoint(CGPointMake(minX + 0.81977 * w, minY + 0.31633 * h), controlPoint1:CGPointMake(minX + 0.67221 * w, minY + 0.44898 * h), controlPoint2:CGPointMake(minX + 0.78698 * w, minY + 0.43878 * h))
		path101Path.addCurveToPoint(CGPointMake(minX + 0.52465 * w, minY + 0.12245 * h), controlPoint1:CGPointMake(minX + 0.85256 * w, minY + 0.18367 * h), controlPoint2:CGPointMake(minX + 0.75419 * w, minY + 0.14796 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.39349 * w, minY + 0.10714 * h))
		path101Path.addLineToPoint(CGPointMake(minX + 0.31151 * w, minY + 0.40816 * h))
		path101Path.closePath()
		path101Path.moveToPoint(CGPointMake(minX + 0.31151 * w, minY + 0.40816 * h))
		
		return path101Path;
	}
	
	func path102PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path102Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path102Path.moveToPoint(CGPointMake(minX + 0.45912 * w, minY))
		path102Path.addLineToPoint(CGPointMake(minX + w, minY + 0.19307 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.94969 * w, minY + 0.28218 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.53459 * w, minY + 0.13366 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.40252 * w, minY + 0.36634 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.81761 * w, minY + 0.51485 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.7673 * w, minY + 0.60396 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.3522 * w, minY + 0.45545 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.1761 * w, minY + 0.76238 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.59119 * w, minY + 0.91089 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.54088 * w, minY + h))
		path102Path.addLineToPoint(CGPointMake(minX, minY + 0.80693 * h))
		path102Path.addLineToPoint(CGPointMake(minX + 0.45912 * w, minY))
		path102Path.closePath()
		path102Path.moveToPoint(CGPointMake(minX + 0.45912 * w, minY))
		
		return path102Path;
	}
	
	func path103PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path103Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path103Path.moveToPoint(CGPointMake(minX + 0.53247 * w, minY))
		path103Path.addLineToPoint(CGPointMake(minX + 0.54545 * w, minY + 0.79184 * h))
		path103Path.addLineToPoint(CGPointMake(minX + 0.93506 * w, minY + 0.37959 * h))
		path103Path.addLineToPoint(CGPointMake(minX + w, minY + 0.43265 * h))
		path103Path.addLineToPoint(CGPointMake(minX + 0.46753 * w, minY + h))
		path103Path.addLineToPoint(CGPointMake(minX + 0.45022 * w, minY + 0.21633 * h))
		path103Path.addLineToPoint(CGPointMake(minX + 0.06494 * w, minY + 0.62449 * h))
		path103Path.addLineToPoint(CGPointMake(minX, minY + 0.57143 * h))
		path103Path.addLineToPoint(CGPointMake(minX + 0.53247 * w, minY))
		path103Path.closePath()
		path103Path.moveToPoint(CGPointMake(minX + 0.53247 * w, minY))
		
		return path103Path;
	}
	
	func path104PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path104Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path104Path.moveToPoint(CGPointMake(minX + 0.83798 * w, minY + 0.31385 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.60484 * w, minY + 0.13414 * h), controlPoint1:CGPointMake(minX + 0.79029 * w, minY + 0.22672 * h), controlPoint2:CGPointMake(minX + 0.70021 * w, minY + 0.15593 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.30812 * w, minY + 0.17771 * h), controlPoint1:CGPointMake(minX + 0.50416 * w, minY + 0.10692 * h), controlPoint2:CGPointMake(minX + 0.40349 * w, minY + 0.12325 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.14386 * w, minY + 0.35197 * h), controlPoint1:CGPointMake(minX + 0.23393 * w, minY + 0.22127 * h), controlPoint2:CGPointMake(minX + 0.17565 * w, minY + 0.28118 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.15446 * w, minY + 0.72227 * h), controlPoint1:CGPointMake(minX + 0.08557 * w, minY + 0.47177 * h), controlPoint2:CGPointMake(minX + 0.09087 * w, minY + 0.60791 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.44058 * w, minY + 0.92376 * h), controlPoint1:CGPointMake(minX + 0.21274 * w, minY + 0.83119 * h), controlPoint2:CGPointMake(minX + 0.30812 * w, minY + 0.89653 * h))
		path104Path.addLineToPoint(CGPointMake(minX + 0.31341 * w, minY + h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.06438 * w, minY + 0.76584 * h), controlPoint1:CGPointMake(minX + 0.20744 * w, minY + 0.95099 * h), controlPoint2:CGPointMake(minX + 0.12266 * w, minY + 0.8693 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.00079 * w, minY + 0.47177 * h), controlPoint1:CGPointMake(minX + 0.01669 * w, minY + 0.67871 * h), controlPoint2:CGPointMake(minX + -0.0045 * w, minY + 0.57524 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.24983 * w, minY + 0.07424 * h), controlPoint1:CGPointMake(minX + 0.01669 * w, minY + 0.29751 * h), controlPoint2:CGPointMake(minX + 0.10147 * w, minY + 0.16137 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.63663 * w, minY + 0.01979 * h), controlPoint1:CGPointMake(minX + 0.377 * w, minY + -0.002 * h), controlPoint2:CGPointMake(minX + 0.50416 * w, minY + -0.01833 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.93335 * w, minY + 0.26484 * h), controlPoint1:CGPointMake(minX + 0.7638 * w, minY + 0.0579 * h), controlPoint2:CGPointMake(minX + 0.86447 * w, minY + 0.13959 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.99694 * w, minY + 0.59702 * h), controlPoint1:CGPointMake(minX + 0.99164 * w, minY + 0.36286 * h), controlPoint2:CGPointMake(minX + 1.00754 * w, minY + 0.47177 * h))
		path104Path.addLineToPoint(CGPointMake(minX + 0.86977 * w, minY + 0.67326 * h))
		path104Path.addCurveToPoint(CGPointMake(minX + 0.83798 * w, minY + 0.31385 * h), controlPoint1:CGPointMake(minX + 0.91216 * w, minY + 0.53712 * h), controlPoint2:CGPointMake(minX + 0.90156 * w, minY + 0.42276 * h))
		path104Path.closePath()
		path104Path.moveToPoint(CGPointMake(minX + 0.83798 * w, minY + 0.31385 * h))
		
		return path104Path;
	}
	
	func path105PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path105Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path105Path.moveToPoint(CGPointMake(minX + 0.88776 * w, minY))
		path105Path.addLineToPoint(CGPointMake(minX + w, minY + 0.68657 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.90306 * w, minY + 0.71642 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.81633 * w, minY + 0.18657 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.56122 * w, minY + 0.27612 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.64796 * w, minY + 0.80597 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.55102 * w, minY + 0.84328 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.46429 * w, minY + 0.31343 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.12245 * w, minY + 0.43284 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.20918 * w, minY + 0.96269 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.11224 * w, minY + h))
		path105Path.addLineToPoint(CGPointMake(minX, minY + 0.31343 * h))
		path105Path.addLineToPoint(CGPointMake(minX + 0.88776 * w, minY))
		path105Path.closePath()
		path105Path.moveToPoint(CGPointMake(minX + 0.88776 * w, minY))
		
		return path105Path;
	}
	
	func path106PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path106Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path106Path.moveToPoint(CGPointMake(minX + 0.75625 * w, minY + 0.39316 * h))
		path106Path.addLineToPoint(CGPointMake(minX + 0.64375 * w, minY + 0.05983 * h))
		path106Path.addLineToPoint(CGPointMake(minX + 0.7375 * w, minY))
		path106Path.addLineToPoint(CGPointMake(minX + w, minY + 0.79487 * h))
		path106Path.addLineToPoint(CGPointMake(minX + 0.90625 * w, minY + 0.8547 * h))
		path106Path.addLineToPoint(CGPointMake(minX + 0.8 * w, minY + 0.52991 * h))
		path106Path.addLineToPoint(CGPointMake(minX + 0.04375 * w, minY + h))
		path106Path.addLineToPoint(CGPointMake(minX, minY + 0.86325 * h))
		path106Path.addLineToPoint(CGPointMake(minX + 0.75625 * w, minY + 0.39316 * h))
		path106Path.closePath()
		path106Path.moveToPoint(CGPointMake(minX + 0.75625 * w, minY + 0.39316 * h))
		
		return path106Path;
	}
	
	func path107PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path107Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path107Path.moveToPoint(CGPointMake(minX + 0.62963 * w, minY))
		path107Path.addLineToPoint(CGPointMake(minX + 0.68783 * w, minY + 0.07692 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.44444 * w, minY + 0.26923 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.69841 * w, minY + 0.61538 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.9418 * w, minY + 0.42308 * h))
		path107Path.addLineToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.37037 * w, minY + h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.31217 * w, minY + 0.92308 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.62963 * w, minY + 0.67033 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.37566 * w, minY + 0.32418 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.0582 * w, minY + 0.57692 * h))
		path107Path.addLineToPoint(CGPointMake(minX, minY + 0.5 * h))
		path107Path.addLineToPoint(CGPointMake(minX + 0.62963 * w, minY))
		path107Path.closePath()
		path107Path.moveToPoint(CGPointMake(minX + 0.62963 * w, minY))
		
		return path107Path;
	}
	
	func path108PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path108Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path108Path.moveToPoint(CGPointMake(minX + 0.61635 * w, minY))
		path108Path.addLineToPoint(CGPointMake(minX + w, minY + 0.30723 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.93711 * w, minY + 0.38554 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.63522 * w, minY + 0.14458 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.45912 * w, minY + 0.34337 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.75472 * w, minY + 0.57831 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.68553 * w, minY + 0.65663 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.38994 * w, minY + 0.42169 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.15723 * w, minY + 0.68675 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.45283 * w, minY + 0.92169 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.38365 * w, minY + h))
		path108Path.addLineToPoint(CGPointMake(minX, minY + 0.69277 * h))
		path108Path.addLineToPoint(CGPointMake(minX + 0.61635 * w, minY))
		path108Path.closePath()
		path108Path.moveToPoint(CGPointMake(minX + 0.61635 * w, minY))
		
		return path108Path;
	}
	
	func path109PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path109Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path109Path.moveToPoint(CGPointMake(minX + 0.375 * w, minY + 0.28042 * h))
		path109Path.addLineToPoint(CGPointMake(minX + 0.09659 * w, minY + 0.7672 * h))
		path109Path.addLineToPoint(CGPointMake(minX, minY + 0.74074 * h))
		path109Path.addLineToPoint(CGPointMake(minX + 0.43182 * w, minY))
		path109Path.addLineToPoint(CGPointMake(minX + 0.50568 * w, minY + 0.70899 * h))
		path109Path.addLineToPoint(CGPointMake(minX + w, minY + 0.16402 * h))
		path109Path.addLineToPoint(CGPointMake(minX + 0.89773 * w, minY + h))
		path109Path.addLineToPoint(CGPointMake(minX + 0.80114 * w, minY + 0.97354 * h))
		path109Path.addLineToPoint(CGPointMake(minX + 0.86932 * w, minY + 0.42857 * h))
		path109Path.addLineToPoint(CGPointMake(minX + 0.43182 * w, minY + 0.89947 * h))
		path109Path.addLineToPoint(CGPointMake(minX + 0.375 * w, minY + 0.28042 * h))
		path109Path.closePath()
		path109Path.moveToPoint(CGPointMake(minX + 0.375 * w, minY + 0.28042 * h))
		
		return path109Path;
	}
	
	func path110PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path110Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path110Path.moveToPoint(CGPointMake(minX + 0.84339 * w, minY + 0.85987 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.48751 * w, minY + h), controlPoint1:CGPointMake(minX + 0.7435 * w, minY + 0.95541 * h), controlPoint2:CGPointMake(minX + 0.61863 * w, minY + h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.13788 * w, minY + 0.84713 * h), controlPoint1:CGPointMake(minX + 0.3564 * w, minY + h), controlPoint2:CGPointMake(minX + 0.23153 * w, minY + 0.94268 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.00052 * w, minY + 0.49045 * h), controlPoint1:CGPointMake(minX + 0.04423 * w, minY + 0.75159 * h), controlPoint2:CGPointMake(minX + -0.00572 * w, minY + 0.6242 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.15661 * w, minY + 0.14013 * h), controlPoint1:CGPointMake(minX + 0.00052 * w, minY + 0.35669 * h), controlPoint2:CGPointMake(minX + 0.05671 * w, minY + 0.2293 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.51249 * w, minY), controlPoint1:CGPointMake(minX + 0.25026 * w, minY + 0.05096 * h), controlPoint2:CGPointMake(minX + 0.38137 * w, minY))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.86212 * w, minY + 0.15287 * h), controlPoint1:CGPointMake(minX + 0.6436 * w, minY), controlPoint2:CGPointMake(minX + 0.77471 * w, minY + 0.05732 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.99948 * w, minY + 0.50955 * h), controlPoint1:CGPointMake(minX + 0.95577 * w, minY + 0.24841 * h), controlPoint2:CGPointMake(minX + 1.00572 * w, minY + 0.3758 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.84339 * w, minY + 0.85987 * h), controlPoint1:CGPointMake(minX + 0.99323 * w, minY + 0.64331 * h), controlPoint2:CGPointMake(minX + 0.93704 * w, minY + 0.76433 * h))
		path110Path.closePath()
		path110Path.moveToPoint(CGPointMake(minX + 0.75598 * w, minY + 0.77707 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.87461 * w, minY + 0.50318 * h), controlPoint1:CGPointMake(minX + 0.8309 * w, minY + 0.70701 * h), controlPoint2:CGPointMake(minX + 0.87461 * w, minY + 0.61146 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.76847 * w, minY + 0.22293 * h), controlPoint1:CGPointMake(minX + 0.87461 * w, minY + 0.3949 * h), controlPoint2:CGPointMake(minX + 0.83715 * w, minY + 0.29936 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.10191 * h), controlPoint1:CGPointMake(minX + 0.69979 * w, minY + 0.1465 * h), controlPoint2:CGPointMake(minX + 0.60614 * w, minY + 0.10191 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.22529 * w, minY + 0.21019 * h), controlPoint1:CGPointMake(minX + 0.39386 * w, minY + 0.10191 * h), controlPoint2:CGPointMake(minX + 0.30021 * w, minY + 0.14013 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.10666 * w, minY + 0.49045 * h), controlPoint1:CGPointMake(minX + 0.15037 * w, minY + 0.28662 * h), controlPoint2:CGPointMake(minX + 0.10666 * w, minY + 0.38217 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.2128 * w, minY + 0.7707 * h), controlPoint1:CGPointMake(minX + 0.10666 * w, minY + 0.59873 * h), controlPoint2:CGPointMake(minX + 0.14412 * w, minY + 0.69427 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.48127 * w, minY + 0.89172 * h), controlPoint1:CGPointMake(minX + 0.28772 * w, minY + 0.84713 * h), controlPoint2:CGPointMake(minX + 0.37513 * w, minY + 0.89172 * h))
		path110Path.addCurveToPoint(CGPointMake(minX + 0.75598 * w, minY + 0.77707 * h), controlPoint1:CGPointMake(minX + 0.58741 * w, minY + 0.89172 * h), controlPoint2:CGPointMake(minX + 0.68106 * w, minY + 0.8535 * h))
		path110Path.closePath()
		path110Path.moveToPoint(CGPointMake(minX + 0.75598 * w, minY + 0.77707 * h))
		
		return path110Path;
	}
	
	func path111PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path111Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path111Path.moveToPoint(CGPointMake(minX, minY + 0.14205 * h))
		path111Path.addLineToPoint(CGPointMake(minX + 0.83436 * w, minY + 0.64773 * h))
		path111Path.addLineToPoint(CGPointMake(minX + 0.66258 * w, minY + 0.02273 * h))
		path111Path.addLineToPoint(CGPointMake(minX + 0.76074 * w, minY))
		path111Path.addLineToPoint(CGPointMake(minX + w, minY + 0.85795 * h))
		path111Path.addLineToPoint(CGPointMake(minX + 0.16564 * w, minY + 0.35795 * h))
		path111Path.addLineToPoint(CGPointMake(minX + 0.33742 * w, minY + 0.97727 * h))
		path111Path.addLineToPoint(CGPointMake(minX + 0.23926 * w, minY + h))
		path111Path.addLineToPoint(CGPointMake(minX, minY + 0.14205 * h))
		path111Path.closePath()
		path111Path.moveToPoint(CGPointMake(minX, minY + 0.14205 * h))
		
		return path111Path;
	}
	
	func path112PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path112Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path112Path.moveToPoint(CGPointMake(minX + 0.37097 * w, minY + 0.26708 * h))
		path112Path.addLineToPoint(CGPointMake(minX + 0.06452 * w, minY + 0.3913 * h))
		path112Path.addLineToPoint(CGPointMake(minX, minY + 0.29814 * h))
		path112Path.addLineToPoint(CGPointMake(minX + 0.73387 * w, minY))
		path112Path.addLineToPoint(CGPointMake(minX + 0.79839 * w, minY + 0.09317 * h))
		path112Path.addLineToPoint(CGPointMake(minX + 0.5 * w, minY + 0.21739 * h))
		path112Path.addLineToPoint(CGPointMake(minX + w, minY + 0.95031 * h))
		path112Path.addLineToPoint(CGPointMake(minX + 0.87097 * w, minY + h))
		path112Path.addLineToPoint(CGPointMake(minX + 0.37097 * w, minY + 0.26708 * h))
		path112Path.closePath()
		path112Path.moveToPoint(CGPointMake(minX + 0.37097 * w, minY + 0.26708 * h))
		
		return path112Path;
	}
	
	func path113PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path113Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path113Path.moveToPoint(CGPointMake(minX + 0.08306 * w, minY + 0.37754 * h))
		path113Path.addLineToPoint(CGPointMake(minX + 0.44494 * w, minY + 0.78993 * h))
		path113Path.addCurveToPoint(CGPointMake(minX + 0.79497 * w, minY + 0.83059 * h), controlPoint1:CGPointMake(minX + 0.5636 * w, minY + 0.92352 * h), controlPoint2:CGPointMake(minX + 0.67038 * w, minY + 0.94094 * h))
		path113Path.addCurveToPoint(CGPointMake(minX + 0.80683 * w, minY + 0.48209 * h), controlPoint1:CGPointMake(minX + 0.91955 * w, minY + 0.72604 * h), controlPoint2:CGPointMake(minX + 0.91955 * w, minY + 0.61568 * h))
		path113Path.addLineToPoint(CGPointMake(minX + 0.44494 * w, minY + 0.0697 * h))
		path113Path.addLineToPoint(CGPointMake(minX + 0.528 * w, minY))
		path113Path.addLineToPoint(CGPointMake(minX + 0.88989 * w, minY + 0.41239 * h))
		path113Path.addCurveToPoint(CGPointMake(minX + 0.86023 * w, minY + 0.90029 * h), controlPoint1:CGPointMake(minX + 1.04414 * w, minY + 0.59245 * h), controlPoint2:CGPointMake(minX + 1.0382 * w, minY + 0.75508 * h))
		path113Path.addCurveToPoint(CGPointMake(minX + 0.36189 * w, minY + 0.85382 * h), controlPoint1:CGPointMake(minX + 0.68225 * w, minY + 1.04549 * h), controlPoint2:CGPointMake(minX + 0.52207 * w, minY + 1.03388 * h))
		path113Path.addLineToPoint(CGPointMake(minX, minY + 0.44724 * h))
		path113Path.addLineToPoint(CGPointMake(minX + 0.08306 * w, minY + 0.37754 * h))
		path113Path.closePath()
		path113Path.moveToPoint(CGPointMake(minX + 0.08306 * w, minY + 0.37754 * h))
		
		return path113Path;
	}
	
	func path114PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path114Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path114Path.moveToPoint(CGPointMake(minX, minY + 0.41558 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.28144 * w, minY))
		path114Path.addLineToPoint(CGPointMake(minX + 0.35928 * w, minY + 0.06494 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.14371 * w, minY + 0.38312 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.35329 * w, minY + 0.55195 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.56886 * w, minY + 0.23377 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.64671 * w, minY + 0.2987 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.43114 * w, minY + 0.61688 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.70659 * w, minY + 0.83766 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.92216 * w, minY + 0.51948 * h))
		path114Path.addLineToPoint(CGPointMake(minX + w, minY + 0.58442 * h))
		path114Path.addLineToPoint(CGPointMake(minX + 0.71856 * w, minY + h))
		path114Path.addLineToPoint(CGPointMake(minX, minY + 0.41558 * h))
		path114Path.closePath()
		path114Path.moveToPoint(CGPointMake(minX, minY + 0.41558 * h))
		
		return path114Path;
	}
	
	func path115PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path115Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path115Path.moveToPoint(CGPointMake(minX + 0.8234 * w, minY + 0.25426 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.96113 * w, minY + 0.77098 * h), controlPoint1:CGPointMake(minX + 0.98737 * w, minY + 0.35268 * h), controlPoint2:CGPointMake(minX + 1.04639 * w, minY + 0.55773 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.62665 * w, minY + 0.99243 * h), controlPoint1:CGPointMake(minX + 0.89555 * w, minY + 0.95142 * h), controlPoint2:CGPointMake(minX + 0.7775 * w, minY + 1.02524 * h))
		path115Path.addLineToPoint(CGPointMake(minX + 0.62665 * w, minY + 0.84479 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.87587 * w, minY + 0.72177 * h), controlPoint1:CGPointMake(minX + 0.7447 * w, minY + 0.8776 * h), controlPoint2:CGPointMake(minX + 0.82996 * w, minY + 0.82839 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.79061 * w, minY + 0.40189 * h), controlPoint1:CGPointMake(minX + 0.92834 * w, minY + 0.59054 * h), controlPoint2:CGPointMake(minX + 0.88899 * w, minY + 0.45931 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.54795 * w, minY + 0.46751 * h), controlPoint1:CGPointMake(minX + 0.71191 * w, minY + 0.35268 * h), controlPoint2:CGPointMake(minX + 0.63321 * w, minY + 0.37729 * h))
		path115Path.addLineToPoint(CGPointMake(minX + 0.44957 * w, minY + 0.57413 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.13476 * w, minY + 0.65615 * h), controlPoint1:CGPointMake(minX + 0.34464 * w, minY + 0.69716 * h), controlPoint2:CGPointMake(minX + 0.2397 * w, minY + 0.72177 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.02983 * w, minY + 0.21325 * h), controlPoint1:CGPointMake(minX + 0.01015 * w, minY + 0.58233 * h), controlPoint2:CGPointMake(minX + -0.03576 * w, minY + 0.40189 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.27249 * w, minY), controlPoint1:CGPointMake(minX + 0.0823 * w, minY + 0.08202 * h), controlPoint2:CGPointMake(minX + 0.161 * w, minY + 0.0082 * h))
		path115Path.addLineToPoint(CGPointMake(minX + 0.28561 * w, minY + 0.13943 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.11509 * w, minY + 0.27066 * h), controlPoint1:CGPointMake(minX + 0.20035 * w, minY + 0.14763 * h), controlPoint2:CGPointMake(minX + 0.14132 * w, minY + 0.18864 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.18067 * w, minY + 0.51672 * h), controlPoint1:CGPointMake(minX + 0.07574 * w, minY + 0.36909 * h), controlPoint2:CGPointMake(minX + 0.10853 * w, minY + 0.47571 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.37743 * w, minY + 0.4511 * h), controlPoint1:CGPointMake(minX + 0.24626 * w, minY + 0.55773 * h), controlPoint2:CGPointMake(minX + 0.30528 * w, minY + 0.53312 * h))
		path115Path.addLineToPoint(CGPointMake(minX + 0.49548 * w, minY + 0.32808 * h))
		path115Path.addCurveToPoint(CGPointMake(minX + 0.8234 * w, minY + 0.25426 * h), controlPoint1:CGPointMake(minX + 0.60042 * w, minY + 0.21325 * h), controlPoint2:CGPointMake(minX + 0.71191 * w, minY + 0.18864 * h))
		path115Path.closePath()
		path115Path.moveToPoint(CGPointMake(minX + 0.8234 * w, minY + 0.25426 * h))
		
		return path115Path;
	}
	
	func path116PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path116Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path116Path.moveToPoint(CGPointMake(minX, minY))
		path116Path.addLineToPoint(CGPointMake(minX + 0.15556 * w, minY))
		path116Path.addLineToPoint(CGPointMake(minX + 0.77778 * w, minY + 0.67273 * h))
		path116Path.addLineToPoint(CGPointMake(minX + 0.77778 * w, minY + 0.67273 * h))
		path116Path.addLineToPoint(CGPointMake(minX + 0.77778 * w, minY + 0.01818 * h))
		path116Path.addLineToPoint(CGPointMake(minX + w, minY + 0.01818 * h))
		path116Path.addLineToPoint(CGPointMake(minX + w, minY + h))
		path116Path.addLineToPoint(CGPointMake(minX + 0.84444 * w, minY + h))
		path116Path.addLineToPoint(CGPointMake(minX + 0.22222 * w, minY + 0.32727 * h))
		path116Path.addLineToPoint(CGPointMake(minX + 0.22222 * w, minY + 0.32727 * h))
		path116Path.addLineToPoint(CGPointMake(minX + 0.22222 * w, minY + 0.98182 * h))
		path116Path.addLineToPoint(CGPointMake(minX, minY + 0.98182 * h))
		path116Path.addLineToPoint(CGPointMake(minX, minY))
		path116Path.closePath()
		path116Path.moveToPoint(CGPointMake(minX, minY))
		
		return path116Path;
	}
	
	func path117PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path117Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path117Path.moveToPoint(CGPointMake(minX + 0.5 * w, minY + h))
		path117Path.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.19231 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.78571 * h))
		path117Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.21429 * h), controlPoint2:CGPointMake(minX + 0.19231 * w, minY))
		path117Path.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.80769 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.21429 * h))
		path117Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.76786 * h), controlPoint2:CGPointMake(minX + 0.80769 * w, minY + h))
		path117Path.closePath()
		path117Path.moveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.17857 * h))
		path117Path.addCurveToPoint(CGPointMake(minX + 0.19231 * w, minY + 0.48214 * h), controlPoint1:CGPointMake(minX + 0.30769 * w, minY + 0.17857 * h), controlPoint2:CGPointMake(minX + 0.19231 * w, minY + 0.33929 * h))
		path117Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.80357 * h), controlPoint1:CGPointMake(minX + 0.19231 * w, minY + 0.625 * h), controlPoint2:CGPointMake(minX + 0.26923 * w, minY + 0.80357 * h))
		path117Path.addCurveToPoint(CGPointMake(minX + 0.80769 * w, minY + 0.48214 * h), controlPoint1:CGPointMake(minX + 0.73077 * w, minY + 0.80357 * h), controlPoint2:CGPointMake(minX + 0.80769 * w, minY + 0.625 * h))
		path117Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.17857 * h), controlPoint1:CGPointMake(minX + 0.80769 * w, minY + 0.33929 * h), controlPoint2:CGPointMake(minX + 0.69231 * w, minY + 0.17857 * h))
		path117Path.closePath()
		path117Path.moveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.17857 * h))
		
		return path117Path;
	}
	
	func path118PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path118Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path118Path.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		path118Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.75 * h), controlPoint2:CGPointMake(minX + 0.75 * w, minY + h))
		path118Path.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.25 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.75 * h))
		path118Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.25 * h), controlPoint2:CGPointMake(minX + 0.25 * w, minY))
		path118Path.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.83333 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.25 * h))
		path118Path.closePath()
		path118Path.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		
		return path118Path;
	}
	
	func path119PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path119Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path119Path.moveToPoint(CGPointMake(minX, minY + 0.16981 * h))
		path119Path.addLineToPoint(CGPointMake(minX, minY))
		path119Path.addLineToPoint(CGPointMake(minX + w, minY))
		path119Path.addLineToPoint(CGPointMake(minX + w, minY + h))
		path119Path.addLineToPoint(CGPointMake(minX + 0.41176 * w, minY + h))
		path119Path.addLineToPoint(CGPointMake(minX + 0.41176 * w, minY + 0.16981 * h))
		path119Path.addLineToPoint(CGPointMake(minX, minY + 0.16981 * h))
		path119Path.closePath()
		path119Path.moveToPoint(CGPointMake(minX, minY + 0.16981 * h))
		
		return path119Path;
	}
	
	func path120PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path120Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path120Path.moveToPoint(CGPointMake(minX + w, minY + 0.83636 * h))
		path120Path.addLineToPoint(CGPointMake(minX + w, minY + h))
		path120Path.addLineToPoint(CGPointMake(minX, minY + h))
		path120Path.addLineToPoint(CGPointMake(minX + 0.38889 * w, minY + 0.69091 * h))
		path120Path.addCurveToPoint(CGPointMake(minX + 0.72222 * w, minY + 0.32727 * h), controlPoint1:CGPointMake(minX + 0.5 * w, minY + 0.6 * h), controlPoint2:CGPointMake(minX + 0.72222 * w, minY + 0.43636 * h))
		path120Path.addCurveToPoint(CGPointMake(minX + 0.52778 * w, minY + 0.16364 * h), controlPoint1:CGPointMake(minX + 0.72222 * w, minY + 0.25455 * h), controlPoint2:CGPointMake(minX + 0.66667 * w, minY + 0.16364 * h))
		path120Path.addCurveToPoint(CGPointMake(minX + 0.33333 * w, minY + 0.32727 * h), controlPoint1:CGPointMake(minX + 0.38889 * w, minY + 0.16364 * h), controlPoint2:CGPointMake(minX + 0.33333 * w, minY + 0.25455 * h))
		path120Path.addLineToPoint(CGPointMake(minX + 0.02778 * w, minY + 0.32727 * h))
		path120Path.addCurveToPoint(CGPointMake(minX + 0.52778 * w, minY), controlPoint1:CGPointMake(minX + 0.05556 * w, minY + 0.14545 * h), controlPoint2:CGPointMake(minX + 0.22222 * w, minY))
		path120Path.addCurveToPoint(CGPointMake(minX + w, minY + 0.30909 * h), controlPoint1:CGPointMake(minX + 0.80556 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.12727 * h))
		path120Path.addCurveToPoint(CGPointMake(minX + 0.75 * w, minY + 0.65455 * h), controlPoint1:CGPointMake(minX + w, minY + 0.45455 * h), controlPoint2:CGPointMake(minX + 0.88889 * w, minY + 0.56364 * h))
		path120Path.addLineToPoint(CGPointMake(minX + 0.52778 * w, minY + 0.81818 * h))
		path120Path.addLineToPoint(CGPointMake(minX + w, minY + 0.81818 * h))
		path120Path.closePath()
		path120Path.moveToPoint(CGPointMake(minX + w, minY + 0.83636 * h))
		
		return path120Path;
	}
	
	func path121PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path121Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path121Path.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		path121Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.69643 * h), controlPoint2:CGPointMake(minX + 0.86842 * w, minY + h))
		path121Path.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.13158 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.69643 * h))
		path121Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.30357 * h), controlPoint2:CGPointMake(minX + 0.13158 * w, minY))
		path121Path.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.86842 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.28571 * h))
		path121Path.closePath()
		path121Path.moveToPoint(CGPointMake(minX + 0.26316 * w, minY + 0.5 * h))
		path121Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.83929 * h), controlPoint1:CGPointMake(minX + 0.26316 * w, minY + 0.58929 * h), controlPoint2:CGPointMake(minX + 0.31579 * w, minY + 0.83929 * h))
		path121Path.addCurveToPoint(CGPointMake(minX + 0.73684 * w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.68421 * w, minY + 0.83929 * h), controlPoint2:CGPointMake(minX + 0.73684 * w, minY + 0.58929 * h))
		path121Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + 0.16071 * h), controlPoint1:CGPointMake(minX + 0.73684 * w, minY + 0.41071 * h), controlPoint2:CGPointMake(minX + 0.71053 * w, minY + 0.16071 * h))
		path121Path.addCurveToPoint(CGPointMake(minX + 0.26316 * w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.31579 * w, minY + 0.16071 * h), controlPoint2:CGPointMake(minX + 0.26316 * w, minY + 0.39286 * h))
		path121Path.closePath()
		path121Path.moveToPoint(CGPointMake(minX + 0.26316 * w, minY + 0.5 * h))
		
		return path121Path;
	}
	
	func path122PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path122Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path122Path.moveToPoint(CGPointMake(minX, minY + 0.16981 * h))
		path122Path.addLineToPoint(CGPointMake(minX, minY))
		path122Path.addLineToPoint(CGPointMake(minX + w, minY))
		path122Path.addLineToPoint(CGPointMake(minX + w, minY + h))
		path122Path.addLineToPoint(CGPointMake(minX + 0.41176 * w, minY + h))
		path122Path.addLineToPoint(CGPointMake(minX + 0.41176 * w, minY + 0.16981 * h))
		path122Path.addLineToPoint(CGPointMake(minX, minY + 0.16981 * h))
		path122Path.closePath()
		path122Path.moveToPoint(CGPointMake(minX, minY + 0.16981 * h))
		
		return path122Path;
	}
	
	func path123PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path123Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path123Path.moveToPoint(CGPointMake(minX + 0.76316 * w, minY + 0.10526 * h))
		path123Path.addLineToPoint(CGPointMake(minX + 0.47368 * w, minY + 0.36842 * h))
		path123Path.addLineToPoint(CGPointMake(minX + 0.47368 * w, minY + 0.36842 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + 0.57895 * w, minY + 0.35088 * h), controlPoint1:CGPointMake(minX + 0.5 * w, minY + 0.36842 * h), controlPoint2:CGPointMake(minX + 0.55263 * w, minY + 0.35088 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + w, minY + 0.66667 * h), controlPoint1:CGPointMake(minX + 0.84211 * w, minY + 0.35088 * h), controlPoint2:CGPointMake(minX + w, minY + 0.49123 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.85965 * h), controlPoint2:CGPointMake(minX + 0.78947 * w, minY + h))
		path123Path.addCurveToPoint(CGPointMake(minX, minY + 0.68421 * h), controlPoint1:CGPointMake(minX + 0.21053 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.87719 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + 0.18421 * w, minY + 0.36842 * h), controlPoint1:CGPointMake(minX, minY + 0.57895 * h), controlPoint2:CGPointMake(minX + 0.07895 * w, minY + 0.45614 * h))
		path123Path.addLineToPoint(CGPointMake(minX + 0.55263 * w, minY))
		path123Path.addLineToPoint(CGPointMake(minX + 0.76316 * w, minY + 0.10526 * h))
		path123Path.closePath()
		path123Path.moveToPoint(CGPointMake(minX + 0.73684 * w, minY + 0.68421 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + 0.52632 * w, minY + 0.50877 * h), controlPoint1:CGPointMake(minX + 0.73684 * w, minY + 0.59649 * h), controlPoint2:CGPointMake(minX + 0.65789 * w, minY + 0.50877 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + 0.31579 * w, minY + 0.68421 * h), controlPoint1:CGPointMake(minX + 0.39474 * w, minY + 0.50877 * h), controlPoint2:CGPointMake(minX + 0.31579 * w, minY + 0.59649 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + 0.52632 * w, minY + 0.85965 * h), controlPoint1:CGPointMake(minX + 0.31579 * w, minY + 0.77193 * h), controlPoint2:CGPointMake(minX + 0.39474 * w, minY + 0.85965 * h))
		path123Path.addCurveToPoint(CGPointMake(minX + 0.73684 * w, minY + 0.68421 * h), controlPoint1:CGPointMake(minX + 0.65789 * w, minY + 0.85965 * h), controlPoint2:CGPointMake(minX + 0.73684 * w, minY + 0.77193 * h))
		path123Path.closePath()
		path123Path.moveToPoint(CGPointMake(minX + 0.73684 * w, minY + 0.68421 * h))
		
		return path123Path;
	}
	
	func circleInBlackPathWithBounds(bound: CGRect) -> UIBezierPath{
		let circleInBlackPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		circleInBlackPath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		circleInBlackPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.77614 * h), controlPoint2:CGPointMake(minX + 0.77614 * w, minY + h))
		circleInBlackPath.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.22386 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.77614 * h))
		circleInBlackPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.22386 * h), controlPoint2:CGPointMake(minX + 0.22386 * w, minY))
		circleInBlackPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.77614 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.22386 * h))
		circleInBlackPath.closePath()
		circleInBlackPath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		
		return circleInBlackPath;
	}
	
	func path67PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path67Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path67Path.moveToPoint(CGPointMake(minX + 0.31868 * w, minY))
		path67Path.addLineToPoint(CGPointMake(minX + w, minY + 0.89091 * h))
		path67Path.addLineToPoint(CGPointMake(minX + 0.95604 * w, minY + h))
		path67Path.addLineToPoint(CGPointMake(minX + 0.32967 * w, minY + 0.18182 * h))
		path67Path.addLineToPoint(CGPointMake(minX + 0.05495 * w, minY + 0.74545 * h))
		path67Path.addLineToPoint(CGPointMake(minX, minY + 0.67273 * h))
		path67Path.addLineToPoint(CGPointMake(minX + 0.31868 * w, minY))
		path67Path.closePath()
		path67Path.moveToPoint(CGPointMake(minX + 0.31868 * w, minY))
		
		return path67Path;
	}
	
	func path68PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path68Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path68Path.moveToPoint(CGPointMake(minX + 0.66667 * w, minY))
		path68Path.addLineToPoint(CGPointMake(minX + w, minY + 0.94186 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.92593 * w, minY + h))
		path68Path.addLineToPoint(CGPointMake(minX, minY + 0.52326 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.07407 * w, minY + 0.46512 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.32099 * w, minY + 0.59302 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.69136 * w, minY + 0.30233 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.60494 * w, minY + 0.04651 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.66667 * w, minY))
		path68Path.closePath()
		path68Path.moveToPoint(CGPointMake(minX + 0.38272 * w, minY + 0.65116 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.90123 * w, minY + 0.9186 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.71605 * w, minY + 0.38372 * h))
		path68Path.addLineToPoint(CGPointMake(minX + 0.38272 * w, minY + 0.65116 * h))
		path68Path.closePath()
		path68Path.moveToPoint(CGPointMake(minX + 0.38272 * w, minY + 0.65116 * h))
		
		return path68Path;
	}
	
	func path69PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path69Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path69Path.moveToPoint(CGPointMake(minX + 0.56471 * w, minY))
		path69Path.addLineToPoint(CGPointMake(minX + w, minY + 0.75269 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.92941 * w, minY + 0.78495 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.74118 * w, minY + 0.45161 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.56471 * w, minY + 0.95699 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.47059 * w, minY + h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.65882 * w, minY + 0.47312 * h))
		path69Path.addLineToPoint(CGPointMake(minX, minY + 0.25806 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.10588 * w, minY + 0.2043 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.72941 * w, minY + 0.4086 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.50588 * w, minY + 0.01075 * h))
		path69Path.addLineToPoint(CGPointMake(minX + 0.56471 * w, minY))
		path69Path.closePath()
		path69Path.moveToPoint(CGPointMake(minX + 0.56471 * w, minY))
		
		return path69Path;
	}
	
	func path70PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path70Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path70Path.moveToPoint(CGPointMake(minX + 0.68116 * w, minY))
		path70Path.addLineToPoint(CGPointMake(minX + w, minY + 0.85393 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.34783 * w, minY + h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.31884 * w, minY + 0.93258 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.88406 * w, minY + 0.80899 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.76812 * w, minY + 0.50562 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.23188 * w, minY + 0.62921 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.2029 * w, minY + 0.5618 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.73913 * w, minY + 0.4382 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.6087 * w, minY + 0.10112 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.02899 * w, minY + 0.22472 * h))
		path70Path.addLineToPoint(CGPointMake(minX, minY + 0.1573 * h))
		path70Path.addLineToPoint(CGPointMake(minX + 0.68116 * w, minY))
		path70Path.closePath()
		path70Path.moveToPoint(CGPointMake(minX + 0.68116 * w, minY))
		
		return path70Path;
	}
	
	func path71PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path71Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path71Path.moveToPoint(CGPointMake(minX + 0.55172 * w, minY + 0.9 * h))
		path71Path.addLineToPoint(CGPointMake(minX + w, minY + 0.9125 * h))
		path71Path.addLineToPoint(CGPointMake(minX + w, minY + h))
		path71Path.addLineToPoint(CGPointMake(minX, minY + 0.9875 * h))
		path71Path.addLineToPoint(CGPointMake(minX, minY + 0.9 * h))
		path71Path.addLineToPoint(CGPointMake(minX + 0.43103 * w, minY + 0.9125 * h))
		path71Path.addLineToPoint(CGPointMake(minX + 0.46552 * w, minY))
		path71Path.addLineToPoint(CGPointMake(minX + 0.58621 * w, minY))
		path71Path.addLineToPoint(CGPointMake(minX + 0.55172 * w, minY + 0.9 * h))
		path71Path.closePath()
		path71Path.moveToPoint(CGPointMake(minX + 0.55172 * w, minY + 0.9 * h))
		
		return path71Path;
	}
	
	func path72PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path72Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path72Path.moveToPoint(CGPointMake(minX + w, minY + 0.17442 * h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.31884 * w, minY + h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.2029 * w, minY + 0.97674 * h))
		path72Path.addLineToPoint(CGPointMake(minX, minY))
		path72Path.addLineToPoint(CGPointMake(minX + 0.11594 * w, minY + 0.02326 * h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.17391 * w, minY + 0.2907 * h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.73913 * w, minY + 0.38372 * h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.92754 * w, minY + 0.16279 * h))
		path72Path.addLineToPoint(CGPointMake(minX + w, minY + 0.17442 * h))
		path72Path.closePath()
		path72Path.moveToPoint(CGPointMake(minX + 0.17391 * w, minY + 0.37209 * h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.27536 * w, minY + 0.9186 * h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.66667 * w, minY + 0.45349 * h))
		path72Path.addLineToPoint(CGPointMake(minX + 0.17391 * w, minY + 0.37209 * h))
		path72Path.closePath()
		path72Path.moveToPoint(CGPointMake(minX + 0.17391 * w, minY + 0.37209 * h))
		
		return path72Path;
	}
	
	func path73PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path73Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path73Path.moveToPoint(CGPointMake(minX + w, minY + 0.25 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.6 * w, minY + h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.52941 * w, minY + 0.96875 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.70588 * w, minY + 0.63542 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.24706 * w, minY + 0.44792 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.07059 * w, minY + 0.78125 * h))
		path73Path.addLineToPoint(CGPointMake(minX, minY + 0.75 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.4 * w, minY))
		path73Path.addLineToPoint(CGPointMake(minX + 0.47059 * w, minY + 0.03125 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.28235 * w, minY + 0.38542 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.74118 * w, minY + 0.57292 * h))
		path73Path.addLineToPoint(CGPointMake(minX + 0.92941 * w, minY + 0.21875 * h))
		path73Path.addLineToPoint(CGPointMake(minX + w, minY + 0.25 * h))
		path73Path.closePath()
		path73Path.moveToPoint(CGPointMake(minX + w, minY + 0.25 * h))
		
		return path73Path;
	}
	
	func path74PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path74Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path74Path.moveToPoint(CGPointMake(minX + 0.82475 * w, minY + 0.09859 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.85022 * w, minY + 0.76831 * h), controlPoint1:CGPointMake(minX + 1.05398 * w, minY + 0.27222 * h), controlPoint2:CGPointMake(minX + 1.05398 * w, minY + 0.53267 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.17525 * w, minY + 0.90473 * h), controlPoint1:CGPointMake(minX + 0.65919 * w, minY + 1.00395 * h), controlPoint2:CGPointMake(minX + 0.39175 * w, minY + 1.07836 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.14978 * w, minY + 0.23501 * h), controlPoint1:CGPointMake(minX + -0.05398 * w, minY + 0.7311 * h), controlPoint2:CGPointMake(minX + -0.05398 * w, minY + 0.47066 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.82475 * w, minY + 0.09859 * h), controlPoint1:CGPointMake(minX + 0.34081 * w, minY + -0.01303 * h), controlPoint2:CGPointMake(minX + 0.60825 * w, minY + -0.07504 * h))
		path74Path.closePath()
		path74Path.moveToPoint(CGPointMake(minX + 0.77381 * w, minY + 0.1606 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.22619 * w, minY + 0.28462 * h), controlPoint1:CGPointMake(minX + 0.57004 * w, minY + 0.01178 * h), controlPoint2:CGPointMake(minX + 0.35354 * w, minY + 0.11099 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.22619 * w, minY + 0.83032 * h), controlPoint1:CGPointMake(minX + 0.0861 * w, minY + 0.45825 * h), controlPoint2:CGPointMake(minX + 0.03516 * w, minY + 0.68149 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.77381 * w, minY + 0.7063 * h), controlPoint1:CGPointMake(minX + 0.42996 * w, minY + 0.97914 * h), controlPoint2:CGPointMake(minX + 0.64646 * w, minY + 0.87993 * h))
		path74Path.addCurveToPoint(CGPointMake(minX + 0.77381 * w, minY + 0.1606 * h), controlPoint1:CGPointMake(minX + 0.9139 * w, minY + 0.54507 * h), controlPoint2:CGPointMake(minX + 0.97757 * w, minY + 0.30943 * h))
		path74Path.closePath()
		path74Path.moveToPoint(CGPointMake(minX + 0.77381 * w, minY + 0.1606 * h))
		
		return path74Path;
	}
	
	func path75PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path75Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path75Path.moveToPoint(CGPointMake(minX + w, minY + 0.43182 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.32609 * w, minY + h))
		path75Path.addLineToPoint(CGPointMake(minX, minY + 0.57955 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.05435 * w, minY + 0.53409 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.32609 * w, minY + 0.88636 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.56522 * w, minY + 0.68182 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.30435 * w, minY + 0.34091 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.3587 * w, minY + 0.29545 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.61957 * w, minY + 0.63636 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.88043 * w, minY + 0.40909 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.59783 * w, minY + 0.04545 * h))
		path75Path.addLineToPoint(CGPointMake(minX + 0.65217 * w, minY))
		path75Path.addLineToPoint(CGPointMake(minX + w, minY + 0.43182 * h))
		path75Path.closePath()
		path75Path.moveToPoint(CGPointMake(minX + w, minY + 0.43182 * h))
		
		return path75Path;
	}
	
	func path76PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path76Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path76Path.moveToPoint(CGPointMake(minX + 0.18326 * w, minY + 0.3393 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.09817 * w, minY + 0.65995 * h), controlPoint1:CGPointMake(minX + 0.07385 * w, minY + 0.3976 * h), controlPoint2:CGPointMake(minX + 0.0617 * w, minY + 0.54335 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.60873 * w, minY + 0.84943 * h), controlPoint1:CGPointMake(minX + 0.18326 * w, minY + 0.93688 * h), controlPoint2:CGPointMake(minX + 0.41423 * w, minY + 0.93688 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.90048 * w, minY + 0.31015 * h), controlPoint1:CGPointMake(minX + 0.79108 * w, minY + 0.77655 * h), controlPoint2:CGPointMake(minX + 0.98558 * w, minY + 0.60165 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.65736 * w, minY + 0.10609 * h), controlPoint1:CGPointMake(minX + 0.86402 * w, minY + 0.19355 * h), controlPoint2:CGPointMake(minX + 0.77892 * w, minY + 0.09152 * h))
		path76Path.addLineToPoint(CGPointMake(minX + 0.62089 * w, minY + 0.00407 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.97342 * w, minY + 0.281 * h), controlPoint1:CGPointMake(minX + 0.77892 * w, minY + -0.02508 * h), controlPoint2:CGPointMake(minX + 0.9248 * w, minY + 0.10609 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.63305 * w, minY + 0.95146 * h), controlPoint1:CGPointMake(minX + 1.07067 * w, minY + 0.61623 * h), controlPoint2:CGPointMake(minX + 0.88833 * w, minY + 0.84943 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.02523 * w, minY + 0.67453 * h), controlPoint1:CGPointMake(minX + 0.37776 * w, minY + 1.05348 * h), controlPoint2:CGPointMake(minX + 0.12248 * w, minY + 1.00976 * h))
		path76Path.addCurveToPoint(CGPointMake(minX + 0.14679 * w, minY + 0.20812 * h), controlPoint1:CGPointMake(minX + -0.0234 * w, minY + 0.49962 * h), controlPoint2:CGPointMake(minX + -0.01124 * w, minY + 0.29557 * h))
		path76Path.addLineToPoint(CGPointMake(minX + 0.18326 * w, minY + 0.3393 * h))
		path76Path.closePath()
		path76Path.moveToPoint(CGPointMake(minX + 0.18326 * w, minY + 0.3393 * h))
		
		return path76Path;
	}
	
	func path77PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path77Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path77Path.moveToPoint(CGPointMake(minX + w, minY + h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.0119 * w, minY + 0.69014 * h))
		path77Path.addLineToPoint(CGPointMake(minX, minY + 0.57746 * h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.89286 * w, minY))
		path77Path.addLineToPoint(CGPointMake(minX + 0.90476 * w, minY + 0.11268 * h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.66667 * w, minY + 0.26761 * h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.72619 * w, minY + 0.8169 * h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.9881 * w, minY + 0.90141 * h))
		path77Path.addLineToPoint(CGPointMake(minX + w, minY + h))
		path77Path.closePath()
		path77Path.moveToPoint(CGPointMake(minX + 0.59524 * w, minY + 0.30986 * h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.09524 * w, minY + 0.61972 * h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.65476 * w, minY + 0.78873 * h))
		path77Path.addLineToPoint(CGPointMake(minX + 0.59524 * w, minY + 0.30986 * h))
		path77Path.closePath()
		path77Path.moveToPoint(CGPointMake(minX + 0.59524 * w, minY + 0.30986 * h))
		
		return path77Path;
	}
	
	func path78PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path78Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path78Path.moveToPoint(CGPointMake(minX + 0.94048 * w, minY + h))
		path78Path.addLineToPoint(CGPointMake(minX, minY + 0.85417 * h))
		path78Path.addLineToPoint(CGPointMake(minX + 0.0119 * w, minY + 0.70833 * h))
		path78Path.addLineToPoint(CGPointMake(minX + 0.88095 * w, minY + 0.83333 * h))
		path78Path.addLineToPoint(CGPointMake(minX + 0.91667 * w, minY))
		path78Path.addLineToPoint(CGPointMake(minX + w, minY + 0.02083 * h))
		path78Path.addLineToPoint(CGPointMake(minX + 0.94048 * w, minY + h))
		path78Path.closePath()
		path78Path.moveToPoint(CGPointMake(minX + 0.94048 * w, minY + h))
		
		return path78Path;
	}
	
	func path79PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path79Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path79Path.moveToPoint(CGPointMake(minX + 0.97468 * w, minY + h))
		path79Path.addLineToPoint(CGPointMake(minX, minY + 0.26923 * h))
		path79Path.addLineToPoint(CGPointMake(minX + 0.02532 * w, minY))
		path79Path.addLineToPoint(CGPointMake(minX + w, minY + 0.73077 * h))
		path79Path.addLineToPoint(CGPointMake(minX + 0.97468 * w, minY + h))
		path79Path.closePath()
		path79Path.moveToPoint(CGPointMake(minX + 0.97468 * w, minY + h))
		
		return path79Path;
	}
	
	func path80PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path80Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path80Path.moveToPoint(CGPointMake(minX + 0.96053 * w, minY + h))
		path80Path.addLineToPoint(CGPointMake(minX, minY + 0.56164 * h))
		path80Path.addLineToPoint(CGPointMake(minX + 0.23684 * w, minY))
		path80Path.addLineToPoint(CGPointMake(minX + 0.31579 * w, minY + 0.0411 * h))
		path80Path.addLineToPoint(CGPointMake(minX + 0.11842 * w, minY + 0.52055 * h))
		path80Path.addLineToPoint(CGPointMake(minX + 0.46053 * w, minY + 0.67123 * h))
		path80Path.addLineToPoint(CGPointMake(minX + 0.64474 * w, minY + 0.21918 * h))
		path80Path.addLineToPoint(CGPointMake(minX + 0.72368 * w, minY + 0.26027 * h))
		path80Path.addLineToPoint(CGPointMake(minX + 0.53947 * w, minY + 0.71233 * h))
		path80Path.addLineToPoint(CGPointMake(minX + w, minY + 0.91781 * h))
		path80Path.addLineToPoint(CGPointMake(minX + 0.96053 * w, minY + h))
		path80Path.closePath()
		path80Path.moveToPoint(CGPointMake(minX + 0.96053 * w, minY + h))
		
		return path80Path;
	}
	
	func path81PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path81Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path81Path.moveToPoint(CGPointMake(minX + 0.91475 * w, minY + 0.81084 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.2462 * w, minY + 0.87559 * h), controlPoint1:CGPointMake(minX + 0.7538 * w, minY + 1.04396 * h), controlPoint2:CGPointMake(minX + 0.49381 * w, minY + 1.05691 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.08525 * w, minY + 0.18916 * h), controlPoint1:CGPointMake(minX + -0.00141 * w, minY + 0.69427 * h), controlPoint2:CGPointMake(minX + -0.07569 * w, minY + 0.43524 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.7538 * w, minY + 0.12441 * h), controlPoint1:CGPointMake(minX + 0.2462 * w, minY + -0.04396 * h), controlPoint2:CGPointMake(minX + 0.50619 * w, minY + -0.05691 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.91475 * w, minY + 0.81084 * h), controlPoint1:CGPointMake(minX + 1.00141 * w, minY + 0.30573 * h), controlPoint2:CGPointMake(minX + 1.07569 * w, minY + 0.56476 * h))
		path81Path.closePath()
		path81Path.moveToPoint(CGPointMake(minX + 0.85284 * w, minY + 0.75903 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.70428 * w, minY + 0.20212 * h), controlPoint1:CGPointMake(minX + 1.00141 * w, minY + 0.55181 * h), controlPoint2:CGPointMake(minX + 0.8776 * w, minY + 0.33163 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.15954 * w, minY + 0.22802 * h), controlPoint1:CGPointMake(minX + 0.53095 * w, minY + 0.0726 * h), controlPoint2:CGPointMake(minX + 0.29572 * w, minY + 0.0208 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.3081 * w, minY + 0.78493 * h), controlPoint1:CGPointMake(minX + 0.01097 * w, minY + 0.43524 * h), controlPoint2:CGPointMake(minX + 0.13478 * w, minY + 0.65542 * h))
		path81Path.addCurveToPoint(CGPointMake(minX + 0.85284 * w, minY + 0.75903 * h), controlPoint1:CGPointMake(minX + 0.48143 * w, minY + 0.91445 * h), controlPoint2:CGPointMake(minX + 0.70428 * w, minY + 0.96625 * h))
		path81Path.closePath()
		path81Path.moveToPoint(CGPointMake(minX + 0.85284 * w, minY + 0.75903 * h))
		
		return path81Path;
	}
	
	func path82PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path82Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path82Path.moveToPoint(CGPointMake(minX + 0.6 * w, minY + 0.94203 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.54737 * w, minY + h))
		path82Path.addLineToPoint(CGPointMake(minX, minY + 0.30431 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.21053 * w, minY + 0.1072 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.38947 * w, minY + 0.00285 * h), controlPoint1:CGPointMake(minX + 0.26316 * w, minY + 0.04923 * h), controlPoint2:CGPointMake(minX + 0.31579 * w, minY + 0.01444 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.56842 * w, minY + 0.08401 * h), controlPoint1:CGPointMake(minX + 0.45263 * w, minY + -0.00875 * h), controlPoint2:CGPointMake(minX + 0.51579 * w, minY + 0.01444 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.56842 * w, minY + 0.35069 * h), controlPoint1:CGPointMake(minX + 0.63158 * w, minY + 0.15358 * h), controlPoint2:CGPointMake(minX + 0.62105 * w, minY + 0.25793 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.56842 * w, minY + 0.35069 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.8 * w, minY + 0.40867 * h), controlPoint1:CGPointMake(minX + 0.66316 * w, minY + 0.29272 * h), controlPoint2:CGPointMake(minX + 0.72632 * w, minY + 0.3275 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + w, minY + 0.58259 * h), controlPoint1:CGPointMake(minX + 0.90526 * w, minY + 0.51302 * h), controlPoint2:CGPointMake(minX + 0.93684 * w, minY + 0.57099 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.93684 * w, minY + 0.64056 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.8 * w, minY + 0.51302 * h), controlPoint1:CGPointMake(minX + 0.88421 * w, minY + 0.60578 * h), controlPoint2:CGPointMake(minX + 0.84211 * w, minY + 0.5594 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.51579 * w, minY + 0.45504 * h), controlPoint1:CGPointMake(minX + 0.66316 * w, minY + 0.36229 * h), controlPoint2:CGPointMake(minX + 0.63158 * w, minY + 0.35069 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.35789 * w, minY + 0.60578 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.6 * w, minY + 0.94203 * h))
		path82Path.closePath()
		path82Path.moveToPoint(CGPointMake(minX + 0.42105 * w, minY + 0.44345 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.50526 * w, minY + 0.14198 * h), controlPoint1:CGPointMake(minX + 0.50526 * w, minY + 0.36229 * h), controlPoint2:CGPointMake(minX + 0.6 * w, minY + 0.26953 * h))
		path82Path.addCurveToPoint(CGPointMake(minX + 0.23158 * w, minY + 0.18836 * h), controlPoint1:CGPointMake(minX + 0.4 * w, minY + 0.00285 * h), controlPoint2:CGPointMake(minX + 0.29474 * w, minY + 0.13039 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.10526 * w, minY + 0.31591 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.30526 * w, minY + 0.5594 * h))
		path82Path.addLineToPoint(CGPointMake(minX + 0.42105 * w, minY + 0.44345 * h))
		path82Path.closePath()
		path82Path.moveToPoint(CGPointMake(minX + 0.42105 * w, minY + 0.44345 * h))
		
		return path82Path;
	}
	
	func path83PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path83Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path83Path.moveToPoint(CGPointMake(minX, minY + 0.28866 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.07778 * w, minY + 0.24742 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.87778 * w, minY + 0.6701 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.87778 * w, minY + 0.6701 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.51111 * w, minY + 0.03093 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.57778 * w, minY))
		path83Path.addLineToPoint(CGPointMake(minX + w, minY + 0.72165 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.91111 * w, minY + 0.76289 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.13333 * w, minY + 0.35052 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.13333 * w, minY + 0.35052 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.48889 * w, minY + 0.96907 * h))
		path83Path.addLineToPoint(CGPointMake(minX + 0.42222 * w, minY + h))
		path83Path.addLineToPoint(CGPointMake(minX, minY + 0.28866 * h))
		path83Path.closePath()
		path83Path.moveToPoint(CGPointMake(minX, minY + 0.28866 * h))
		
		return path83Path;
	}
	
	func path84PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path84Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path84Path.moveToPoint(CGPointMake(minX + 0.78125 * w, minY + h))
		path84Path.addLineToPoint(CGPointMake(minX, minY + 0.02564 * h))
		path84Path.addLineToPoint(CGPointMake(minX + 0.21875 * w, minY))
		path84Path.addLineToPoint(CGPointMake(minX + w, minY + 0.97436 * h))
		path84Path.addLineToPoint(CGPointMake(minX + 0.78125 * w, minY + h))
		path84Path.closePath()
		path84Path.moveToPoint(CGPointMake(minX + 0.78125 * w, minY + h))
		
		return path84Path;
	}
	
	func path85PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path85Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path85Path.moveToPoint(CGPointMake(minX, minY + h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.28571 * w, minY + 0.0119 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.4 * w, minY))
		path85Path.addLineToPoint(CGPointMake(minX + w, minY + 0.88095 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.88571 * w, minY + 0.89286 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.72857 * w, minY + 0.65476 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.17143 * w, minY + 0.71429 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.1 * w, minY + 0.97619 * h))
		path85Path.addLineToPoint(CGPointMake(minX, minY + h))
		path85Path.closePath()
		path85Path.moveToPoint(CGPointMake(minX + 0.7 * w, minY + 0.58333 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.37143 * w, minY + 0.08333 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.21429 * w, minY + 0.64286 * h))
		path85Path.addLineToPoint(CGPointMake(minX + 0.7 * w, minY + 0.58333 * h))
		path85Path.closePath()
		path85Path.moveToPoint(CGPointMake(minX + 0.7 * w, minY + 0.58333 * h))
		
		return path85Path;
	}
	
	func path86PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path86Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path86Path.moveToPoint(CGPointMake(minX + 0.22667 * w, minY))
		path86Path.addLineToPoint(CGPointMake(minX + 0.33333 * w, minY + 0.02174 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.70667 * w, minY + 0.86957 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.70667 * w, minY + 0.86957 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.90667 * w, minY + 0.13043 * h))
		path86Path.addLineToPoint(CGPointMake(minX + w, minY + 0.15217 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.77333 * w, minY + h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.65333 * w, minY + 0.97826 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.29333 * w, minY + 0.15217 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.29333 * w, minY + 0.15217 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.09333 * w, minY + 0.88043 * h))
		path86Path.addLineToPoint(CGPointMake(minX, minY + 0.8587 * h))
		path86Path.addLineToPoint(CGPointMake(minX + 0.22667 * w, minY))
		path86Path.closePath()
		path86Path.moveToPoint(CGPointMake(minX + 0.22667 * w, minY))
		
		return path86Path;
	}
	
	func path87PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path87Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path87Path.moveToPoint(CGPointMake(minX + 0.26052 * w, minY + 0.95124 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.0755 * w, minY + 0.31214 * h), controlPoint1:CGPointMake(minX + -0.00379 * w, minY + 0.83066 * h), controlPoint2:CGPointMake(minX + -0.06987 * w, minY + 0.58949 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.73628 * w, minY + 0.04685 * h), controlPoint1:CGPointMake(minX + 0.22087 * w, minY + 0.04685 * h), controlPoint2:CGPointMake(minX + 0.45876 * w, minY + -0.07373 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.9213 * w, minY + 0.68595 * h), controlPoint1:CGPointMake(minX + 1.01381 * w, minY + 0.16744 * h), controlPoint2:CGPointMake(minX + 1.06667 * w, minY + 0.40861 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.26052 * w, minY + 0.95124 * h), controlPoint1:CGPointMake(minX + 0.77593 * w, minY + 0.9633 * h), controlPoint2:CGPointMake(minX + 0.52483 * w, minY + 1.07183 * h))
		path87Path.closePath()
		path87Path.moveToPoint(CGPointMake(minX + 0.28695 * w, minY + 0.87889 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.81558 * w, minY + 0.64978 * h), controlPoint1:CGPointMake(minX + 0.52483 * w, minY + 0.98742 * h), controlPoint2:CGPointMake(minX + 0.72307 * w, minY + 0.83066 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.68342 * w, minY + 0.13126 * h), controlPoint1:CGPointMake(minX + 0.90809 * w, minY + 0.4689 * h), controlPoint2:CGPointMake(minX + 0.9213 * w, minY + 0.22773 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.1548 * w, minY + 0.36037 * h), controlPoint1:CGPointMake(minX + 0.44554 * w, minY + 0.02274 * h), controlPoint2:CGPointMake(minX + 0.24731 * w, minY + 0.1795 * h))
		path87Path.addCurveToPoint(CGPointMake(minX + 0.28695 * w, minY + 0.87889 * h), controlPoint1:CGPointMake(minX + 0.06229 * w, minY + 0.54125 * h), controlPoint2:CGPointMake(minX + 0.06229 * w, minY + 0.78242 * h))
		path87Path.closePath()
		path87Path.moveToPoint(CGPointMake(minX + 0.28695 * w, minY + 0.87889 * h))
		
		return path87Path;
	}
	
	func path88PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path88Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path88Path.moveToPoint(CGPointMake(minX + 0.07232 * w, minY + 0.69792 * h))
		path88Path.addLineToPoint(CGPointMake(minX, minY + 0.64583 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.60266 * w, minY))
		path88Path.addLineToPoint(CGPointMake(minX + 0.84372 * w, minY + 0.16667 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.98836 * w, minY + 0.32292 * h), controlPoint1:CGPointMake(minX + 0.90399 * w, minY + 0.20833 * h), controlPoint2:CGPointMake(minX + 0.96425 * w, minY + 0.25 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.94015 * w, minY + 0.51042 * h), controlPoint1:CGPointMake(minX + 1.01247 * w, minY + 0.38542 * h), controlPoint2:CGPointMake(minX + 1.00041 * w, minY + 0.44792 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.66292 * w, minY + 0.55208 * h), controlPoint1:CGPointMake(minX + 0.87988 * w, minY + 0.58333 * h), controlPoint2:CGPointMake(minX + 0.7714 * w, minY + 0.59375 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.66292 * w, minY + 0.55208 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.65087 * w, minY + 0.78125 * h), controlPoint1:CGPointMake(minX + 0.7473 * w, minY + 0.63542 * h), controlPoint2:CGPointMake(minX + 0.71114 * w, minY + 0.69792 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.50623 * w, minY + h), controlPoint1:CGPointMake(minX + 0.5665 * w, minY + 0.89583 * h), controlPoint2:CGPointMake(minX + 0.51829 * w, minY + 0.9375 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.43391 * w, minY + 0.94792 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.53034 * w, minY + 0.79167 * h), controlPoint1:CGPointMake(minX + 0.45802 * w, minY + 0.89583 * h), controlPoint2:CGPointMake(minX + 0.49418 * w, minY + 0.84375 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.53034 * w, minY + 0.51042 * h), controlPoint1:CGPointMake(minX + 0.65087 * w, minY + 0.63542 * h), controlPoint2:CGPointMake(minX + 0.66292 * w, minY + 0.60417 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.34954 * w, minY + 0.38542 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.07232 * w, minY + 0.69792 * h))
		path88Path.closePath()
		path88Path.moveToPoint(CGPointMake(minX + 0.54239 * w, minY + 0.4375 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.86783 * w, minY + 0.46875 * h), controlPoint1:CGPointMake(minX + 0.63882 * w, minY + 0.5 * h), controlPoint2:CGPointMake(minX + 0.75935 * w, minY + 0.58333 * h))
		path88Path.addCurveToPoint(CGPointMake(minX + 0.7714 * w, minY + 0.20833 * h), controlPoint1:CGPointMake(minX + 0.98836 * w, minY + 0.34375 * h), controlPoint2:CGPointMake(minX + 0.84372 * w, minY + 0.26042 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.62676 * w, minY + 0.10417 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.40981 * w, minY + 0.33333 * h))
		path88Path.addLineToPoint(CGPointMake(minX + 0.54239 * w, minY + 0.4375 * h))
		path88Path.closePath()
		path88Path.moveToPoint(CGPointMake(minX + 0.54239 * w, minY + 0.4375 * h))
		
		return path88Path;
	}
	
	func path89PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path89Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path89Path.moveToPoint(CGPointMake(minX + 0.67901 * w, minY + 0.31579 * h))
		path89Path.addLineToPoint(CGPointMake(minX + 0.48148 * w, minY + 0.05263 * h))
		path89Path.addLineToPoint(CGPointMake(minX + 0.54321 * w, minY))
		path89Path.addLineToPoint(CGPointMake(minX + w, minY + 0.59211 * h))
		path89Path.addLineToPoint(CGPointMake(minX + 0.93827 * w, minY + 0.64474 * h))
		path89Path.addLineToPoint(CGPointMake(minX + 0.74074 * w, minY + 0.39474 * h))
		path89Path.addLineToPoint(CGPointMake(minX + 0.04938 * w, minY + h))
		path89Path.addLineToPoint(CGPointMake(minX, minY + 0.93421 * h))
		path89Path.addLineToPoint(CGPointMake(minX + 0.67901 * w, minY + 0.31579 * h))
		path89Path.closePath()
		path89Path.moveToPoint(CGPointMake(minX + 0.67901 * w, minY + 0.31579 * h))
		
		return path89Path;
	}
	
	func path90PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path90Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path90Path.moveToPoint(CGPointMake(minX, minY + 0.42529 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.73196 * w, minY))
		path90Path.addLineToPoint(CGPointMake(minX + 0.76289 * w, minY + 0.06897 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.4433 * w, minY + 0.25287 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.64948 * w, minY + 0.68966 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.96907 * w, minY + 0.50575 * h))
		path90Path.addLineToPoint(CGPointMake(minX + w, minY + 0.57471 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.26804 * w, minY + h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.23711 * w, minY + 0.93103 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.58763 * w, minY + 0.73563 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.38144 * w, minY + 0.29885 * h))
		path90Path.addLineToPoint(CGPointMake(minX + 0.03093 * w, minY + 0.49425 * h))
		path90Path.addLineToPoint(CGPointMake(minX, minY + 0.42529 * h))
		path90Path.closePath()
		path90Path.moveToPoint(CGPointMake(minX, minY + 0.42529 * h))
		
		return path90Path;
	}
	
	func path91PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path91Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path91Path.moveToPoint(CGPointMake(minX + 0.00911 * w, minY + 0.61094 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.20113 * w, minY + 0.15474 * h), controlPoint1:CGPointMake(minX + -0.02689 * w, minY + 0.42217 * h), controlPoint2:CGPointMake(minX + 0.04512 * w, minY + 0.21766 * h))
		path91Path.addLineToPoint(CGPointMake(minX + 0.22513 * w, minY + 0.26486 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.10512 * w, minY + 0.62667 * h), controlPoint1:CGPointMake(minX + 0.08112 * w, minY + 0.31205 * h), controlPoint2:CGPointMake(minX + 0.06912 * w, minY + 0.46936 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.34514 * w, minY + 0.86263 * h), controlPoint1:CGPointMake(minX + 0.12912 * w, minY + 0.76825 * h), controlPoint2:CGPointMake(minX + 0.22513 * w, minY + 0.89409 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.46515 * w, minY + 0.61094 * h), controlPoint1:CGPointMake(minX + 0.44115 * w, minY + 0.83117 * h), controlPoint2:CGPointMake(minX + 0.46515 * w, minY + 0.72105 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.65716 * w, minY + 0.01316 * h), controlPoint1:CGPointMake(minX + 0.47715 * w, minY + 0.3907 * h), controlPoint2:CGPointMake(minX + 0.46515 * w, minY + 0.07609 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.98119 * w, minY + 0.31205 * h), controlPoint1:CGPointMake(minX + 0.81317 * w, minY + -0.04976 * h), controlPoint2:CGPointMake(minX + 0.94518 * w, minY + 0.12328 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.83718 * w, minY + 0.78398 * h), controlPoint1:CGPointMake(minX + 1.01719 * w, minY + 0.46936 * h), controlPoint2:CGPointMake(minX + 1.01719 * w, minY + 0.68959 * h))
		path91Path.addLineToPoint(CGPointMake(minX + 0.81317 * w, minY + 0.67386 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.89718 * w, minY + 0.35924 * h), controlPoint1:CGPointMake(minX + 0.92118 * w, minY + 0.62667 * h), controlPoint2:CGPointMake(minX + 0.93318 * w, minY + 0.48509 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.68116 * w, minY + 0.13901 * h), controlPoint1:CGPointMake(minX + 0.87318 * w, minY + 0.2334 * h), controlPoint2:CGPointMake(minX + 0.78917 * w, minY + 0.09182 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.35714 * w, minY + 0.98848 * h), controlPoint1:CGPointMake(minX + 0.41715 * w, minY + 0.2334 * h), controlPoint2:CGPointMake(minX + 0.68116 * w, minY + 0.87836 * h))
		path91Path.addCurveToPoint(CGPointMake(minX + 0.00911 * w, minY + 0.61094 * h), controlPoint1:CGPointMake(minX + 0.16513 * w, minY + 1.0514 * h), controlPoint2:CGPointMake(minX + 0.05712 * w, minY + 0.8469 * h))
		path91Path.closePath()
		path91Path.moveToPoint(CGPointMake(minX + 0.00911 * w, minY + 0.61094 * h))
		
		return path91Path;
	}
	
	func path92PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path92Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path92Path.moveToPoint(CGPointMake(minX + 0.89024 * w, minY + 0.44828 * h))
		path92Path.addLineToPoint(CGPointMake(minX + 0.86585 * w, minY))
		path92Path.addLineToPoint(CGPointMake(minX + 0.95122 * w, minY))
		path92Path.addLineToPoint(CGPointMake(minX + w, minY + h))
		path92Path.addLineToPoint(CGPointMake(minX + 0.91463 * w, minY + h))
		path92Path.addLineToPoint(CGPointMake(minX + 0.89024 * w, minY + 0.56897 * h))
		path92Path.addLineToPoint(CGPointMake(minX, minY + 0.65517 * h))
		path92Path.addLineToPoint(CGPointMake(minX, minY + 0.53448 * h))
		path92Path.addLineToPoint(CGPointMake(minX + 0.89024 * w, minY + 0.44828 * h))
		path92Path.closePath()
		path92Path.moveToPoint(CGPointMake(minX + 0.89024 * w, minY + 0.44828 * h))
		
		return path92Path;
	}
	
	func path93PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path93Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path93Path.moveToPoint(CGPointMake(minX + 0.10714 * w, minY))
		path93Path.addLineToPoint(CGPointMake(minX + w, minY + 0.57746 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.9881 * w, minY + 0.69014 * h))
		path93Path.addLineToPoint(CGPointMake(minX, minY + h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.0119 * w, minY + 0.88732 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.27381 * w, minY + 0.80282 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.33333 * w, minY + 0.25352 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.09524 * w, minY + 0.09859 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.10714 * w, minY))
		path93Path.closePath()
		path93Path.moveToPoint(CGPointMake(minX + 0.36905 * w, minY + 0.78873 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.92857 * w, minY + 0.61972 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.42857 * w, minY + 0.29577 * h))
		path93Path.addLineToPoint(CGPointMake(minX + 0.36905 * w, minY + 0.78873 * h))
		path93Path.closePath()
		path93Path.moveToPoint(CGPointMake(minX + 0.36905 * w, minY + 0.78873 * h))
		
		return path93Path;
	}
	
	func path94PathWithBounds(bound: CGRect) -> UIBezierPath{
		let path94Path = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		path94Path.moveToPoint(CGPointMake(minX + 0.17204 * w, minY + 0.10037 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.19355 * w, minY))
		path94Path.addLineToPoint(CGPointMake(minX + w, minY + 0.37279 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.90323 * w, minY + 0.7169 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.7957 * w, minY + 0.94631 * h), controlPoint1:CGPointMake(minX + 0.88172 * w, minY + 0.81727 * h), controlPoint2:CGPointMake(minX + 0.84946 * w, minY + 0.88896 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.60215 * w, minY + 0.97499 * h), controlPoint1:CGPointMake(minX + 0.74194 * w, minY + 1.00367 * h), controlPoint2:CGPointMake(minX + 0.67742 * w, minY + 1.018 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.48387 * w, minY + 0.68823 * h), controlPoint1:CGPointMake(minX + 0.51613 * w, minY + 0.93198 * h), controlPoint2:CGPointMake(minX + 0.47312 * w, minY + 0.81727 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.48387 * w, minY + 0.68823 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.25806 * w, minY + 0.78859 * h), controlPoint1:CGPointMake(minX + 0.43011 * w, minY + 0.81727 * h), controlPoint2:CGPointMake(minX + 0.35484 * w, minY + 0.81727 * h))
		path94Path.addCurveToPoint(CGPointMake(minX, minY + 0.73124 * h), controlPoint1:CGPointMake(minX + 0.11828 * w, minY + 0.74558 * h), controlPoint2:CGPointMake(minX + 0.06452 * w, minY + 0.7169 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.03226 * w, minY + 0.61654 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.2043 * w, minY + 0.65955 * h), controlPoint1:CGPointMake(minX + 0.09677 * w, minY + 0.61654 * h), controlPoint2:CGPointMake(minX + 0.15054 * w, minY + 0.63088 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.48387 * w, minY + 0.53051 * h), controlPoint1:CGPointMake(minX + 0.39785 * w, minY + 0.73124 * h), controlPoint2:CGPointMake(minX + 0.43011 * w, minY + 0.73124 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.55914 * w, minY + 0.25809 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.17204 * w, minY + 0.10037 * h))
		path94Path.closePath()
		path94Path.moveToPoint(CGPointMake(minX + 0.55914 * w, minY + 0.51617 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.62366 * w, minY + 0.88896 * h), controlPoint1:CGPointMake(minX + 0.52688 * w, minY + 0.65955 * h), controlPoint2:CGPointMake(minX + 0.48387 * w, minY + 0.83161 * h))
		path94Path.addCurveToPoint(CGPointMake(minX + 0.84946 * w, minY + 0.65955 * h), controlPoint1:CGPointMake(minX + 0.77419 * w, minY + 0.96065 * h), controlPoint2:CGPointMake(minX + 0.8172 * w, minY + 0.75992 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.90323 * w, minY + 0.44448 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.6129 * w, minY + 0.31544 * h))
		path94Path.addLineToPoint(CGPointMake(minX + 0.55914 * w, minY + 0.51617 * h))
		path94Path.closePath()
		path94Path.moveToPoint(CGPointMake(minX + 0.55914 * w, minY + 0.51617 * h))
		
		return path94Path;
	}
	
	func circleInMaskPathWithBounds(bound: CGRect) -> UIBezierPath{
		let circleInMaskPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		circleInMaskPath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		circleInMaskPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY + h), controlPoint1:CGPointMake(minX + w, minY + 0.77614 * h), controlPoint2:CGPointMake(minX + 0.77614 * w, minY + h))
		circleInMaskPath.addCurveToPoint(CGPointMake(minX, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.22386 * w, minY + h), controlPoint2:CGPointMake(minX, minY + 0.77614 * h))
		circleInMaskPath.addCurveToPoint(CGPointMake(minX + 0.5 * w, minY), controlPoint1:CGPointMake(minX, minY + 0.22386 * h), controlPoint2:CGPointMake(minX + 0.22386 * w, minY))
		circleInMaskPath.addCurveToPoint(CGPointMake(minX + w, minY + 0.5 * h), controlPoint1:CGPointMake(minX + 0.77614 * w, minY), controlPoint2:CGPointMake(minX + w, minY + 0.22386 * h))
		circleInMaskPath.closePath()
		circleInMaskPath.moveToPoint(CGPointMake(minX + w, minY + 0.5 * h))
		
		return circleInMaskPath;
	}
	
	func markEndPathWithBounds(bound: CGRect) -> UIBezierPath{
		let markEndPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		markEndPath.moveToPoint(CGPointMake(minX + 0.29333 * w, minY + h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.09333 * w, minY + 0.99023 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.74667 * w, minY + 0.68945 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.04 * w, minY + 0.66797 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.72 * w, minY + 0.35156 * h))
		markEndPath.addLineToPoint(CGPointMake(minX, minY + 0.33008 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.72 * w, minY))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.92 * w, minY + 0.00781 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.26667 * w, minY + 0.30859 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.97333 * w, minY + 0.33008 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + 0.29333 * w, minY + 0.64648 * h))
		markEndPath.addLineToPoint(CGPointMake(minX + w, minY + 0.66797 * h))
		markEndPath.closePath()
		markEndPath.moveToPoint(CGPointMake(minX + 0.29333 * w, minY + h))
		
		return markEndPath;
	}
	
	func markStartPathWithBounds(bound: CGRect) -> UIBezierPath{
		let markStartPath = UIBezierPath()
		let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
		
		markStartPath.moveToPoint(CGPointMake(minX + w, minY + h))
		markStartPath.addLineToPoint(CGPointMake(minX, minY + h))
		markStartPath.addLineToPoint(CGPointMake(minX, minY + 0.72047 * h))
		markStartPath.addLineToPoint(CGPointMake(minX, minY + 0.62008 * h))
		markStartPath.addLineToPoint(CGPointMake(minX, minY + 0.37795 * h))
		markStartPath.addLineToPoint(CGPointMake(minX, minY + 0.2874 * h))
		markStartPath.addLineToPoint(CGPointMake(minX, minY))
		markStartPath.addLineToPoint(CGPointMake(minX + w, minY))
		markStartPath.addLineToPoint(CGPointMake(minX + w, minY + 0.29134 * h))
		markStartPath.addLineToPoint(CGPointMake(minX + w, minY + 0.37992 * h))
		markStartPath.addLineToPoint(CGPointMake(minX + w, minY + 0.61811 * h))
		markStartPath.addLineToPoint(CGPointMake(minX + w, minY + 0.72047 * h))
		markStartPath.closePath()
		markStartPath.moveToPoint(CGPointMake(minX + w, minY + h))
		
		return markStartPath;
	}
	
	
}
