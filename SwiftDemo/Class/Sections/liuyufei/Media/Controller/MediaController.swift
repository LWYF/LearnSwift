//
//  MediaController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/13.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class MediaController: UIViewController {

    fileprivate var menu:[String] = ["直播"]
    fileprivate let button_top_margin:CGFloat = 20
    fileprivate let button_height:CGFloat = 80
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        // Do any additional setup after loading the view.
    }
    //访问权限依次为open,pulbic,intenal,fileprivate,private
    //fileprivate 文件内私有
    fileprivate func loadInterface() {
        setupLivingButton()
    }
    //private为真正私有，离开这个类或结构体的作用域外无法访问
    private func setupLivingButton() {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.red
        button.setTitle("直播", for: .normal)
        view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(NAVIGATIONBARHEIGHT + button_top_margin)
            make.left.equalTo(MARGIN)
            make.right.equalTo(-MARGIN)
            make.height.equalTo(button_height)
        }
        
        button.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            let controller = LivingController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
