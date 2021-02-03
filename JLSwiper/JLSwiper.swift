//
//  JLSwiper.swift
//  awesome_project
//
//  Created by 超级酱油 on 2021/2/3.
//

import Kingfisher

let JLWidth = UIScreen.main.bounds.width

class JLSwiper: UIScrollView, UIScrollViewDelegate {
    
    var swiperDataSource: JLSwiperDataSource?
    var swiperDelegate: JLSwiperDelegate?
    private var imageViews: [UIImageView] = []
    private var currentIdx: Int?
    private var lastIdx : Int?
    
    func initSwiper(with dataSource: JLSwiperDataSource, delegate: JLSwiperDelegate) {
        
        let swiper = UIScrollView()
        swiper.showsHorizontalScrollIndicator = false
        swiper.isPagingEnabled = true
        swiper.delegate = self
        swiper.clipsToBounds = false
        
        var source = dataSource.swiperImages()
        source.insert(source.last!, at: 0)
        source.append(source[1])
        
        let itemWith = JLWidth - dataSource.margin!*2
        let imgsCount = CGFloat(dataSource.swiperImages().count + 2)
        swiper.contentSize = CGSize(width: itemWith * imgsCount, height: 0)
        for (index, item) in source.enumerated() {
            let imgView = UIImageView.init(frame: CGRect(x: itemWith * CGFloat(index), y: 0, width: itemWith, height: self.frame.height))
            imgView.kf.setImage(with: URL.init(string: item))
            imageViews.append(imgView)
            
            imgView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            imgView.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            if index == 1 {
                imgView.transform = CGAffineTransform.identity
                currentIdx = 1
            }
        }
        

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = Int( scrollView.contentOffset.x / (ScreenWidth-60) )
        if index == currentIdx {return}
        //下标
        lastIdx = currentIdx
        currentIdx = index
        //循环
        let imagesCount = swiperDataSource?.swiperImages().count
        if currentIdx == 0 {
            scrollView.setContentOffset(CGPoint(x: (ScreenWidth-60)*CGFloat((swiperDataSource?.swiperImages().count)!-2), y: 0), animated: false)
            self.imageViews[currentIdx!].transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            currentIdx = imagesCount!-2
            lastIdx = imagesCount!-1
        } else if currentIdx == imagesCount!-1 {
            scrollView.setContentOffset(CGPoint(x: (ScreenWidth-60), y: 0), animated: false)
            self.imageViews[currentIdx!].transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            currentIdx = 1
            lastIdx = 0
        }
        //
        UIView.animate(withDuration: 0.5, delay: 0.1) { [self] in
            self.imageViews[currentIdx!].transform = CGAffineTransform.init(scaleX: 1, y: 1);
            self.imageViews[lastIdx!].transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9);
        }
    }
}

protocol JLSwiperDataSource {
    
    ///swiper左右的间距
    var margin: CGFloat? { get set }
    ///swiper的图片
    func swiperImages() -> [String]
}

protocol JLSwiperDelegate {
    
    ///点击图片
    func didClickImage(at index: Int) -> Void
}


