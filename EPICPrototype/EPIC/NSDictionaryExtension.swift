import UIKit

extension NSDictionary {

	static func navigationTitleAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "SFUIText-Semibold", size: 17) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Center
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicBlack()
		let kern = -0.4099999964237213
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func navigationButtonLeftAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 17) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Natural
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicGreen()
		let kern = -0.4099999964237213
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func navigationButtonRightAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 17) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Right
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicGreen()
		let kern = -0.4099999964237213
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func alertPrimaryAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "SFUIText-Medium", size: 17) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Center
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicGreen()
		let kern = -0.4099999964237213
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func alertButtonAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "SFUIText-Regular", size: 17) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Center
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicGreen()
		let kern = -0.4099999964237213
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func alertDescriptionAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "SFUIText-Regular", size: 13) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 16
		paragraph.alignment = NSTextAlignment.Center
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicBlack()
		let kern = -0.07999999821186066
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func alertTitleAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "SFUIText-Medium", size: 17) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Center
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicBlack()
		let kern = -0.4099999964237213
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func navigationPrimaryButtonRightAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Bold", size: 17) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Right
		paragraph.paragraphSpacing = 0
        let color = UIColor.colorEpicGreen()
		//let color = UIColor(red: 00, green: 0.8509803921568627, blue: 0.564705882352941, alpha: 1)
		let kern = -0.4099999964237213
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func jumboTitleAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Bold", size: 42) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 36
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicBlack()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func jumboSubTitleAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 22) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 24
		paragraph.alignment = NSTextAlignment.Natural
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicBlack()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

    static func callToActionButtonAttributes(colorValue: UIColor) -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Bold", size: 12) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Center
		paragraph.paragraphSpacing = 0
        let color = colorValue
		let kern = 0.5
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

    static func callToActionFloatAttributes(alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 12) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 12
		paragraph.alignment = alignmentValue
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicGreen()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

    static func headerExtraLargeAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
        guard let font = UIFont(name: "FuturaLT-Heavy", size: 24) else {
            fatalError("Can't load font")
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 24
        paragraph.alignment = alignmentValue
        paragraph.paragraphSpacing = 0
        let color = colorValue
        let kern = 0
        return [NSFontAttributeName: font,
            NSKernAttributeName: kern,
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: paragraph,
        ]
    }
    
    static func headerExtraLargeScalableAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment, fontSize: CGFloat, kernValue: CGFloat) -> [String: AnyObject]? {
        guard let font = UIFont(name: "FuturaLT-Heavy", size: fontSize) else {
            fatalError("Can't load font")
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 24
        paragraph.alignment = alignmentValue
        paragraph.paragraphSpacing = 0
        paragraph.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        let color = colorValue
        let kern = kernValue
        return [NSFontAttributeName: font,
            NSKernAttributeName: kern,
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: paragraph,
        ]
    }

	static func headerLargeAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Bold", size: 18) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 20
		paragraph.alignment = alignmentValue
		paragraph.paragraphSpacing = 0
		let color = colorValue
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func headerLargeTightAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Heavy", size: 18) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 20
		paragraph.alignment = alignmentValue
		paragraph.paragraphSpacing = 0
		let color = colorValue
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}
    
    static func headerMediumAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
        guard let font = UIFont(name: "FuturaLT-Bold", size: 14) else {
            fatalError("Can't load font")
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 16
        paragraph.alignment = alignmentValue
        paragraph.paragraphSpacing = 0
        let color = colorValue
        let kern = 0
        return [NSFontAttributeName: font,
            NSKernAttributeName: kern,
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: paragraph,
        ]
    }
    
    static func headerSmallAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
        guard let font = UIFont(name: "FuturaLT-Bold", size: 12) else {
            fatalError("Can't load font")
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 12
        paragraph.alignment = alignmentValue
        paragraph.paragraphSpacing = 0
        let color = colorValue
        let kern = 0
        return [NSFontAttributeName: font,
            NSKernAttributeName: kern,
            NSForegroundColorAttributeName: color,
            NSParagraphStyleAttributeName: paragraph,
        ]
    }

	static func bodyMediumAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 14) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 20
		paragraph.alignment = alignmentValue
		paragraph.paragraphSpacing = 8
		let color = colorValue
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func bodyLargeAttributes(colorValue: UIColor, alignmentValue: NSTextAlignment) -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 16) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 24
		paragraph.alignment = alignmentValue
		paragraph.paragraphSpacing = 12
		let color = colorValue
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func subtextSmallAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 12) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 12
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 8
		let color = UIColor.colorBlendedEpicBlack()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func subtextMediumAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 14) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 12
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 8
		let color = UIColor.colorBlendedEpicBlack()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func subtextLargeAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 16) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 16
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 8
		let color = UIColor.colorBlendedEpicBlack()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func epicTemplateDetailBoldAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Bold", size: 6) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 8
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicWhite()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func epicTemplateDetailParameterAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 6) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 8
		paragraph.alignment = NSTextAlignment.Right
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicWhite()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func epicTemplateDetailAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 6) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 8
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicWhite()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func epicTemplatePropertiesTitleAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Bold", size: 12) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 0
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 0
		let color = UIColor.colorEpicWhite()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}

	static func bodySmallAttributes() -> [String: AnyObject]? {
		guard let font = UIFont(name: "FuturaLT-Book", size: 12) else {
			fatalError("Can't load font")
		}
		let paragraph = NSMutableParagraphStyle()
		paragraph.minimumLineHeight = 16
		paragraph.alignment = NSTextAlignment.Left
		paragraph.paragraphSpacing = 8
		let color = UIColor.colorEpicBlack()
		let kern = 0
		return [NSFontAttributeName: font,
			NSKernAttributeName: kern,
			NSForegroundColorAttributeName: color,
			NSParagraphStyleAttributeName: paragraph,
		]
	}


}