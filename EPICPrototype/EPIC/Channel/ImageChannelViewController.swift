//
//  ImageChannelViewController.swift
//  EPIC
//
//  Created by VIRAKRI JINANGKUL on 2/21/16.
//  Copyright © 2016 VIRAKRI JINANGKUL. All rights reserved.
//

import UIKit
import ARNTransitionAnimator

class ImageChannelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewWaterfallLayoutDelegate, allUsersCollectionViewLayoutDelegate, UIGestureRecognizerDelegate, ARNImageTransitionZoomable{

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
    
    @IBOutlet weak var cameraButton: SpringButton!
    
    var transition = QZCircleSegue()
    
    var animator : ARNTransitionAnimator?
    
    weak var selectedImageView : UIImageView?
    
    
    let imageData = imageDataSource().DataSetted
    let userDataStore = userDataSource().DataSetted
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        
        let lpgr = UITapGestureRecognizer(target: self, action: "handleLongPress:")
//        lpgr.minimumPressDuration = 0.333
//        lpgr.allowableMovement = 20.0
        lpgr.numberOfTapsRequired = 2
        lpgr.delegate = self
        self.imageCollectionView.addGestureRecognizer(lpgr)
        
        
//        let tgr = UITapGestureRecognizer(target: self, action: "handleTap:")
//        //        lpgr.allowableMovement = 100.0
//        tgr.delegate = self
//        self.imageCollectionView.addGestureRecognizer(tgr)
//        UIView.setAnimationsEnabled(false)
        //print(imageData)
        
//        let storeChannelNameLabelTopConstraint = channelNameLabelTopConstraint.constant
//        let storeChannelNameLabelLeftConstaint = channelNameLabelLeftConstaint.constant
//        let storeChannelDateLabelTopConstraint = channelDateLabelTopConstraint.constant
//        let storeAllUsersCollectionViewTopConstraint = allUsersCollectionViewTopConstraint.constant
        //store Constraint

        // Paint Work
        channelNameLabel.attributedText = NSAttributedString(string: channelNameLabel.text!, attributes: NSDictionary.headerExtraLargeScalableAttributes(UIColor.colorEpicBlack(), alignmentValue: NSTextAlignment.Left, fontSize: 24, kernValue: 0.8))
        channelDateLabel.attributedText = NSAttributedString(string: channelDateLabel.text!, attributes: NSDictionary.subtextMediumAttributes())
        
        
        viewAllUsersButton.setAttributedTitle(NSAttributedString(string: "View all ▸", attributes:  NSDictionary.callToActionFloatAttributes(NSTextAlignment.Left)), forState: .Normal)
//        viewAllUsersButton.buttonWithType

        
        
        navigationBar.backgroundColor = UIColor.colorEpicWhite()
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        
            //imageData.populateData()
        
        // Attach imageCollectionView datasource and delegate
        imageCollectionView.dataSource  = self
        imageCollectionView.delegate = self
         //
        

        
        //Layout setup
        setupCollectionView()
        
        //Register nibs
        registerNibs()

        //Animation
        //let animator = CKWaveCollectionViewAnimator()
        
        
        //prepare animation
        channelNameLabel.alpha = 0
        channelDateLabel.alpha = 0
        viewAllUsersButton.alpha = 0
        imageCollectionView.alpha = 0
        cameraButton.alpha = 0
        
        
        cameraButton.layer.cornerRadius = 36
        cameraButton.layer.shadowColor = UIColor.blackColor().CGColor
        cameraButton.layer.shadowOpacity = 0.33
        cameraButton.layer.shadowRadius = 12.0
        cameraButton.layer.shadowOffset = CGSize(width: 0, height: 12)
        cameraButton.layer.masksToBounds = false
        cameraButton.layer.rasterizationScale = 2.0
        cameraButton.layer.shouldRasterize = true
        
        
//        UIView.setAnimationsEnabled(true)
        
        
        
        
        
        
        
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.channelNameLabel.alpha = 0
        self.channelDateLabel.alpha = 0
        self.viewAllUsersButton.alpha = 0
        self.imageCollectionView.alpha = 0
        self.allUserView.alpha = 0
        self.cameraButton.alpha = 0
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        var urls = [NSURL]()
        for i in 1...20 {
            urls.append(NSURL(string:"http://lorempixel.com/400/400/people/\(i)/")!)
        }
        
        
        
        
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
            self.channelNameLabel.alpha = 1
            self.channelDateLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.2, options: .CurveLinear, animations: {
            self.viewAllUsersButton.alpha = 1
            self.allUserView.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.4, options: .CurveLinear, animations: {
            self.imageCollectionView.alpha = 1
            }, completion: nil)
        
