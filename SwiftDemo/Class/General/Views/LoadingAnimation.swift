//
//  LoadingAnimation.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/15.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

class LoadingAnimation: UIView {
    
    private let loadingBack_Width: CGFloat = 100
    private let loadingBack_Height: CGFloat = 100
    private let loadingBack_Radius: CGFloat = 10
    
    private let loadingPoint_Width: CGFloat = 15
    private let loadingPoint_Height: CGFloat = 15
    
    private let loadingPoint_num: CGFloat = 10
    private let loadingPoint_playTime: CGFloat = 1.0
    //默认以点的方式加载
    var animatioType: LoadingAnimationType = .point
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = nil
        //背景
        let backLayer = createBackLayer()
        
        let pointLayer = addPoint()
        
        switch animatioType {
        case .point:
            /*CAReplicatorLayer
             有个属性，instanceCount是子类的个数，然后再设置子类的个数即可
             translation的含义是使layer根据X,Y,Z轴进行平移
             */
            backLayer.instanceCount = 3
            backLayer.instanceTransform = CATransform3DMakeTranslation(backLayer.frame.size.width / 3, 0, 0)
            backLayer.addSublayer(pointLayer)
            break
        case .cirle:
            /*
             圆形排列
             */
            backLayer.instanceCount = Int(loadingPoint_num)
            let angel: CGFloat = CGFloat(2 * Double.pi) / loadingPoint_num
            //0,0,1代表平面旋转坐标系（x,y,z）
            backLayer.instanceTransform = CATransform3DMakeRotation(angel, 0, 0, 1)
            backLayer.addSublayer(pointLayer)
            break
        }
        
        let animation = createAnimation()
        pointLayer.add(animation, forKey: nil)
    }
    
    //创建背景层
    private func createBackLayer() -> CAReplicatorLayer {
        let layer = CAReplicatorLayer.init()
        layer.bounds = CGRect(x: 0, y: 0, width: loadingBack_Width, height: loadingBack_Height)
        layer.cornerRadius = loadingBack_Radius
        layer.position = self.center
        layer.backgroundColor = UIColor.lightGray.cgColor
        
        layer.instanceDelay = CFTimeInterval(loadingPoint_playTime / loadingPoint_num)
        
        self.layer.addSublayer(layer)
        
        return layer
    }
    
    //添加点
    private func addPoint() -> CALayer {
        //添加3个点
        let pointLayer = CALayer.init()
        //初始化大小，防止动画开始前不流畅
        pointLayer.transform = CATransform3DMakeScale(0, 0, 0)
        pointLayer.bounds = CGRect(x: 0, y: 0, width: loadingPoint_Width, height: loadingPoint_Height)
        pointLayer.position = CGPoint(x: loadingPoint_Width, y: loadingBack_Height / 2)
        pointLayer.backgroundColor = UIColor.red.cgColor
        pointLayer.cornerRadius = loadingPoint_Height / 2
        return pointLayer
    }
    
    //创建动画
    private func createAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation.init(keyPath: "transform.scale")
        animation.duration = CFTimeInterval(loadingPoint_playTime)
        animation.fromValue = 1
        animation.toValue = 0
        animation.repeatCount = MAXFLOAT
        
        return animation
    }
}

/*
 创建动画的步骤
 1:创建一个可复用的CAReplicatorLayer
 2:添加子layer,设置子layer所需要的样式
 3:将子layer添加到CAReplicatorLayer上,并设置layer个数和排布
 4:给layer添加动画效果，transform一般针对的缩放和旋转动画，当然也可以实现平移动画
 transform.rotation：旋转动画。
 transform.rotation.x：按x轴旋转动画。
 transform.rotation.y：按y轴旋转动画。
 transform.rotation.z：按z轴旋转动画。
 transform.scale：按比例放大缩小动画。
 transform.scale.x：在x轴按比例放大缩小动画。
 transform.scale.y：在y轴按比例放大缩小动画。
 transform.scale.z：在z轴按比例放大缩小动画。
 position：移动位置动画。
 opacity：透明度动画。
 */
