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

    var captuerSession: AVCaptureSession?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: 捕捉音视频
    func captureVideo() {
        //创建捕捉会话
        captuerSession = AVCaptureSession.init()
        //获取摄像头设备，默认是后置摄像头
        
    }
    
    //MARK: 指定摄像头方向获取摄像头
//    private func setupVideoDevice(_ pos: AVCaptureDevicePosition) -> AVCaptureDevice {
//        let devices = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//        for var device: AVCaptureDevice in devices {
//            if device.position == pos {
//                return device
//            }
//        }
//        return nil
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


















