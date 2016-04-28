//
//  ImageChannelViewController.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 2/21/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit

import Firebase
import Bolts
import SDWebImage
import ReactiveCocoa
import NYTPhotoViewer

class ImageChannelViewController: UIViewController, UICollectionViewDelegate, CollectionViewWaterfallLayoutDelegate {

    //outlet Constraints
    @IBOutlet weak var channelNameLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var channelNameLabelLeftConstaint: NSLayoutConstraint!
    
    @IBOutlet weak var channelDateLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var allUsersCollectionViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navBarShadowTopConstraint: NSLayoutConstraint!
    
    // outlet elements

    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var channelDateLabel: UILabel!
    
    @IBOutlet weak var viewAllUsersButton: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var navBarShadowImage: UIImageView!
    
    @IBOutlet weak var allUserView: UserThumbnailsView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    var dataSource: ChannelStreamDataSource?
    var selectedChannel: Channel?
    
    let cameraTransition = QZCircleSegue()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //store Constraint

        // Paint Work
        channelNameLabel.attributedText = NSAttributedString(string: channelNameLabel.text!, attributes: NSDictionary.headerExtraLargeScalableAttributes(UIColor.colorEpicBlack(), alignmentValue: NSTextAlignment.Left, fontSize: 24, kernValue: 0.8))
        channelDateLabel.attributedText = NSAttributedString(string: channelDateLabel.text!, attributes: NSDictionary.subtextMediumAttributes())
        viewAllUsersButton.setAttributedTitle(NSAttributedString(string: "View all ▸", attributes:  NSDictionary.callToActionFloatAttributes(NSTextAlignment.Left)), forState: .Normal)
        
        navigationBar.backgroundColor = UIColor.colorEpicWhite()
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        imageCollectionView.delegate = self
        
        //Layout setup
        setupCollectionView()
        
        //Register nibs
        registerNibs()
        
        let channelInitialLoadTaskSource = BFTaskCompletionSource()
        
        let baseRef = Firebase(url:"https://incandescent-inferno-9043.firebaseio.com/")
        let channelRef = baseRef.childByAppendingPath("channels/-KA-1sbul1bQREXo6_sa")
        channelRef.observeAuthEventWithBlock { (authData) -> Void in
            if authData == nil {
                print("user was logged out")
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        channelRef.updateChildValues(["members/\(channelRef.authData.uid)": 1])
        self.selectedChannel = Channel(fromRef: channelRef, withInitialLoadTaskSource: channelInitialLoadTaskSource)
        
        self.dataSource = ChannelStreamDataSource(channel: self.selectedChannel, inCollectionView: self.imageCollectionView, andReuseIdentifier: "cell")
        self.dataSource?.populateCell = { blockCell, photo in
            
            let imageCell = blockCell as! ImageCell
            imageCell.photo = photo
            imageCell.delegate = self
            
            let userRef = photo.post.userRef
            let user = User(fromRef: userRef)
            let nameSignal = user.rac_valuesForKeyPath("displayName", observer: user)
                                .takeUntil(imageCell.rac_prepareForReuseSignal)
            nameSignal.subscribeNext {
                (next:AnyObject!) -> () in
                imageCell.authorLabel.text = user.displayName
            }
            photo.rac_valuesForKeyPath("timestamp", observer: photo)
                .takeUntil(imageCell.rac_prepareForReuseSignal)
                .subscribeNext {
                    (next:AnyObject!) -> () in
                    imageCell.setTimeAgoTextFromDate(photo.timestamp)
            }
            imageCell.cellDidTapBlock = {
                (blockCell:ImageCell) in
                self.showFullScreenImageViewFromCell(blockCell, photo: photo)
            }
        }
        
        channelInitialLoadTaskSource.task.continueWithBlock { (task) -> AnyObject? in
            self.imageCollectionView.reloadData()
            self.channelNameLabel.attributedText = NSAttributedString(string: (self.selectedChannel?.name!)!, attributes: NSDictionary.headerExtraLargeScalableAttributes(UIColor.colorEpicBlack(), alignmentValue: NSTextAlignment.Left, fontSize: 24, kernValue: 0.8))
            self.channelDateLabel.attributedText = NSAttributedString(string: (self.selectedChannel?.purpose!)!, attributes: NSDictionary.subtextMediumAttributes())
            self.selectedChannel?.fetchMemberThumbUrls().continueWithBlock({ (task) -> AnyObject? in
                let urls = task.result as! [NSURL]
                self.allUserView.usersThumbURLs = urls
                return nil;
            });
            return nil
        }

        //Animation
        //let animator = CKWaveCollectionViewAnimator()
        
        
        //prepare animation
        channelNameLabel.alpha = 0
        channelDateLabel.alpha = 0
        viewAllUsersButton.alpha = 0
        imageCollectionView.alpha = 0
        
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.shadowColor = UIColor.blackColor().CGColor
        cameraButton.layer.shadowOpacity = 0.5
        cameraButton.layer.shadowRadius = 12.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
            self.channelNameLabel.alpha = 1
            self.channelDateLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.2, options: .CurveLinear, animations: {
            self.viewAllUsersButton.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.4, options: .CurveLinear, animations: {
            self.imageCollectionView.alpha = 1
            }, completion: nil)
            }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "EPICCaptureSegue") {
            self.cameraTransition.animationChild = cameraButton
            self.cameraTransition.animationColor = UIColor(red: 0/255, green: 217/255, blue: 144/255, alpha: 1.0)
        }
        
