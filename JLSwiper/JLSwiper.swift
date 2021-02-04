//
//  JLSwiper.swift
//  awesome_project
//
//  Created by 超级酱油 on 2021/2/3.
//

import Kingfisher

let JLWidth = UIScreen.main.bounds.width

public class JLSwiper: UIScrollView, UIScrollViewDelegate {
    
    public var swiperDataSource: JLSwiperDataSource?
    public var swiperDelegate: JLSwiperDelegate?
    private var imageViews: [UIImageView] = []
    private var images : [String] = []
    private var itemWidth : CGFloat = 0
    private var currentIdx: Int = 1
    private var lastIdx : Int = 0
    
    public func initSwiper(with frame: CGRect, dataSource: JLSwiperDataSource, delegate: JLSwiperDelegate) -> JLSwiper {
        
        self.frame = frame
        self.swiperDataSource = dataSource;
        self.swiperDelegate = delegate;
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.delegate = self
        self.clipsToBounds = false
        
        images = dataSource.swiperImages()
        images.insert(images.last!, at: 0)
        images.append(images[1])
        
        itemWidth = JLWidth - dataSource.margin!*2
        self.contentSize = CGSize(width: itemWidth * CGFloat(images.count), height: 0)
        for (index, item) in images.enumerated() {
            let imgView = UIImageView.init(frame: CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: self.frame.height))
            imgView.kf.setImage(with: URL.init(string: item))
            imageViews.append(imgView)
            self.addSubview(imgView)
            
            imgView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            imgView.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            if index == 1 {
                imgView.transform = CGAffineTransform.identity
                currentIdx = 1
            }
        }
        self.setContentOffset(CGPoint(x: itemWidth, y: 0), animated: false)

        return self
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = Int( scrollView.contentOffset.x / itemWidth )
        if index == currentIdx {return}

        lastIdx = currentIdx
        currentIdx = index
        
        if currentIdx == 0 {
            scrollView.setContentOffset(CGPoint(x: itemWidth * CGFloat(images.count-2), y: 0), animated: false)
            self.imageViews[1].transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            currentIdx = images.count-2
            lastIdx = images.count-1
        } else if currentIdx == images.count-1 {
            scrollView.setContentOffset(CGPoint(x: itemWidth, y: 0), animated: false)
            self.imageViews[images.count-2].transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            currentIdx = 1
            lastIdx = 0
        } 
        //
        UIView.animate(withDuration: 0.5, delay: 0.1) { [self] in
            self.imageViews[currentIdx].transform = CGAffineTransform.init(scaleX: 1, y: 1);
            self.imageViews[lastIdx].transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9);
        }
    }
}

public protocol JLSwiperDataSource {
    
    ///swiper左右的间距
    var margin: CGFloat? { get set }
    ///swiper的图片
    func swiperImages() -> [String]
}

public protocol JLSwiperDelegate {
    
    ///点击图片
    func didClickImage(at index: Int) -> Void
}


