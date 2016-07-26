//
//  ParallexBanner.swift
//  Pods
//
//  Created by huangwenchen on 16/7/23.
//
//

import Foundation
import UIKit
import Kingfisher

public enum ParallexBannerTransition{
    case Normal
    case Parallex
    //Maybe I will add some transition in the future
}
@objc public protocol ParallexBannerDelegate {
    optional func banner(_ banner:ParallexBanner,didClickAtIndex index:NSInteger)
    optional func banner(_ banner:ParallexBanner,didScrollToIndex index:NSInteger)
}

@objc public protocol ParallexBannerDataSource{
    func numberOfBannersIn(_ bannner:ParallexBanner)->NSInteger
    func banner(_ banner:ParallexBanner,urlOrImageAtIndex index:NSInteger)->AnyObject
    optional func banner(_ banner:ParallexBanner,placeHolderForIndex index:NSInteger)->UIImage?
    optional func banner(_ banner:ParallexBanner,contentModeAtIndex index:NSInteger)->UIViewContentMode
}

public class ParallexBanner: UIView {
// MARK: - Propertys -
    public  weak var dataSource:ParallexBannerDataSource?{
        didSet{
            reloadData()
        }
    }
    public  weak var delegate:ParallexBannerDelegate?
        /// The transitionMode when scroll,default is .Parallex
    public  var transitionMode:ParallexBannerTransition = ParallexBannerTransition.Parallex
        /// Weather to enable timer based scroll
    public  var autoScroll:Bool = true {
        didSet{
            if autoScroll{
                stopTimerIfNecessory()
                startTimer()
            }else{
                stopTimerIfNecessory()
            }
        }
    }
        /// Weather to enable scroll if there is only one page
    public  var enableScrollForSinglePage = false
        /// The speed of parallex scroll,it should between 0.1 to 0.8
    public  var parllexSpeed:CGFloat = 0.4
        /// The duration between an auto scroll fire
    public  var autoScrollTimeInterval:NSTimeInterval = 3.0 {
        didSet{
            stopTimerIfNecessory()
            startTimer()
        }
    }
        /// The page Control
    public  let pageControl:UIPageControl = UIPageControl()
        /// The current index of page
    public  var currentIndex:Int{
        get{
            if _currentIndex == 0 {
                return self.dataSource!.numberOfBannersIn(self) + 2 - 3
            }else if(_currentIndex == self.dataSource!.numberOfBannersIn(self) + 2 - 1){
                return  0;
            }else{
                return _currentIndex - 1
            }
        }
    };
    
    private var _currentIndex = 1
    private var collectionView:UICollectionView!
    private var timer:NSTimer?
    private var flowLayout:UICollectionViewFlowLayout!
    
// MARK: - Init -
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit(){
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        flowLayout.minimumLineSpacing = 0.0
        collectionView = UICollectionView(frame:CGRectZero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()
        pageControl.hidesForSinglePage = true
        pageControl.userInteractionEnabled = false
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.registerClass(BannerCell.self, forCellWithReuseIdentifier: "cell")
    }
// MARK: - Layout -
    public override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.itemSize = self.frame.size
        if let ds = self.dataSource{
            pageControl.numberOfPages = ds.numberOfBannersIn(self)
        }else{
            pageControl.numberOfPages = 0
        }
        pageControl.sizeToFit()
        collectionView.frame = self.bounds
        pageControl.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds) - CGRectGetHeight(pageControl.bounds)/2)
    }
// MARK: - API -
    public func reloadData(){
        _currentIndex = 1;
        if let ds = self.dataSource{
            let targetCount = ds.numberOfBannersIn(self);
            pageControl.numberOfPages = targetCount
            pageControl.currentPage = 0
            collectionView.reloadData()
            if targetCount == 1 && enableScrollForSinglePage == false{
                stopTimerIfNecessory()
            }else{
                let indexPath = NSIndexPath(forItem: _currentIndex, inSection: 0)
                collectionView.setContentOffset(CGPointMake(CGRectGetWidth(self.bounds), 0), animated: false)
                stopTimerIfNecessory()
                startTimer()
            }
        }else{
            pageControl.numberOfPages = 0
            collectionView.reloadData()
        }
        setNeedsLayout()
    }
// MARK: - Life Circle -
    public override func willMoveToSuperview(newSuperview: UIView?) {
        if newSuperview == nil{
            stopTimerIfNecessory()
        }
        super.willMoveToSuperview(newSuperview)
    }
    deinit{
        stopTimerIfNecessory()
    }
