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

class ImageChannelViewController: UIViewController, UICollectionViewDelegate, CollectionViewWaterfallLayoutDelegate, allUsersCollectionViewLayoutDelegate{

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
    
    let imageData = imageDataSource().DataSetted
    let userDataStore = userDataSource().DataSetted
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var dataSource: ChannelStreamDataSource?
    var selectedChannel: Channel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        

        
        
        navigationBar.backgroundColor = UIColor.colorEpicWhite()
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        
            //imageData.populateData()
        
        // Attach imageCollectionView datasource and delegate
//        imageCollectionView.dataSource  = self
        imageCollectionView.delegate = self
         //
        

        
        //Layout setup
        setupCollectionView()
        
        //Register nibs
        registerNibs()
        
        let channelInitialLoadTaskSource = BFTaskCompletionSource()
        
        let baseRef = Firebase(url:"https://incandescent-inferno-9043.firebaseio.com/")
        let channelRef = baseRef.childByAppendingPath("channels/-KA-1sbul1bQREXo6_sa")
        self.selectedChannel = Channel(fromRef: channelRef, withInitialLoadTaskSource: channelInitialLoadTaskSource)
        
        
        self.dataSource = ChannelStreamDataSource(channel: self.selectedChannel, inCollectionView: self.imageCollectionView, andReuseIdentifier: "cell")
        self.dataSource?.populateCell = { blockCell, photo in
            
            let imageCell = blockCell as! imageUICollectionViewCell
            imageCell.image.sd_setImageWithURL(photo.imageUrl)
            let userRef = photo.post.userRef
            let user = User(fromRef: userRef)
            let nameSignal = user.rac_valuesForKeyPath("displayName", observer: user)
                                .takeUntil(imageCell.rac_prepareForReuseSignal)
            nameSignal.subscribeNext {
                (next:AnyObject!) -> () in
                imageCell.author.text = user.displayName
            }
        }
        
        channelInitialLoadTaskSource.task.continueWithBlock { (task) -> AnyObject? in
            self.imageCollectionView.reloadData()
            return nil
        }

        //Animation
        //let animator = CKWaveCollectionViewAnimator()
        
        
        //prepare animation
        channelNameLabel.alpha = 0
        channelDateLabel.alpha = 0
        viewAllUsersButton.alpha = 0
        imageCollectionView.alpha = 0
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var urls = [NSURL]()
        for i in 1...20 {
            urls.append(NSURL(string:"https://lorempixel.com/400/400/people/\(i)/")!)
        }
        
        allUserView.usersThumbURLs = urls
        
        
        
        
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (collectionView == imageCollectionView){
//            return imageData.count
//        }
//        return 0
//    }
//    
//    
//    //** Create a basic CollectionView Cell */
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//  
//            // Create the cell and return the cell
//            let subCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! imageUICollectionViewCell
//        
//            // Add image to cell
//            subCell.image.image = UIImage(named: imageData[indexPath.row].imageName)
//            //cell.author.text = imageData[indexPath.row].author
//            subCell.author.attributedText =  NSAttributedString(string: imageData[indexPath.row].author, attributes:  NSDictionary.headerSmallAttributes(UIColor.colorEpicWhite(), alignmentValue: NSTextAlignment.Natural))
//            
//            return subCell
//
//        
//    }
    
    // MARK: WaterfallLayoutDelegate
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // create a cell size from the image size, and return the size
        var cellSize = CGSize(width: 16, height: 16)
        if (collectionView == imageCollectionView) {
            let photo = self.dataSource?.photoAtIndexPath(indexPath)
            cellSize = (photo?.size)!
//            let getImage : UIImage = UIImage(named: imageData[indexPath.row].imageName)!
//            let imageSize = getImage.size
//                cellSize = imageSize
            
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
    
    
}
