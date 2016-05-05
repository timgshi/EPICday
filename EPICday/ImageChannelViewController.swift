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

extension UINavigationController {
    override public func shouldAutorotate() -> Bool {
        return self.topViewController?.shouldAutorotate() ?? true
    }

    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return self.topViewController?.supportedInterfaceOrientations() ?? UIInterfaceOrientationMask.All;
    }
}

class ImageChannelViewController: UIViewController {
    
    @IBOutlet private weak var headerContainerView: UIView!
    @IBOutlet private weak var channelNameLabel: UILabel!
    @IBOutlet private weak var channelDescriptionLabel: UILabel!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var allUserView: UserThumbnailsView!
    @IBOutlet private weak var cameraButton: UIButton!
    
    @IBOutlet private weak var headerContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var descriptionLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var usersContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var loadingContainerView: UIView!
    @IBOutlet private weak var loadingView: EPICLoadingAnimationView!
    
    private var headerContainerTopConstraintInitialValue: CGFloat = 0.0
    private var descriptionLabelTopConstraintInitialValue: CGFloat = 0.0
    private var usersContainerTopConstraintInitialValue: CGFloat = 0.0
    private var headerContainerViewInitialMaxY: CGFloat = 0.0
    
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
        let channelRef = baseRef.childByAppendingPath("channels/-KGseIiuZPZga4D5OWkU")

