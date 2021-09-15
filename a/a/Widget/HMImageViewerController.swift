//
//  HMImageViewerController.swift
//  a
//
//  Created by HM on 2021/9/9.
//


/*
 使用 push
 let imageInfo   = STImageInfo(image: someImage, imageMode: .aspectFit)
 let imageViewer = STImageViewerController(imageInfo: imageInfo)
 navigationController?.pushViewController(imageViewer, animated: true)
 
 
 使用present
 let imageInfo      = HMImageInfo(image: someImage, imageMode: .aspectFill, imageHD: someHDImageURLOrNil)
 let transitionInfo = STTransitionInfo(fromView: someView)
 let imageViewer    = STImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
 present(imageViewer, animated: true, completion: nil)
 */

import UIKit

public struct HMImageInfo {
    
    public enum ImageMode: Int {
        case aspectFit  = 1
        case aspectFill = 2
    }
    
    public let image: UIImage
    public let imageMode: ImageMode
    public var imageHD: URL?
    
    public var contentMode: UIView.ContentMode {
        return UIView.ContentMode(rawValue: imageMode.rawValue)!
    }
    
    public init(image: UIImage, imageMode: ImageMode) {
        self.image     = image
        self.imageMode = imageMode
    }
    
    public init(image: UIImage, imageMode: ImageMode, imageHD: URL?) {
        self.init(image: image, imageMode: imageMode)
        self.imageHD = imageHD
    }
    
    func calculate(rect: CGRect, origin: CGPoint? = nil, imageMode: ImageMode? = nil) -> CGRect {
        switch imageMode ?? self.imageMode {
            
        case .aspectFit:
            return rect
            
        case .aspectFill:
            let r = max(rect.size.width / image.size.width, rect.size.height / image.size.height)
            let w = image.size.width * r
            let h = image.size.height * r
            
            return CGRect(
                x: origin?.x ?? rect.origin.x - (w - rect.width) / 2,
                y: origin?.y ?? rect.origin.y - (h - rect.height) / 2,
                width: w,
                height: h
            )
        }
    }
    
    func calculateMaximumZoomScale(_ size: CGSize) -> CGFloat {
        return max(2, max(
            image.size.width  / size.width,
            image.size.height / size.height
        ))
    }
    
}

open class HMTransitionInfo {
    
    public enum Animation {
        case linear
        case spring(damping: CGFloat, initialVelocity: CGFloat)
    }
    
    open var duration: TimeInterval = 0.35
    open var canSwipe: Bool         = true
    open var animation: Animation   = .linear
    
    public init(fromView: UIView) {
        self.fromView = fromView
    }
    
    public init(fromRect: CGRect) {
        self.convertedRect = fromRect
    }
    
    weak var fromView: UIView?
    
    fileprivate var fromRect: CGRect!
    fileprivate var convertedRect: CGRect!
    
}

open class HMImageViewerController: UIViewController {
    
    public let imageView  = UIImageView()
    public let scrollView = UIScrollView()
    
    public let imageInfo: HMImageInfo
    
    open var transitionInfo: HMTransitionInfo?
    
    open var dismissCompletion: (() -> Void)?
    
    open var backgroundColor: UIColor = .black {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    
    open lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }()
    
    // MARK: Initialization
    
