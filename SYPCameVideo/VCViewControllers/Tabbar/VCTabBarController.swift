//
//  VCTabBarController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/1/16.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit

class VCTabBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        // Do any additional setup after loading the view.
    }

    private func addChildViewControllers(){
        addChildViewController(VCHomeViewController(), titile: "主页", imageName: "VCTabBar_home")
        addChildViewController(VCFoundController(), titile: "我", imageName: "VCTabBar_me_boy")
    }
    
    private func addChildViewController(_ childController: UIViewController, titile:String, imageName:String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        childController.tabBarItem.title = title
        let nav = VCNavigationController()
        nav.addChildViewController(childController)
        addChildViewController(nav)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
