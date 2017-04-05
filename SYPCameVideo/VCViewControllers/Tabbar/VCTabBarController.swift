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
        UITabBar.appearance().backgroundColor = VCRGBColor(r: 18, g: 19, b: 20, a: 1)
        UITabBar.appearance().backgroundImage=UIImage()
        
        //addChildViewControllers()
        
        // Do any additional setup after loading the view.
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
