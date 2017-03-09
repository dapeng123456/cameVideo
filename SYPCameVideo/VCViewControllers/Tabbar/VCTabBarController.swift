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
//        UITabBar.appearance().backgroundColor = VCRGBColor(r: 18, g: 19, b: 20, a: 1)
//        UITabBar.appearance().backgroundImage=UIImage()
        let array = NSMutableArray()
        let homeVC = VCHomeViewController()
        let nav = VCNavigationController.init(rootViewController: homeVC)
        array.add(nav)
        
        let foundVC = VCFoundController()
        let foundNav = VCNavigationController.init(rootViewController: foundVC)
        array.add(foundNav)
        
        let myVC = VCMyViewController()
        let myNav = VCNavigationController.init(rootViewController: myVC)
        array.add(myNav)
        
        self.viewControllers
        
        
        // Do any additional setup after loading the view.
    }

//    private func addChildViewControllers(){
//        addChildViewController(VCHomeViewController(), titile: "主页", imageName: "SYPHome")
//        addChildViewController(VCFoundController(), titile: "我", imageName: "SYPMy")
//        addChildViewController(VCMyViewController(), titile: "我", imageName: "SYPMy")
//    }
    
//    private func addChildViewController(_ childController: UIViewController, titile:String, imageName:String) {
//
//        var image:UIImage = UIImage(named: imageName)!
//        var selectedimage:UIImage = UIImage(named: imageName + "Select")!;
//        image = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
//        selectedimage = selectedimage.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
//        
//        childController.tabBarItem.image = image
//        childController.tabBarItem.selectedImage = selectedimage
//        childController.tabBarItem.title = titile
//        
//        let nav = VCNavigationController()
//        nav.addChildViewController(childController)
//        addChildViewController(nav)
//    }
    
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
