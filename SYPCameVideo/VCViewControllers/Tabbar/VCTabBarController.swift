//
//  VCTabBarController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/1/16.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit

class VCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        // Do any additional setup after loading the view.
    }

    private func addChildViewControllers(){
        addChildViewController(VCHomeViewController(), titile: "主页", imageName: "SYPHome")
        addChildViewController(VCFoundController(), titile: "我", imageName: "SYPMy")
        addChildViewController(VCMyViewController(), titile: "我", imageName: "SYPMy")
    }
    
    private func addChildViewController(_ childController: UIViewController, titile:String, imageName:String) {
        
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "Select")
        
        childController.tabBarItem.title = titile
        
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
