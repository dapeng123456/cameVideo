//
//  SYPSelectPhotoCollectionViewCell.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/2/10.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit

class SYPSelectPhotoCollectionViewCell: UICollectionViewCell {
    let width = (SWIDTH-2)/2//获取屏幕宽
    var imgView : UIImageView?//cell上的图片
        var titleLabel:UILabel?//cell上title
    //    var priceLabel:UILabel?//cell上价格
    //    var readLabel:UILabel?//cell上的阅读量
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        self.backgroundColor = UIColor.red
        //初始化各种控件
        //titleLabel?
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))

        self .addSubview(imgView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
