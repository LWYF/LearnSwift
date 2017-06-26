//
//  FilterImageController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/21.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import AVFoundation

class FilterImageController: UIViewController {

    var layer: CALayer!
    var capture: AVCaptureSession!
    
    var currentDevice: AVCaptureDevice?
    var currentDeviceInput: AVCaptureDeviceInput?
    
    private let button_height: CGFloat = 100
    private let animationDuration: CFTimeInterval = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if Platform.isSimulator {
            let alertView = UIAlertController.init(title: nil, message: "模拟器不支持", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "确定", style: .cancel, handler: { (alert) in
                YFLog("NO Click")
            })
            alertView.addAction(confirm)
            self.present(alertView, animated: true, completion: nil)
        }
        else {
            switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
            case .authorized:
                //已经获得授权
                break
            case .notDetermined:
                //不确定
                break
            case .denied:
                //拒绝授权
                break
            default: break
            }
        }
    }
    //加载界面
    private func loadSwitchCarmera() {
        let switchCarmeraButton = UIButton(type: .custom)
        switchCarmeraButton.backgroundColor = UIColor.yellow
        switchCarmeraButton.setTitle("切换摄像头", for: .normal)
        view.addSubview(switchCarmeraButton)
        
        switchCarmeraButton.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN)
            make.right.equalTo(-MARGIN)
            make.width.equalTo(button_height)
        }
        
        switchCarmeraButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self](sender) in
            if let deviceInput = self?.currentDeviceInput {
                //转场动画
                let animation = CATransition.init()
                animation.duration = (self?.animationDuration)!
                animation.type = kCATransitionFade
                animation.subtype = kCATruncationMiddle
                self?.capture.removeInput(deviceInput)
                
                switch (self?.currentDevice)!.position {
                case .back:
                    break
                case .front:
                    break
                case .unspecified:
                    break
                }
            }
        }
    }
    //MARK: 初始化layer
    func initCaLayer() {
        layer = CALayer()
        layer.anchorPoint = CGPoint.zero
        layer.bounds = view.bounds
        view.layer.insertSublayer(layer, at: 0)
    }
    //MARK:初始化captureSession
    func initCaptureSession() {
        //拍照、摄像控制器
        capture = AVCaptureSession()
        capture.beginConfiguration()
        //设置采集质量，high,medium,low
        capture.sessionPreset = AVCaptureSessionPresetHigh
        //获取摄像头，默认后置
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        guard let device = devices?.first as? AVCaptureDevice else {
            assert(false, "没有可用摄像头")
            return
        }
        currentDevice = device
        //添加input输入流
        let deviceInput = try! AVCaptureDeviceInput(device: device)
        currentDeviceInput = deviceInput
        
        if capture.canAddInput(deviceInput) {
            capture.addInput(deviceInput)
        }
        //添加output
        /*
         输出数据格式，
         KCVPixelFormatType_420YpCbcr8BiPlanarVideoRange:420V
         KCVPixelFormatType_420YpCbCr8BiPlanarFullRange:420f
         KCVPixelFormatType_320BGRA,iOS在内部进行YUV至BGRA格式转换
         YUV420一般用于标清视频
         YUV422一般用于高清视频
         */
        let dataOutput = AVCaptureVideoDataOutput()
        //设置像素输出格式
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable:kCVPixelFormatType_32ABGR]
        //抛弃延迟的帧
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if capture.canAddOutput(dataOutput) {
            capture.addOutput(dataOutput)
        }
        //开启摄像头采集图像输出的子线程,DispatchQueue默认创建串行队列
        let queue = DispatchQueue(label: "VideoQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        //与beginConfiguration对应
        capture.commitConfiguration()
    }
    //MARK:控制设备的摄像头方向
    /*
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
     */
    private func loadVideoDevice(_ pos: AVCaptureDevicePosition) -> AVCaptureDevice {
        var deviceSession: AVCaptureDevice?
        if #available(iOS 10.2, *) {
            //>10的情况下
            let deviceDiscovery = AVCaptureDeviceDiscoverySession.init(deviceTypes: [AVCaptureDeviceType.builtInDualCamera], mediaType: AVMediaTypeVideo, position: pos)
            let discoveryDevice = deviceDiscovery?.devices
            for chooseDevice:AVCaptureDevice in discoveryDevice! {
                if chooseDevice.position == pos {
                    return chooseDevice
                }
            }
        }
        else {
            deviceSession = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FilterImageController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
}


