    public init(imageInfo: HMImageInfo) {
        self.imageInfo = imageInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(imageInfo: HMImageInfo, transitionInfo: HMTransitionInfo) {
        self.init(imageInfo: imageInfo)
        self.transitionInfo = transitionInfo
        
        if let fromView = transitionInfo.fromView, let referenceView = fromView.superview {
            transitionInfo.fromRect = referenceView.convert(fromView.frame, to: nil)
            
            if fromView.contentMode != imageInfo.contentMode {
                transitionInfo.convertedRect = imageInfo.calculate(
                    rect: transitionInfo.fromRect!,
                    imageMode: HMImageInfo.ImageMode(rawValue: fromView.contentMode.rawValue)
                )
            } else {
                transitionInfo.convertedRect = transitionInfo.fromRect
            }
        }
        
        if transitionInfo.convertedRect != nil {
            self.transitioningDelegate = self
            self.modalPresentationStyle = .overFullScreen
        }
    }
    
    public convenience init(image: UIImage, imageMode: UIView.ContentMode, imageHD: URL?, fromView: UIView?) {
        let imageInfo = HMImageInfo(image: image, imageMode: HMImageInfo.ImageMode(rawValue: imageMode.rawValue)!, imageHD: imageHD)
        
        if let fromView = fromView {
            self.init(imageInfo: imageInfo, transitionInfo: HMTransitionInfo(fromView: fromView))
        } else {
            self.init(imageInfo: imageInfo)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScrollView()
        setupImageView()
        setupGesture()
        setupImageHD()
        
        edgesForExtendedLayout = UIRectEdge()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.frame = imageInfo.calculate(rect: view.bounds, origin: .zero)
        
        scrollView.frame = view.bounds
        scrollView.contentSize = imageView.bounds.size
        scrollView.maximumZoomScale = imageInfo.calculateMaximumZoomScale(scrollView.bounds.size)
    }
    
    // MARK: Setups
    
    fileprivate func setupView() {
        view.backgroundColor = backgroundColor
    }
    
    fileprivate func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    fileprivate func setupImageView() {
        imageView.image = imageInfo.image
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
    }
    
    fileprivate func setupGesture() {
        let single = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        let double = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        double.numberOfTapsRequired = 2
        single.require(toFail: double)
        scrollView.addGestureRecognizer(single)
        scrollView.addGestureRecognizer(double)
        
        if transitionInfo?.canSwipe == true {
            let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
            pan.delegate = self
            scrollView.addGestureRecognizer(pan)
        }
    }
    
    fileprivate func setupImageHD() {
        guard let imageHD = imageInfo.imageHD else { return }
            
        let request = URLRequest(url: imageHD, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
        let task = session.dataTask(with: request, completionHandler: { (data, _, _) -> Void in
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.imageView.image = image
            self.view.layoutIfNeeded()
        })
        task.resume()
    }
    
    // MARK: Gesture
    
    @objc fileprivate func singleTap() {
        if navigationController == nil || (presentingViewController != nil && navigationController!.viewControllers.count <= 1) {
            dismiss(animated: true, completion: dismissCompletion)
        }
    }
    
    @objc fileprivate func doubleTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: scrollView)
        
        if scrollView.zoomScale == 1.0 {
            scrollView.zoom(to: CGRect(x: point.x-40, y: point.y-40, width: 80, height: 80), animated: true)
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    fileprivate var panViewOrigin: CGPoint?
    fileprivate var panViewAlpha: CGFloat = 1
    
    @objc fileprivate func pan(_ gesture: UIPanGestureRecognizer) {
        
        func getProgress() -> CGFloat {
            let origin = panViewOrigin!
            let changeX = abs(scrollView.center.x - origin.x)
            let changeY = abs(scrollView.center.y - origin.y)
            let progressX = changeX / view.bounds.width
            let progressY = changeY / view.bounds.height
            return max(progressX, progressY)
        }
        
        func getChanged() -> CGPoint {
            let origin = scrollView.center
            let change = gesture.translation(in: view)
            return CGPoint(x: origin.x + change.x, y: origin.y + change.y)
        }
        
        func getVelocity() -> CGFloat {
            let vel = gesture.velocity(in: scrollView)
            return sqrt(vel.x*vel.x + vel.y*vel.y)
        }
        
        switch gesture.state {

        case .began:
            
            panViewOrigin = scrollView.center
            
        case .changed:
            
            scrollView.center = getChanged()
            panViewAlpha = 1 - getProgress()
            view.backgroundColor = backgroundColor.withAlphaComponent(panViewAlpha)
            gesture.setTranslation(CGPoint.zero, in: nil)

        case .ended:
            
            if getProgress() > 0.25 || getVelocity() > 1000 {
                dismiss(animated: true, completion: dismissCompletion)
            } else {
                fallthrough
            }
            
        default:
            
            UIView.animate(withDuration: 0.3,
                animations: {
                    self.scrollView.center = self.panViewOrigin!
                    self.view.backgroundColor = self.backgroundColor
                },
                completion: { _ in
                    self.panViewOrigin = nil
                    self.panViewAlpha  = 1.0
                }
            )
            
        }
    }
    
}

extension HMImageViewerController: UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.frame = imageInfo.calculate(rect: CGRect(origin: .zero, size: scrollView.contentSize), origin: .zero)
    }
    
}

extension HMImageViewerController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HMImageViewerTransition(imageInfo: imageInfo, transitionInfo: transitionInfo!, transitionMode: .present)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HMImageViewerTransition(imageInfo: imageInfo, transitionInfo: transitionInfo!, transitionMode: .dismiss)
    }
    
}

class HMImageViewerTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let imageInfo: HMImageInfo
    let transitionInfo: HMTransitionInfo
    var transitionMode: TransitionMode
    
    enum TransitionMode {
        case present
        case dismiss
    }
    
    init(imageInfo: HMImageInfo, transitionInfo: HMTransitionInfo, transitionMode: TransitionMode) {
        self.imageInfo = imageInfo
        self.transitionInfo = transitionInfo
        self.transitionMode = transitionMode
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionInfo.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let tempBackground = UIView()
            tempBackground.backgroundColor = UIColor.black
        
        let tempMask = UIView()
            tempMask.backgroundColor = .black
            tempMask.layer.cornerRadius = transitionInfo.fromView?.layer.cornerRadius ?? 0
            tempMask.layer.masksToBounds = transitionInfo.fromView?.layer.masksToBounds ?? false
        
        let tempImage = UIImageView(image: imageInfo.image)
            tempImage.contentMode = imageInfo.contentMode
            tempImage.mask = tempMask
        
        containerView.addSubview(tempBackground)
        containerView.addSubview(tempImage)
        
        if transitionMode == .present {
            let imageViewer = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! HMImageViewerController
                imageViewer.view.layoutIfNeeded()
            
            tempBackground.alpha = 0
            tempBackground.frame = imageViewer.view.bounds
            tempImage.frame = transitionInfo.convertedRect
            tempMask.frame = tempImage.convert(transitionInfo.fromRect, from: nil)
            
            transitionInfo.fromView?.alpha = 0
            
            animationBlock(for: transitionInfo, {
                tempBackground.alpha  = 1
                tempImage.frame = imageViewer.imageView.frame
                tempMask.frame = tempImage.bounds
            }, {
                tempBackground.removeFromSuperview()
                tempImage.removeFromSuperview()
                containerView.addSubview(imageViewer.view)
                transitionContext.completeTransition(true)
            })
        } else if transitionMode == .dismiss {
            let imageViewer = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! HMImageViewerController
                imageViewer.view.removeFromSuperview()
            
            tempBackground.alpha = imageViewer.panViewAlpha
            tempBackground.frame = imageViewer.view.bounds
            
            if imageViewer.scrollView.zoomScale == 1 && imageInfo.imageMode == .aspectFit {
                tempImage.frame = imageViewer.scrollView.frame
            } else {
                tempImage.frame = CGRect(x: imageViewer.scrollView.contentOffset.x * -1, y: imageViewer.scrollView.contentOffset.y * -1, width: imageViewer.scrollView.contentSize.width, height: imageViewer.scrollView.contentSize.height)
            }
            
            tempMask.frame = tempImage.bounds
            
            self.animationBlock(for: transitionInfo, { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                tempBackground.alpha = 0
                tempImage.frame = strongSelf.transitionInfo.convertedRect
                tempMask.frame = tempImage.convert(strongSelf.transitionInfo.fromRect, from: nil)
            }, { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                tempBackground.removeFromSuperview()
                tempImage.removeFromSuperview()
                imageViewer.view.removeFromSuperview()
                strongSelf.transitionInfo.fromView?.alpha = 1
                transitionContext.completeTransition(true)
            })
        }
    }
    
    private func animationBlock(for transition: HMTransitionInfo,
                                _ animations: @escaping () -> Void,
                                _ completionBlock: (() -> Void)?) {
        
        switch transition.animation {
        case .linear:
            UIView.animate(withDuration: transitionInfo.duration, animations: {
                animations()
            }, completion: {  _ in
                completionBlock?()
            })
        case let .spring(damping, velocity):
            UIView.animate(withDuration: transitionInfo.duration, delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: velocity) {
                animations()
            } completion: {  _ in
                completionBlock?()
            }
        }
    }
}

extension HMImageViewerController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            if scrollView.zoomScale != 1.0 {
                return false
            }
            if imageInfo.imageMode == .aspectFill && (scrollView.contentOffset.x > 0 || pan.translation(in: view).x <= 0) {
                return false
            }
        }
        return true
    }
    
}
