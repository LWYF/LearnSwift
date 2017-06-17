//
//  WatchLivingController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/17.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import IJKMediaFramework
import SnapKit
import Kingfisher

class WatchLivingController: UIViewController {
    var imageView: UIImageView!
    var back: UIButton!
    
    private let back_size: CGFloat = 40
    
    var player: IJKFFMoviePlayerController?
    
    var living: livesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        // Do any additional setup after loading the view.
    }

    func loadInterface() {
        imageView = UIImageView.init()
        if let strURL = living?.creater.portrait {
            imageView.kf.setImage(with: URL(string: strURL))
        }
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.top.right.left.right.equalTo(0)
        }
        
        back = UIButton.init(type: .custom)
        back.backgroundColor = UIColor.yellow
        back.setTitle("返回", for: .normal)
        view.addSubview(back)
        
        back.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN)
            make.width.height.equalTo(back_size)
        }
        
        back.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            self.dismiss(animated: true, completion: nil)
        }
        startLiving()
    }

    func startLiving() {
        //设置直播占位图片
        let url = URL.init(string: living!.stream_addr)
        player = IJKFFMoviePlayerController.init(contentURL: url, with: nil)
        //准备播放
        player?.prepareToPlay()
//        player?.view.frame = UIScreen.main.bounds
        view.insertSubview((player?.view)!, at: 1)
        
        player?.view.snp.makeConstraints({ (make) in
            make.top.right.left.bottom.equalTo(0)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //界面消失，停止播放
        player?.pause()
        player?.stop()
        player?.shutdown()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
/*
 音视频的采集
 参考：http://www.jianshu.com/p/c71bfda055fa
 AVFoundation:音视频数据采集
 AVCaptureDevice:硬件设备，包括麦克风，摄像头，通过该对象可以设置物理设备的一些属性
 AVCaptureDeviceInput:硬件输入对象，根据AVCaptureDevice创建对应得ACCaptureDeviceInput对象，用于管理硬件输入数据
 AVCatureOutput:硬件输出对象，用于接收各类输出数据，通常使用对应的子类AVCaptureAudioDataOutput（声音数据输出对象）
     AVCaptureVideoDataOutput(视频数据输出对象)
 AVCaptionConnection:当把一个输入输出添加到AVCaptureSession之后，AVCaptureSession就会在输入、输出设备之间建立连接，而且通过AVCaptureOutput可以获取这个连接属性
 AVCaptureVideoPreviewLayer：相机拍摄预览图层，能实时查看拍照或视频录制效果，创建该对象需要指定对应的AVCaptureSession对象，因为AVCaptureSession包含视频输入数据，有视频数据才能展示
 AVCaptureSession:协调输入和输出传输数据
 系统作用：可以操作硬件设备
 工作原理：让App与系统之间产生一个捕获对话，相当于App与硬件设备有联系了，我们只需要把硬件输入对象和输出对象添加到会话中，会话就会自动把硬件输入对象和输出产生连接，这样硬件输入与输出设备就能传输音视频数据
 比如说：租客（输入钱）,中介（会话），房东（输出房），租客和房东都在中介登记，中介就会让租客与房东之间产生联系，以后租客就能直接和房东联系了
 */

/*
 捕获音视频步骤
 1:创建AVCaptureSession对象
 2:获取AVCaptureDevicel录像设备(摄像头),录音设备(麦克风),注意不具备输入数据功能，只是用来调节硬件设备的配置
 3:根据音频/视频硬件设备(AVCaptureDevice)创建音频/视频硬件输入数据对象(AVCaptureDeviceInput),专门管理数据输入
 4:创建视频输出数据管理对象(AVCaptureVideoDataOutput),并且设置样品缓存代理(setSampleBufferDelegate)就可以通过它拿到采集到的视频数据
 5:创建音频输出数据管理对象(AVCaptureAudioDataOutput,并且设置样品缓存代理,通过它拿到采集到的音频数据
 6:将数据对象AVCaptureDeviceInput、数据输出对象AVCaptureOutput添加到媒体会话管理对象AVCaptureSession中，就会自动让音频输入与输出和视频输入和输出产生连接
 7:创建视频预览图层AVCaptureVideoPreviewLayer并指定媒体会话，添加图层到显示容器layer中
 8:启动AVCaptureSession,只有开启，才会开始输入到输出数据流传输
 */