        let toViewController = segue.destinationViewController as! FilteredCaptureViewController
        toViewController.selectedChannel = self.selectedChannel
        self.cameraTransition.fromViewController = self
        self.cameraTransition.toViewController = toViewController
        /* Add the transition manager to your transitioningDelegate View Controller*/
        toViewController.transitioningDelegate = self.cameraTransition
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let fromNavBarShadowTopConstraint: CGFloat = 144
        let toNavBarShadowTopConstraint: CGFloat = 0
        
        let fromChannelNameLabelFontSize: CGFloat = 24
        let toChannelNameLabelFontSize: CGFloat = 18
        
        let fromChannelNameLabelKernValue: CGFloat = 0.8
        let toChannelNameLabelKernValue: CGFloat = 0.3
        
        let fromChannelNameLabelLeftConstaint: CGFloat = 64
        let toChannelNameLabelLeftConstaint: CGFloat = 28
        
        let fromChannelNameLabelTopConstaint: CGFloat = 168
        let toChannelNameLabelTopConstaint: CGFloat = 48
        
        let fromNavBarShadowStartFade: CGFloat = 144
        
        let scrollPositionTouchNav: CGFloat = 216
        
        
        let fontsizeFactorMultiple: CGFloat = (fromChannelNameLabelFontSize-toChannelNameLabelFontSize)/scrollPositionTouchNav
        let kernValueFactorMultiple: CGFloat = (fromChannelNameLabelKernValue-toChannelNameLabelKernValue)/scrollPositionTouchNav
        let channelNameLabelLeftMultiple: CGFloat = (fromChannelNameLabelLeftConstaint-toChannelNameLabelLeftConstaint)/scrollPositionTouchNav
        let NavBarShadowTopConstraintMultiple: CGFloat = (fromNavBarShadowTopConstraint-toNavBarShadowTopConstraint)/scrollPositionTouchNav
        
        channelDateLabelTopConstraint.constant = 192 - ( scrollView.contentOffset.y  ) * (0.66)
        allUsersCollectionViewTopConstraint.constant = 208 - ( scrollView.contentOffset.y  ) * (0.75)
        
        
        //print(scrollView.contentOffset.y)
        if (scrollView.contentOffset.y >= fromNavBarShadowStartFade) {
            if(scrollView.contentOffset.y < scrollPositionTouchNav) {
                navBarShadowImage.alpha = (1 / (scrollPositionTouchNav - fromNavBarShadowStartFade)) *  ( scrollView.contentOffset.y   - fromNavBarShadowStartFade)
            }else{
                navBarShadowImage.alpha = 1
            }
        } else {
            navBarShadowImage.alpha = 0
        }
        

            //allUsersCollectionViewTopConstraint.constant = 144 - ( scrollView.contentOffset.y + 64 )
            //channelNameLabelTopConstraint.constant = 168 - ( scrollView.contentOffset.y )
        
        let offsetY = max(0 , scrollView.contentOffset.y)
        allUserView.alpha = 1 - (offsetY * 0.01)
        viewAllUsersButton.alpha = 1 - (offsetY * 0.01)
        channelDateLabel.alpha = 1 - (offsetY * 0.02)
        