// MARK: - Private -
    private func startTimer(){
        stopTimerIfNecessory()
        if  autoScroll == false {
            return
        }
        self.timer = NSTimer(timeInterval: self.autoScrollTimeInterval, target: self, selector: #selector(ParallexBanner.scrollToNext), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
    }
    private func stopTimerIfNecessory(){
        if self.timer != nil{
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    @objc private func scrollToNext(){
        _currentIndex = (_currentIndex + 1) % (self.dataSource!.numberOfBannersIn(self) + 2);
        let nextIndx = NSIndexPath(forItem: _currentIndex, inSection: 0)
        collectionView.scrollToItemAtIndexPath(nextIndx, atScrollPosition: UICollectionViewScrollPosition.None, animated: true)
    }
}

//Handle dataSource/Delegate and scrollViewScroll
extension ParallexBanner:UICollectionViewDataSource,UICollectionViewDelegate{
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.dataSource != nil else{
            return 0
        }
        let count = self.dataSource!.numberOfBannersIn(self);
        if count == 1 && enableScrollForSinglePage == false{
            return count;
        }
        return count + 2;
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        assert(dataSource != nil)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! BannerCell
        let index = indexPath.item;
        var adjustIndex = index
        if index == 0{
            adjustIndex = self.dataSource!.numberOfBannersIn(self) + 2 - 3
        }else if index == self.dataSource!.numberOfBannersIn(self) + 2 - 1 {
            adjustIndex = 0;
        }else{
            adjustIndex = index - 1
        }
        let imageOrURL = self.dataSource!.banner(self, urlOrImageAtIndex: adjustIndex)
        let placeHolder = self.dataSource!.banner?(self, placeHolderForIndex: adjustIndex)
        let contentMode = self.dataSource!.banner?(self, contentModeAtIndex: adjustIndex)
        if let mode = contentMode{
            cell.imageView.contentMode = mode
        }
        if let url = imageOrURL as? String{
            let url = NSURL(string: url)
            cell.imageView.kf_setImageWithURL(url, placeholderImage: placeHolder, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        }
        if let image = imageOrURL as? UIImage{
            cell.imageView.image = image
        }
        handleEffect(cell)
        return cell
    }
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        self.delegate?.banner?(self, didClickAtIndex: currentIndex)
    }
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        guard autoScroll else{
            return;
        }
        stopTimerIfNecessory()
    }
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        guard autoScroll else{
            return;
        }
        startTimer()
    }
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        var offSetX = scrollView.contentOffset.x
        let width = CGRectGetWidth(scrollView.frame)
        guard width != 0 else{
            return
        }
        if offSetX >= width * CGFloat(self.dataSource!.numberOfBannersIn(self) + 2 - 1){
            offSetX = width;
            scrollView.contentOffset = CGPointMake(offSetX,0);
        }else if(offSetX <= 0 ){
            offSetX = width * CGFloat(self.dataSource!.numberOfBannersIn(self) + 2 - 2);
            scrollView.contentOffset = CGPointMake(offSetX,0);
        }
        _currentIndex = Int((offSetX + width / 2.0) / width);
        if pageControl.currentPage != currentIndex{
            pageControl.currentPage = currentIndex
            self.delegate?.banner?(self, didScrollToIndex: currentIndex)

        }
        //Calculate offset for visiable cell
        collectionView.visibleCells().forEach { (cell) in
            if let bannerCell = cell as? BannerCell{
               handleEffect(bannerCell)
            }
        }
    }
    private func handleEffect(cell:BannerCell){
        switch transitionMode {
        case .Parallex:
            let minusX = self.collectionView.contentOffset.x - cell.frame.origin.x
            let imageOffsetX = -minusX * parllexSpeed;
            cell.scrollView.contentOffset = CGPointMake(imageOffsetX, 0)
        default:
            break
        }
    }
}

public class BannerCell:UICollectionViewCell{
    let imageView = UIImageView()
    let scrollView = UIScrollView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    private func commonInit(){
        contentView.addSubview(scrollView)
        scrollView.scrollEnabled = false
        scrollView.userInteractionEnabled = false
        scrollView.addSubview(imageView)
        imageView.contentMode = UIViewContentMode.ScaleAspectFill;
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = self.bounds.size;
        scrollView.frame = self.bounds
        imageView.frame = scrollView.bounds
    }
}