    //  uncomment to quickly make a new channel w/ auto ID
    //  let channelRef = baseRef.childByAppendingPath("channels").childByAutoId()
        channelRef.observeAuthEventWithBlock { (authData) -> Void in
            if authData == nil {
                print("user was logged out")
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        channelRef.updateChildValues(["members/\(channelRef.authData.uid)": 1])
        self.selectedChannel = Channel(fromRef: channelRef, withInitialLoadTaskSource: channelInitialLoadTaskSource)
        self.channelNameLabel.alpha = 0
        self.dataSource = ChannelStreamDataSource(channel: self.selectedChannel, inCollectionView: self.imageCollectionView, andReuseIdentifier: "cell")
        self.dataSource?.populateCell = { blockCell, photo in
            
            let imageCell = blockCell as! ImageCell
            imageCell.photo = photo
            imageCell.delegate = self

            let userRef = photo.userRef
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
            photo.rac_valuesForKeyPath("thumbnailUrl", observer: photo)
                .takeUntil(imageCell.rac_prepareForReuseSignal)
                .subscribeNext({ (next) in
                    imageCell.thumbnailURL = photo.thumbnailUrl
                })
            imageCell.cellDidTapBlock = {
                (blockCell:ImageCell) in
                self.showFullScreenImageViewFromCell(blockCell, photo: photo)
            }
        }
        
        channelInitialLoadTaskSource.task.continueWithBlock { (task) -> AnyObject? in
            self.loadingView.stopAnimation()
            UIView.animateWithDuration(0.2, animations: { 
                self.loadingContainerView.alpha = 0
            })
            
            self.imageCollectionView.reloadData()
            self.channelDescriptionLabel.attributedText = self.channelDescriptionAttributedString()
            
            if let channelName = self.selectedChannel?.name {
                self.channelNameLabel.text = "#\(channelName)"
            }
            
            self.selectedChannel?.fetchMemberThumbUrls().continueWithBlock({ (task) -> AnyObject? in
                let urls = task.result as! [NSURL]
                self.allUserView.usersThumbURLs = urls
                return nil;
            });
            self.view.layoutIfNeeded()

            if let layout = self.imageCollectionView.collectionViewLayout as? CollectionViewWaterfallLayout {
                layout.headerHeight = Float(self.headerContainerView.frame.maxY + 64.0)
            }
            
            return nil
        }
        
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        cameraButton.layer.masksToBounds = false
        cameraButton.layer.shadowColor = UIColor.blackColor().CGColor
        cameraButton.layer.shadowOpacity = 0.3
        cameraButton.layer.shadowRadius = 12.0
        cameraButton.layer.shadowOffset = CGSize(width: 0, height: 11.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupInitialConstraintValues()
        
        if (self.selectedChannel?.name == nil) {
            self.loadingContainerView.alpha = 1
            self.loadingView.startAnimation()
        }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    @IBAction func cameraButtonTapped(sender: AnyObject?) {
        CameraAccessRequester().runWithCameraAccessRequestIfNecessary { (authorized) in
            if (authorized) {
                self.showCamera()
            } else {
                self.showCameraAccessErrorMessage()
            }
        }
    }
    
    func showCamera () {
        cameraTransition.animationChild = cameraButton
        cameraTransition.animationColor = UIColor(red: 0/255, green: 217/255, blue: 144/255, alpha: 1.0)
        
        guard let cameraViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CameraViewController") as? CameraViewController else {
            fatalError("Could not load camera view controller")
        }
        
        cameraViewController.selectedChannel = selectedChannel
        cameraTransition.fromViewController = self
        cameraTransition.toViewController = cameraViewController
        cameraViewController.transitioningDelegate = cameraTransition
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    func showCameraAccessErrorMessage () {
        let alertController = UIAlertController(title: "Bummer!", message: "EPICday doesn't have permission to use the camera. Please go to the Settings app and grant access", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Description Attributed String
    func channelDescriptionAttributedString () -> NSAttributedString? {
        guard let channelName = selectedChannel?.name else {
            return nil
        }
        
        let string = "This is the #\(channelName) channel. Created by Sqweebl on Skwixtember 34, 2017."
        let attributedString = NSMutableAttributedString(string: string, attributes: NSDictionary.descriptionBodyAttributes())
        
        
        let channelRange = (string as NSString).rangeOfString(channelName)
        let nameRange = (string as NSString).rangeOfString("Sqweebl")
        
        attributedString.addAttributes(NSDictionary.descriptionChannelNameAttributes(), range: channelRange)
        attributedString.addAttributes(NSDictionary.descriptionCreatorNameAttributes(), range: nameRange)
        return attributedString
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
    
    func registerNibs(){
        
        // attach the UI nib file for the ImageUICollectionViewCell to the collectionview
        let viewNib = UINib(nibName: "imageUICollectionViewCell", bundle: nil)
        imageCollectionView.registerNib(viewNib, forCellWithReuseIdentifier: "cell")
    }
    
    func setupInitialConstraintValues () {
        if headerContainerTopConstraintInitialValue == 0.0 && descriptionLabelTopConstraintInitialValue == 0.0 && usersContainerTopConstraintInitialValue == 0.0 {
            headerContainerTopConstraintInitialValue = headerContainerTopConstraint.constant
            descriptionLabelTopConstraintInitialValue = descriptionLabelTopConstraint.constant
            usersContainerTopConstraintInitialValue = usersContainerTopConstraint.constant
            headerContainerViewInitialMaxY = headerContainerView.frame.maxY
        }
    }
    
    // MARK: Interactions
    func showFullScreenImageViewFromCell(cell: ImageCell, photo: Photo) {
        let photoViewController = NYTPhotosViewController(photos: [PhotoProvider(image: cell.image)])
        photoViewController.leftBarButtonItem = nil;
        photoViewController.rightBarButtonItem = nil;
        self.presentViewController(photoViewController, animated: true, completion: nil)
    }
}

extension ImageChannelViewController: UICollectionViewDelegate, CollectionViewWaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // create a cell size from the image size, and return the size
        var cellSize = CGSize(width: 2448.0, height: 3264.0)
        if (collectionView == imageCollectionView) {
            if let photo = self.dataSource?.photoAtIndexPath(indexPath) {
                cellSize = photo.size
            }
        }
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? ImageCell {
            cell.visible = true
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset > (scrollView.contentSize.height - (self.view.frame.height * 2))  && !(self.dataSource?.isLoading ?? true) {
            self.dataSource?.loadNextPage()
        }
        
        if (offset > self.view.frame.height) {
            return
        }
        
        var descriptionMultiplier: CGFloat = 18
        var usersMultiplier: CGFloat = 20
        if offset < 0 {
            descriptionMultiplier = 8
            usersMultiplier = 10
        }

        headerContainerTopConstraint.constant = (1 - (offset / (headerContainerTopConstraintInitialValue * 1.75))) * headerContainerTopConstraintInitialValue
        descriptionLabelTopConstraint.constant = (1 - (offset / (descriptionLabelTopConstraintInitialValue * descriptionMultiplier))) * descriptionLabelTopConstraintInitialValue
        usersContainerTopConstraint.constant = (1 - (offset / (usersContainerTopConstraintInitialValue * usersMultiplier))) * usersContainerTopConstraintInitialValue
        
        let transitionPercent = ((offset * (offset / 300)) / (headerContainerViewInitialMaxY - 64));
        headerContainerView.alpha = 1 - transitionPercent
        
        if (offset > 0) {
            let headerScale = 1 - (transitionPercent * 0.2)
            headerContainerView.transform = CGAffineTransformMakeScale(headerScale, headerScale)
        }
        
        if transitionPercent <= 1 {
            let titleScale = 1 - ((1 - transitionPercent) * 0.1)
            channelNameLabel.transform = CGAffineTransformMakeScale(titleScale, titleScale)
        }
        
        if offset >= 0 {
            channelNameLabel.alpha = 1 - headerContainerView.alpha
        }
    }
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