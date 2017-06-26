//
//  CaputreController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/17.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import AVFoundation

class CaputreController: UIViewController {

    var captuerSession: AVCaptureSession!
    var connect:AVCaptureConnection!
    var currentVideo: AVCaptureDeviceInput!
    var previedLayer: AVCaptureVideoPreviewLayer!
    var focusCursorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

//    //MARK: 捕捉音视频
//    func captureVideo() {
//        //创建捕捉会话
//        captuerSession = AVCaptureSession.init()
//        //获取摄像头设备，默认是后置摄像头
//        let videoDevice = loadVideoDevice(.front)
//        //获取声音设备
//        let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
//        //创建对应视频设备输入对象
//        let videoInput = try? AVCaptureDeviceInput.init(device: videoDevice)
//        //创建音频设备输入对象
//        let audioInput = try? AVCaptureDeviceInput.init(device: audioDevice)
//        //添加到会话中,要判断能否添加输入,会话不能添加空的
//        if captuerSession.canAddInput(videoInput) == true {
//            captuerSession.addInput(videoInput)
//        }
//        
//        if captuerSession.canAddInput(audioInput) == true {
//            captuerSession.addInput(audioInput)
//        }
//        //获取视频数据输出设备
//        let videoOutput = AVCaptureVideoDataOutput.init()
//        //设置代理,捕获视频样品数据，而且不能为空
//        //队列必须是串行队列，才能获取到数据
//        let videoQueue = DispatchQueue(label: "Video Capture Queue")
//        videoOutput.setSampleBufferDelegate(self as! AVCaptureVideoDataOutputSampleBufferDelegate, queue: videoQueue)
//        if captuerSession.canAddOutput(videoOutput) == true {
//            captuerSession.addOutput(videoOutput)
//        }
//        //获取音频数据输出设备
//        let audioOutput = AVCaptureAudioDataOutput.init()
//        let audioQueue = DispatchQueue(label: "Audio Capture Queue")
//        audioOutput.setSampleBufferDelegate(self as! AVCaptureAudioDataOutputSampleBufferDelegate, queue: audioQueue)
//        if captuerSession?.canAddOutput(audioOutput) == true {
//            captuerSession?.addOutput(audioOutput)
//        }
//        
//        //获取视频输入与输出连接,用于分辨音视频数据
//        connect = videoOutput.connection(withMediaType: AVMediaTypeVideo)
//        //添加视频预览层
//        let previewLayer = AVCaptureVideoPreviewLayer.init(session: captuerSession)
//        previewLayer?.frame = UIScreen.main.bounds
//        view.layer.insertSublayer(previewLayer!, at: 0)
//        //启动会话
//        captuerSession.startRunning()
//        
//    }
//    
//    //MARK: 返回前置摄像头还是后置摄像头
//    private func loadVideoDevice(_ pos: AVCaptureDevicePosition) -> AVCaptureDevice {
//        let deviceSession = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInDualCamera], mediaType: AVMediaTypeVideo, position: pos)
//        let devices = deviceSession?.devices
//        for device: AVCaptureDevice in devices! {
//            if device.position == pos {
//                return device
//            }
//        }
//        return AVCaptureDevice()
//    }
//    
//    //MARK: 获取输入设备数据，有可能音频也有可能是视频
//    private func capture(captureOut: AVCaptureOutput, sampleBuffer: CMSampleBuffer, connection: AVCaptureConnection) {
//        if connect == connection {
//            YFLog("采集到视频数据")
//        }
//        else {
//            YFLog("采集到音频数据")
//        }
//    }
//    //切换摄像头
//    private func toggleCapture() {
//        //获取当前设备方向
//        let curPos = currentVideo.device.position
//        //获取改变的摄像头设备
//        let toggleDevice = loadVideoDevice(curPos)
//        //获取改变的摄像头的输入设备
//        let toggleInput = try? AVCaptureDeviceInput.init(device: toggleDevice)
//        //移除之前摄像头输入设备
//        captuerSession.removeInput(currentVideo)
//        //添加新的摄像头输入设备
//        captuerSession.addInput(toggleInput)
//        //记录当前摄像头输入设备
//        currentVideo = toggleInput
//    }
//    //聚焦光标,点击屏幕出现聚焦视图
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //获取点击位置
//        let touch:UITouch = (touches as NSSet).anyObject() as! UITouch
//        let point = touch.location(in: view)
//        //把当前位置转换为摄像头点上的位置
//        let cameraPoint = previedLayer.pointForCaptureDevicePoint(ofInterest: point)
//        //设置聚焦点光标位置
//        YFLog("cameraPoint = \(cameraPoint)")
//        
//    }
//    
//    //设置聚焦光标位置
//    func focusCursorWithPoint(point: CGPoint) {
//        focusCursorImageView.center = point
//        focusCursorImageView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
//        focusCursorImageView.alpha = 1.0
//        UIView.animate(withDuration: 1.0, animations: {
//            //UIView的动画中使用self并不会导致循环引用
//            self.focusCursorImageView.transform = CGAffineTransform.identity
//        }) { (finished) in
//            self.focusCursorImageView.alpha = 0
//        }
//    }
//    //设置聚焦
//    func focusWithMode(focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, point: CGPoint) {
//        let device = currentVideo.device
//        //锁定配置
//        try? device?.lockForConfiguration()
//        //设置聚焦
//        
//        if (device?.isFocusModeSupported(.autoFocus) == true) {
//            device?.focusMode = .autoFocus
//        }
//        if device?.isFocusPointOfInterestSupported == true {
//            device?.focusPointOfInterest = point
//        }
//        
//        //设置曝光
//        if device?.isExposureModeSupported(.autoExpose) == true {
//            device?.exposureMode = .autoExpose
//        }
//        if device?.isFocusPointOfInterestSupported == true {
//            device?.exposurePointOfInterest = point
//        }
//        //解锁配置
//        device?.unlockForConfiguration()
//    }
//    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/*
 swift提供了try,try?,try!,catch,throw,throws关键字提供异常逻辑
 声明一个可能抛出异常的函数
 func canThrowErrors() throws -> String
 
 */




