        allUserView.usersThumbURLs = urls
        

        cameraButton.animation = "squeezeUp"
        cameraButton.curve = "easeOut"
        cameraButton.force = 0.7
        cameraButton.duration = 0.77
        cameraButton.delay = 0.4
        cameraButton.animate()
        view.bringSubviewToFront(cameraButton)
        
        delay(1.5) {
            self.performSegueWithIdentifier("segueToAlert", sender: self)
            self.cameraButton.userInteractionEnabled = true
            self.imageCollectionView.userInteractionEnabled = true
        }
        
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(delay * Double(NSEC_PER_SEC))),dispatch_get_main_queue(), closure)
    }

    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueCamera") {
            /* Send the button to your transition manager */
            self.transition.animationChild = cameraButton
            /* Set the color to your transition manager*/
            self.transition.animationColor = UIColor(red: 0/255, green: 217/255, blue: 144/255, alpha: 1.0)
            
            let toViewController = segue.destinationViewController as! XMCCameraViewController
            /* Set both, the origin and destination to your transition manager*/
            self.transition.fromViewController = self
            self.transition.toViewController = toViewController
            /* Add the transition manager to your transitioningDelegate View Controller*/
            toViewController.transitioningDelegate = transition
        } else if segue.identifier == "segueToSelectedImageView"{
            let indexPaths = imageCollectionView.indexPathsForSelectedItems()
            print(indexPaths)
            let indexPath = indexPaths![0] as NSIndexPath
            //            var previewItem = DataSetted[indexPath.row]
            
            let selectedImageSetup = segue.destinationViewController as! selectedImageViewController
//            selectedImageSetup.imageView.image = UIImageVi
            
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let fromNavBarShadowTopConstraint: CGFloat = 144
        let toNavBarShadowTopConstraint: CGFloat = 0
        
        let fromChannelNameLabelFontSize: CGFloat = 24
        let toChannelNameLabelFontSize: CGFloat = 18
        
        let fromChannelNameLabelKernValue: CGFloat = 0.8
        let toChannelNameLabelKernValue: CGFloat = 0.3
        
        let fromChannelNameLabelLeftConstaint: CGFloat = 64//self.storeChannelNameLabelLeftConstaint
        let toChannelNameLabelLeftConstaint: CGFloat = 28 // self.screenSize.width / 2 - channelNameLabel.frame.size.width / 2 // when it has the icon to the menu change it to 48
        
        let fromChannelNameLabelTopConstaint: CGFloat = 168//self.storeChannelNameLabelTopConstraint
        let toChannelNameLabelTopConstaint: CGFloat = 48
        
        let fromNavBarShadowStartFade: CGFloat = 144
        
        let scrollPositionTouchNav: CGFloat = 216
        
        
        let fontsizeFactorMultiple: CGFloat = (fromChannelNameLabelFontSize-toChannelNameLabelFontSize)/scrollPositionTouchNav
        let kernValueFactorMultiple: CGFloat = (fromChannelNameLabelKernValue-toChannelNameLabelKernValue)/scrollPositionTouchNav
        let channelNameLabelLeftMultiple: CGFloat = (fromChannelNameLabelLeftConstaint-toChannelNameLabelLeftConstaint)/scrollPositionTouchNav//((self.screenSize.width / 2 - channelNameLabel.frame.size.width / 2) - CGFloat(fromChannelNameLabelLeftConstaint) ) /  scrollPositionTouchNav
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
    
    
    
    
    //MARK: - CollectionView Delegate Methods
    
    //** Number of Cells in the CollectionView */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == imageCollectionView){
            return imageData.count
        }
        return 0
    }
    
    
    //** Create a basic CollectionView Cell */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
  
            // Create the cell and return the cell
            let subCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! imageUICollectionViewCell
        
            // Add image to cell
            subCell.image.image = UIImage(named: imageData[indexPath.row].imageName)
        subCell.imageGray.image = subCell.convertToGrayScale(UIImage(named: imageData[indexPath.row].imageName)!)
        subCell.imageGray.alpha = 0
        
            //cell.author.text = imageData[indexPath.row].author
            subCell.author.attributedText =  NSAttributedString(string: imageData[indexPath.row].author, attributes:  NSDictionary.headerSmallAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Natural))
            
            return subCell

        
    }
    
    // MARK: WaterfallLayoutDelegate
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // create a cell size from the image size, and return the size
        var cellSize = CGSize(width: 16, height: 16)
        if (collectionView == imageCollectionView){
        let getImage : UIImage = UIImage(named: imageData[indexPath.row].imageName)!
        let imageSize = getImage.size
            cellSize = imageSize
            
        }
        return cellSize
    }

    
    
    ///////////////////////////
    
    
    
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = cell as? imageUICollectionViewCell {
            cell.cellWrapView.alpha = 0
            
            UIView.animateWithDuration(0.4) {
                cell.cellWrapView.alpha = 1
            }
        }
        
        
    }
    
    
    ////////////////////
    
    
    
    func centerPointWithSizeToFrame(point: CGPoint, size: CGSize) -> CGRect {
        return CGRectMake(point.x - (size.width/2), point.y - (size.height/2), size.width, size.height)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //// somthing
    
    
    
    func showInteractive() {
        let storyboard = UIStoryboard(name: "imageChannel", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("selectedImageViewController") as! selectedImageViewController
        
        let operationType: ARNTransitionAnimatorOperation = .Present
        let animator = ARNTransitionAnimator(operationType: operationType, fromVC: self, toVC: controller)
        
        animator.presentationBeforeHandler = { [weak self, weak controller] (containerView: UIView, transitionContext: UIViewControllerContextTransitioning) in
            containerView.addSubview(self!.view)
            containerView.addSubview(controller!.view)
//            controller!.closeButton.hidden = true
            
            controller!.view.layoutIfNeeded()
            
            let sourceImageView = self!.createTransitionImageView()
            let destinationImageView = controller!.createTransitionImageView()
            
            containerView.addSubview(sourceImageView)
            
            controller!.presentationBeforeAction()
            
            controller!.view.alpha = 0.0
            
            
            
            animator.presentationAnimationHandler = { (containerView: UIView, percentComplete: CGFloat) in
                sourceImageView.frame = destinationImageView.frame
                
                controller!.view.alpha = 1.0
            }
            
            animator.presentationCompletionHandler = { (containerView: UIView, completeTransition: Bool) in
                sourceImageView.removeFromSuperview()
                self!.presentationCompletionAction(completeTransition)
                controller!.presentationCompletionAction(completeTransition)
            }
        }
        
        animator.dismissalBeforeHandler = { [weak self, weak controller] (containerView: UIView, transitionContext: UIViewControllerContextTransitioning) in
            containerView.addSubview(self!.view)
            containerView.bringSubviewToFront(controller!.view)
            
            let sourceImageView = controller!.createTransitionImageView()
            let destinationImageView = self!.createTransitionImageView()
            containerView.addSubview(sourceImageView)
            
            let sourceFrame = sourceImageView.frame;
            let destFrame = destinationImageView.frame;
            
            controller!.dismissalBeforeAction()
            
            animator.dismissalCancelAnimationHandler = { (containerView: UIView) in
                sourceImageView.frame = sourceFrame
                controller!.view.alpha = 1.0
            }
            
            animator.dismissalAnimationHandler = { (containerView: UIView, percentComplete: CGFloat) in
                if percentComplete < -0.05 { return }
                let frame = CGRectMake(
                    destFrame.origin.x - (destFrame.origin.x - sourceFrame.origin.x) * (1 - percentComplete),
                    destFrame.origin.y - (destFrame.origin.y - sourceFrame.origin.y) * (1 - percentComplete),
                    destFrame.size.width + (sourceFrame.size.width - destFrame.size.width) * (1 - percentComplete),
                    destFrame.size.height + (sourceFrame.size.height - destFrame.size.height) * (1 - percentComplete)
                )
                sourceImageView.frame = frame
                controller!.view.alpha = 1.0 - (1.0 * percentComplete)
            }
            
            animator.dismissalCompletionHandler = { (containerView: UIView, completeTransition: Bool) in
                self!.dismissalCompletionAction(completeTransition)
                controller!.dismissalCompletionAction(completeTransition)
                sourceImageView.removeFromSuperview()
            }
        }
        
        self.animator = animator

    }
    

    
    
    
    // MARK: - ARNImageTransitionZoomable
    
        func createTransitionImageView() -> UIImageView {
            let imageView = UIImageView(image: self.selectedImageView!.image)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit//self.selectedImageView!.contentMode
//            imageView.backgroundColor = UIColor.purpleColor()
            imageView.clipsToBounds = true
            imageView.userInteractionEnabled = false
            imageView.frame = self.selectedImageView!.convertRect(self.selectedImageView!.frame, toView: self.view)
            
            return imageView
        }
    
    func presentationCompletionAction(completeTransition: Bool) {
        self.selectedImageView?.hidden = true
    }
    
    func dismissalCompletionAction(completeTransition: Bool) {
        self.selectedImageView?.hidden = false
    }
    
    
    
    
    
    
    
    // MARK: - UICollectionViewDelegate
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! imageUICollectionViewCell
//        let controller = UIStoryboard(name: "imageChannel", bundle: nil).instantiateViewControllerWithIdentifier("selectedImageViewController") as! selectedImageViewController
//        let segueID = "segueToSelectedImageView"
//        performSegueWithIdentifier(segueID, sender: cell.image.image)
//        self.selectedImageView = cell.image
////        controller.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5)
//        //segueToSelectedImageView
//        print(cell.image.image)
//        print(indexPath)
////        self.handleTransition()
//    }
    
    //MARK: Prepare Segue
    
    

    
    
    

    
    func handleTransition() {
        let storyboard = UIStoryboard(name: "imageChannel", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("selectedImageViewController") as! selectedImageViewController
        controller.transitioningDelegate = controller
//        controller.imageView.image = self.selectedImageView?.image
        self.presentViewController(controller, animated: true, completion: nil)
    }

    
    
    
    func handleLongPress(gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.Began {
            
            let p = gestureReconizer.locationInView(self.imageCollectionView)
            let indexPath = self.imageCollectionView.indexPathForItemAtPoint(p)
            
            if let index = indexPath {
                let cell = imageCollectionView.cellForItemAtIndexPath(indexPath!) as! imageUICollectionViewCell
                //var cell = self.imageCollectionView.cellForItemAtIndexPath(index)
                // do stuff with your cell, for example print the indexPath
                UIView.animateWithDuration(0.00, delay: 0, options: .CurveLinear, animations: {
                    cell.transform = CGAffineTransformMakeScale(1, 1)
                    cell.stolenSymbol.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    cell.stolenSymbol.alpha = 0
                    cell.imageGray.alpha = 0
                    cell.greenOverlay.alpha = 0
                    //cell.
                    }, completion: nil )
                
                print(index.row)
            }
            
            
            
        }
        
        if gestureReconizer.state == UIGestureRecognizerState.Ended {
            
            let p = gestureReconizer.locationInView(self.imageCollectionView)
            let indexPath = self.imageCollectionView.indexPathForItemAtPoint(p)
            
            if let index = indexPath {
                let cell = imageCollectionView.cellForItemAtIndexPath(indexPath!) as! imageUICollectionViewCell
                // do stuff with your cell, for example print the indexPath
                //cell?.transform = CGAffineTransformMakeScale(1.1, 1.1)
                UIView.animateWithDuration(0.05, delay: 0, options: .CurveEaseOut,animations: {
                    cell.stolenSymbol.alpha = 1
                    cell.transform = CGAffineTransformMakeScale(1, 1)
                    cell.stolenSymbol.transform = CGAffineTransformMakeScale(1, 1)
                    
                    }, completion: nil)
                UIView.animateWithDuration(0.75, animations: {
                
                    cell.imageGray.alpha = 0
                    cell.greenOverlay.alpha = 0
                    cell.greenDot.hidden = false
                })
                
                UIView.animateWithDuration(0.25, delay: 1, options: .CurveLinear,animations: {
                    
                   cell.stolenSymbol.alpha = 0
                }, completion: nil )
                
                print(index.row)
            } else {
                print("Could not find index path")
            }

        }
        
        
    }
    

//    func handleTap(gestureReconizer: UITapGestureRecognizer) {
//        if gestureReconizer.state != .Ended {
//            return
//        }
//        
//        let p = gestureReconizer.locationInView(self.imageCollectionView)
//        let indexPath = self.imageCollectionView.indexPathForItemAtPoint(p)
//        
//        if let index = indexPath {
//            var cell = self.imageCollectionView.cellForItemAtIndexPath(index)
//            // do stuff with your cell, for example print the indexPath
//            cell?.transform = CGAffineTransformMakeScale(1.1, 1.1)
//            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .CurveLinear , animations: {
//                cell?.transform = CGAffineTransformMakeScale(1, 1)
//                }, completion: nil)
//            
//            print(index.row)
//        } else {
//            print("Could not find index path")
//        }
//    }
    
    
    /////////////
    
    
    //    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation,
    //        fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    //
    //            let animator = CKWaveCollectionViewAnimator()
    //            animator.animationDuration = 0.7
    //
    //            if operation != UINavigationControllerOperation.Push {
    //
    //                animator.reversed = true
    //            }
    //            
    //            return animator
    //    }
    
    func minimizeView(sender: AnyObject) {
        SpringAnimation.springEaseInOut(0.5, animations: {
            self.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
        })
    }
    
    func maximizeView(sender: AnyObject) {
        SpringAnimation.springEaseInOut(0.5, animations: {
            self.view.transform = CGAffineTransformMakeScale(1, 1)
        })
    }
    
}
