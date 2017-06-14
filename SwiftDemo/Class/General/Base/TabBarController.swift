//
//  TabBarController.swift
//  SwiftDemo
//
//  Created by LEMO on 2017/6/12.
//  Copyright © 2017年 lyf. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addController()
        // Do any additional setup after loading the view.
    }
    
    private func addController() {
        let rac = RACController()
        let navRac = UINavigationController.init(rootViewController: rac)
        rac.navigationItem.title = "RAC"
        navRac.tabBarItem = UITabBarItem(title: "RAC", image: nil, selectedImage: nil)
        
        let media = MediaController()
        let navMedia = UINavigationController.init(rootViewController: media)
        media.navigationItem.title = "Media"
        navMedia.tabBarItem = UITabBarItem(title: "Media", image: nil, selectedImage: nil)
        
        let js = JSController()
        let navJS = UINavigationController.init(rootViewController: js)
        js.navigationItem.title = "JS"
        navJS.tabBarItem = UITabBarItem(title: "JS", image: nil, selectedImage: nil)
        
        let AR = ARController()
        let navAR = UINavigationController.init(rootViewController: AR)
        AR.navigationItem.title = "AR"
        navAR.tabBarItem = UITabBarItem(title: "AR", image: nil, selectedImage: nil)
        
        let VR = VRController()
        let navVR = UINavigationController.init(rootViewController: VR)
        VR.navigationItem.title = "VR"
        navVR.tabBarItem = UITabBarItem(title: "VR", image: nil, selectedImage: nil)
        
        self.viewControllers = [navRac,navMedia,navJS,navAR,navVR]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
