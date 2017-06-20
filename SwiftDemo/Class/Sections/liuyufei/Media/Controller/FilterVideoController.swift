//
//  FilterVideoController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/20.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

class FilterVideoController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
/*
 --------利用GPUImage处理直播过程中的美颜流程
 资源所在:https://github.com/BradLarson/GPUImage2
 采集视频->获取每一帧图片->滤镜处理->GPUImageView展示
 GPUImageVideoCamera(采集视频,底层封装AVFoundation)
             |
 获取SampleBuffer(帧,每一帧就是一个画面，视频就是练习播放多个画面)
             |
 Filter处理(修改每一帧像素点的坐标和颜色变化)
             |
 ——————————————————————————————————
 |                                |
 GPUImageView                   编码处理(音视频编码)
 (底层封装OpenGL ES渲染)            |
                                推流(RTMP)
 -----------美颜的基本概念
 GPU,手机或电脑用于图像处理和渲染的硬件
 GPU工作原理：采集数据->存入朱内存(RAM)->CPU(计算处理)->存入显存(VRAM)->GPU(完成图像渲染)->帧缓冲区->显示器
 OpenGL ES:开源嵌入式系统图形处理框架,一套图形与硬件接口，用于把处理好的图片显示到屏幕上
 GPUImage:一个基于OpenGL ES 2.0图像和视频处理的开源iOS框架,提供各种各样的图像处理滤镜,并且支持照相机和摄像机的实时滤镜,内置120多种滤镜效果,并且能够自定义图像滤镜
 滤镜处理的原理:把静态图片或者视频的每一帧进行图片变换再显示出来，它的本质就是像素点的坐标和颜色变化
 GPUImage处理画面原理
 GPUImage采用链式方式来处理画面，通过addTarget:方法为链条添加每个环节的对象，处理完一个target，就会把上一个环节处理好的图像数据传递下一个target去处理,称为GPUImage处理链
 比如:墨镜原理:从外界传来光线，会经过墨镜过滤，再传给我们的眼睛，就能感受到大白天也是黑黑的
 一般的target可以分为两类
 中间环节的target:一般是各种filter,是GPUImageFilter或者是子类
 最终环节的target:GPUImageView,用于显示到屏幕上，或者GPUImageMovieWriter写成视频文件
 GPUImage处理主要分为3个环节
 source->filter->final target(处理后视频、图片)
 GPUImage的Source:都继承GPUImageOutput的子类，作为GPUImage的数据源，就好比外界的光线，作为眼睛的输出源
     GPUImageVideoCamera:用于实时拍摄视频
     GPUImageStillCamera:用于实时拍摄照片
     GPUImagePicture:用于处理已经拍摄好的图片,如png,jpg图片
     GPUImageMovie:用于处理已经拍摄好的视频,如mp4文件
 GPUImage的filter:GPUImageFilter类或子类，这个类继承自GPUImageOutput,并且遵守GPUImageInput协议，这样既能流进，又能流出
 GPUImage的final target:GPUImageView,GPUImageMovieWriter就好比我们眼睛，最终输入目标
 ------------------美颜原理
 磨皮(GPUImageBilateralFilter):本质就是让像素点模糊点，可以用高斯模糊，但是这样可能会导致边缘不清晰，用双边滤波(Bilateral Filter),有针对性的模糊像素点,能保证边缘不被模糊
 美白(GPUImageBrightnessFilter):本质就是提高亮度
 */






















