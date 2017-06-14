//
//  LivingController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/14.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

private let testLivingURL = "http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"

class LivingController: UIViewController {

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
 直播流程
 音视频采集->视频滤镜->音视频编码->推流->流媒体服务器->拉流->音视频解码->音视频播放
 */

/**
 流媒体，网络层(socket或st)负责传输，协议层(rtmp或hls)负责网络打包，封装层(flv,ts)负责编解码数据的封装，编码层(h.264和aac负责图像),音频压缩
 帧，没帧代表一幅静止的图像
 GOP,group of pictures,一个GOP就是一组连续的画面,每个画面都是一个帧，一个GOP是很多帧的集合
 直播的数据，其实就是一组图片
 GOP Cache长度越长，画面质量越好
 码率：图片进行压缩后每秒显示的数据量
 帧率:每秒显示的图片数，帧率越大，画面越流畅，画面帧率高于16时，就认为是连贯的了，当帧速到一定值，再增长，也不会感觉有明显的流畅度提升了
 视频封装格式，TS， FLV为流式封装，MP4,MOV，AVI为索引式封装
 */

/*
 1、1：采集视频、音频编码框架
 AVFoundation,用来播放和创建实时的视听媒体数据的框架
 1、2：视频、音频硬件设备
 CCD：图像传感器：用于图像采集和处理的过程，把图像转换成电信号
 拾音器：声音传感器：用于声音采集和处理的过程，把声音转换成电信号
 音频采样数据:一般是PCM格式
 视频采样数据:一般是YUV或RGB，原始音视频的体积是非常大的，需要经过压缩技术处理来提高传输效率
 */
/*
 2.1视频处理(美颜，水印)
 视频处理原理：视频最终也是通过GPU，一帧一帧渲染到屏幕上的，所以可以利用OpenGL ES，对视频帧进行各种加工，从而实现各种不同效果，现在的各种美颜和视频添加特效的APP都是利用GPUImage这个框架实现的
 视频处理框架
 GPUImage:基于OpenGL ES的一个强大的图像/视频处理框架，封装好了各种滤镜同时也可以编写自定义的滤镜
 OpenGL:是个定义了一个跨编程语言、跨平台的编程接口的规格，用于三维图像（二维亦可）.它是个专业的图形程序接口，是个功能强大，调用方便的底层图形库
 OpenGL ES:是OpenGL 三维图形API的子集，针对手机、PDA和游戏主机等嵌入式设备而设计
 */

/*
 视频编码解码
 FFmpeg:跨平台的开源视频框架
 X264:把视频原数据YUV编码压缩成H.264格式
 VideoToolbox:苹果自带的视频硬解码和硬编码API，iOS8才开放
 AudioToolbox:苹果自带的音频硬解码和硬编码API
 */

/*
 视频编码技术
 视频压缩编码标准：如MPEG,H.264,用于压缩编码视频
 从单个画面的清晰度比较,MPEG4有优势，动作连贯性上，H.264有优势，但是H.264对系统要求较高
 */

/*
 音频编码技术
 AAC,MP3
 */
/*
 添加第三方播放
 1:下载地址:https://github.com/Bilibili/ijkplayer,下载ijkplayer
 2:打开终端，cd到ijkplayer-master文件夹中
 3:执行命令行./init-ios.sh,这是在下载ffmpeg
 4:下载完成后，cd ios,进入到iOS目录
 5：在ios目录下，终端依次执行./compile-ffmpeg.sh clean 和./compile-ffmpeg.sh all
 第二步如果出错，在config.log查看错误原因，
 如果因为iphoneos cannot be located，则Xcode路径判断错误，具体原因是因为安装了不同版本的Xcode导致
 终端输入sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/
 ,然后xcrun --sdk iphoneos --show-sdk-path，再次执行即可
 打包IJKMediaFramework.framework框架
 打开工程IJKMediaPlayer.xcodeproj
 Edit Scheme
 选择Run -> Release
 选择真机和模拟器编译，编译完成后，选择framework，show in Finder,能够看到模拟器版本和真机版本的framework
 开始合并两个framework下的IJKMediaFramework
 终端输入lipo -create "真机版本路径" "模拟器版本路径" -output "合并后路径"
 合并后的文件，把原来两个framework的IJKMediaFramework替换掉
 这样就可以导入了
 */
