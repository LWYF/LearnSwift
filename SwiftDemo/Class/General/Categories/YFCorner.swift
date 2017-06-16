//
//  YFCorner.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/16.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

/*
 参考:http://www.jianshu.com/p/f970872fdc22
 离屏渲染：
 指GPU在当前屏幕缓冲区外新开辟一个缓冲区进行渲染操作
 UIView只设置CornerRadius不会导致离屏渲染
 设置masksToBounds会导致离屏渲染，从而影响性能，但是圆角不多(少于20)的情况下，不会影响性能
 
 一定要使用layer的话，可以使用layer.shouldRasterize = YES,
 layer.rasterizationScale = UIScreen.main.scale,
 会使视图渲染内容被缓存起来，下次绘制会直接显示缓存
 
 使用时小心使用背景色，我们没有设置masksToBounds，因此超出圆角的部分依然会被显示
 因而，不应该再使用背景颜色，可以在绘制圆角矩形时设置填充颜色来实现
 */

extension UIView {
    
    func addCorner(_ radius: CGFloat, borderWidth: CGFloat,
                   backgroundColor: UIColor,
                   borderColor: UIColor) {
        let imageView = UIImageView(image: drawRectRoundedCorner(radius, borderWidth: borderWidth, backgroundColor: backgroundColor, borderColor: borderColor))
        self.insertSubview(imageView, at: 0)
    }
    
    //利用Core Graphics自己画出了一个圆角矩形
    func drawRectRoundedCorner(_ radius: CGFloat, borderWidth: CGFloat,
                               backgroundColor: UIColor,
                               borderColor: UIColor) -> UIImage {
        /*创建一个基于位图的上下文，并将其设置为当前上下文
         size为新创建位图的上下文大小
         opaque透明开关，如果图形完全不透明，设置YES以优化位图的存储
         scale缩放因子，iPhone4为2.0，其他为1.0，可以通过UIScreen.main.scale获取，
         实际设为0后，系统会自动设置正确的比例
         */
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        let halfBorderWidth = borderWidth / 2.0
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineWidth(borderWidth)
        context?.setStrokeColor(borderColor.cgColor)
        context?.setFillColor(backgroundColor.cgColor)
        //开始坐标右边开始
        context?.move(to: CGPoint(x: width - halfBorderWidth, y: radius + halfBorderWidth))
        //右下角角度
        context?.addArc(tangent1End: CGPoint(x: width - halfBorderWidth, y: height - halfBorderWidth), tangent2End: CGPoint(x: width - radius - halfBorderWidth, y: height - halfBorderWidth), radius: radius)
        //左下角角度
        context?.addArc(tangent1End: CGPoint(x: halfBorderWidth, y: height - halfBorderWidth), tangent2End: CGPoint(x: height - radius - halfBorderWidth, y: radius), radius: radius)
        //左上角
        context?.addArc(tangent1End: CGPoint(x: halfBorderWidth, y: halfBorderWidth), tangent2End: CGPoint(x: width - halfBorderWidth, y: halfBorderWidth), radius: radius)
        //右上角
        context?.addArc(tangent1End: CGPoint(x: width - halfBorderWidth, y: halfBorderWidth), tangent2End: CGPoint(x: width - halfBorderWidth, y: radius + halfBorderWidth), radius: radius)
        
        context?.drawPath(using: .fillStroke)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

/*
 为ImageView添加圆角
 */
extension UIImage {
    func drawRoundedCorner(_ radius: CGFloat, size: CGSize) -> UIImage {
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let bezier = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(bezier.cgPath)
        context?.clip()
        self.draw(in: rect)
        context?.drawPath(using: .fillStroke)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


extension UIImageView {
    func addCorner(_ radius: CGFloat, size: CGSize) {
        self.image = self.image?.drawRoundedCorner(radius, size: size)
    }
}