        if (scrollView.contentOffset.y < scrollPositionTouchNav)
        {
            channelNameLabelTopConstraint.constant = fromChannelNameLabelTopConstaint - ( scrollView.contentOffset.y  ) * (0.56)
            if(scrollView.contentOffset.y > 0)
            {
                channelNameLabel.attributedText = NSAttributedString(string: channelNameLabel.text!, attributes: NSDictionary.headerExtraLargeScalableAttributes(UIColor.colorEpicBlack(),
                    alignmentValue: NSTextAlignment.Left,
                    fontSize: fromChannelNameLabelFontSize - (scrollView.contentOffset.y * fontsizeFactorMultiple),
                    kernValue: fromChannelNameLabelKernValue - (scrollView.contentOffset.y * kernValueFactorMultiple)
                    ))
                channelNameLabelLeftConstaint.constant =  fromChannelNameLabelLeftConstaint - (channelNameLabelLeftMultiple * scrollView.contentOffset.y)
                navBarShadowTopConstraint.constant = fromNavBarShadowTopConstraint - (NavBarShadowTopConstraintMultiple * scrollView.contentOffset.y)
            } else {
                channelNameLabel.attributedText = NSAttributedString(string: channelNameLabel.text!, attributes: NSDictionary.headerExtraLargeScalableAttributes(UIColor.colorEpicBlack(),
                    alignmentValue: NSTextAlignment.Left,
                    fontSize: fromChannelNameLabelFontSize ,
                    kernValue: fromChannelNameLabelKernValue// - scrollView.contentOffset.y * 0.025
                    )
                )
                channelNameLabelLeftConstaint.constant = fromChannelNameLabelLeftConstaint
                navBarShadowTopConstraint.constant = fromNavBarShadowTopConstraint
            }
            
        } else {
            channelNameLabel.attributedText = NSAttributedString(string: channelNameLabel.text!, attributes: NSDictionary.headerExtraLargeScalableAttributes(UIColor.colorEpicBlack(), alignmentValue: NSTextAlignment.Left, fontSize: toChannelNameLabelFontSize, kernValue: toChannelNameLabelKernValue))
            channelNameLabelLeftConstaint.constant = toChannelNameLabelLeftConstaint
            channelNameLabelTopConstraint.constant = toChannelNameLabelTopConstaint
            navBarShadowTopConstraint.constant = toNavBarShadowTopConstraint
        }
    }
    
    
    
    //MARK: - CollectionView UI Setup
    func setupCollectionView(){
        
        // Do any additional setup after loading the view.
        
        let layout = CollectionViewWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        layout.headerInset = UIEdgeInsetsMake(20, 0, 0, 0)
        layout.headerHeight = 264
        layout.footerHeight = 96
        layout.minimumColumnSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        imageCollectionView.collectionViewLayout = layout
        imageCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        imageCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionFooter, withReuseIdentifier: "Footer")
        
    }
    
    // Register CollectionView Nibs
    func registerNibs(){
        
        // attach the UI nib file for the ImageUICollectionViewCell to the collectionview
        let viewNib = UINib(nibName: "imageUICollectionViewCell", bundle: nil)
        imageCollectionView.registerNib(viewNib, forCellWithReuseIdentifier: "cell")
        
    }
    
    // MARK: WaterfallLayoutDelegate
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // create a cell size from the image size, and return the size
        var cellSize = CGSize(width: 16, height: 16)
        if (collectionView == imageCollectionView) {
            let photo = self.dataSource?.photoAtIndexPath(indexPath)
            cellSize = (photo?.size)!
            
        }
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.contentView.alpha = 0
        
        UIView.animateWithDuration(0.4) {
            cell.contentView.alpha = 1
        }
    }
    
    func centerPointWithSizeToFrame(point: CGPoint, size: CGSize) -> CGRect {
        return CGRectMake(point.x - (size.width/2), point.y - (size.height/2), size.width, size.height)
    }
    
    func showFullScreenImageViewFromCell(cell: ImageCell, photo: Photo) {
        let photoViewController = NYTPhotosViewController(photos: [PhotoProvider(image: cell.image)])
        photoViewController.leftBarButtonItem = nil;
        photoViewController.rightBarButtonItem = nil;
        self.presentViewController(photoViewController, animated: true, completion: nil)
    }
}

class PhotoProvider: NSObject, NYTPhoto {
    var image: UIImage?
    
    init (image: UIImage?) {
        self.image = image
    }
    
    var imageData: NSData? = nil
    var placeholderImage: UIImage? = nil
    var attributedCaptionTitle: NSAttributedString? = nil
    var attributedCaptionCredit: NSAttributedString? = nil
    var attributedCaptionSummary: NSAttributedString? = nil
}

extension ImageChannelViewController: ImageCellDelegate {
    func imageCellDidLongPress(cell: ImageCell) {
        if let image = cell.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        } else {
            self.presentViewController(UIAlertController(title: "Error", message: "Could not save photo", preferredStyle: .Alert), animated: true, completion: nil)
        }
    }
}