//
//  VCTools.swift
//  VideoCapture
//
//  Created by admin on 16/9/6.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit


let SWIDTH = UIScreen.main.bounds.size.width  //屏幕 宽
let SHEIGHT = UIScreen.main.bounds.size.height //屏幕 高

// RGBA的颜色设置
func VCRGBColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
func VCCGRect(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) ->CGRect{
    return CGRect(x:x ,y:y ,width:width ,height:height)
}

// 全体控制器背景颜色
func VCBaseViewColor() -> UIColor {
    return VCRGBColor(r: 255, g: 255, b: 255, a: 1)
}
//16进制颜色转化
func VCWithHexCodeColor ( Color_Value:NSString)->UIColor{
    var  Str :NSString = Color_Value.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
    if Color_Value.hasPrefix("#"){
        Str=(Color_Value as NSString).substring(from: 1) as NSString
    }
    let VC_StrRed = (Str as NSString ).substring(to: 2)
    let VC_StrGreen = ((Str as NSString).substring(from: 2) as NSString).substring(to: 2)
    let VC_StrBlue = ((Str as NSString).substring(from: 4) as NSString).substring(to: 2)
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: VC_StrRed).scanHexInt32(&r)
    Scanner(string: VC_StrGreen).scanHexInt32(&g)
    Scanner(string: VC_StrBlue).scanHexInt32(&b)
    return VCRGBColor(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: 1)
    
   // return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
}
