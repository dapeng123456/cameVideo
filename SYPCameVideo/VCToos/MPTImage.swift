//
//  MPTImage.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/3/7.
//  Copyright © 2017年 SYP. All rights reserved.
//

import Foundation

extension UIImage{
    
    
    func imageWithColor(color : UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        let image = UIImage()
        return image;
        
    }
    
    
}
