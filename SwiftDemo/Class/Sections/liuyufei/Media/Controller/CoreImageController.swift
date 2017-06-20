//
//  CoreImageController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/20.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import AVFoundation

class CoreImageController: UIViewController {

    var ciImage: CIImage!
    var faceObject: AVMetadataFaceObject?
    
    
    lazy var context: CIContext = {
        let eaglContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        let options = [kCIContextWorkingColorSpace : NSNull()]
        return CIContext(eaglContext: eaglContext!, options: options)
    }()

    
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
            filterFunc()
        }
    }

    func filterFunc() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/*
 系统自带的Core Image
 主要有3类
 CIImage保存图像的类，可以通过UIImage,图像文件或者像素数据来创建，包括未处理的像素数据
 CIFilter表示应用的滤镜，对图片属性进行细节处理的类，它对所有的像素进行操作，用一些键-值设置来决定具体操作的程度
 CIContext表示上下文,如Core Graphics以及Core Data中的上下文用于处理绘制渲染以及处理托管对象一样，Core Image的上下文也是实现对图像处理的具体对象。可以从其中取得图片的信息
 */

























