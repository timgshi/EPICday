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
    
    private var headerContainerTopConstraintInitialValue: CGFloat = 0.0
    private var descriptionLabelTopConstraintInitialValue: CGFloat = 0.0
    private var usersContainerTopConstraintInitialValue: CGFloat = 0.0
    
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
        let channelRef = baseRef.childByAppendingPath("channels/-KA-1sbul1bQREXo6_sa")
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
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.shadowColor = UIColor.blackColor().CGColor
        cameraButton.layer.shadowOpacity = 0.5
        cameraButton.layer.shadowRadius = 12.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setupInitialConstraintValues()
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
        headerContainerTopConstraintInitialValue = headerContainerTopConstraint.constant
        descriptionLabelTopConstraintInitialValue = descriptionLabelTopConstraint.constant
        usersContainerTopConstraintInitialValue = usersContainerTopConstraint.constant
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
        var cellSize = CGSize(width: 16, height: 16)
        if (collectionView == imageCollectionView) {
            let photo = self.dataSource?.photoAtIndexPath(indexPath)
            cellSize = (photo?.size)!
        }
        return cellSize
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        var multiplier: CGFloat = 5
        if offset > 0 {
            multiplier = 10
        }

        headerContainerTopConstraint.constant = (1 - (offset / (headerContainerTopConstraintInitialValue * 1.5))) * headerContainerTopConstraintInitialValue
        descriptionLabelTopConstraint.constant = (1 - (offset / (descriptionLabelTopConstraintInitialValue * multiplier))) * descriptionLabelTopConstraintInitialValue
        usersContainerTopConstraint.constant = (1 - (offset / (usersContainerTopConstraintInitialValue * multiplier))) * usersContainerTopConstraintInitialValue
        
        headerContainerView.alpha = 1 - (offset / 200)
        channelNameLabel.alpha = 1 - headerContainerView.alpha
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