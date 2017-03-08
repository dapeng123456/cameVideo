//
//  VCBaseViewController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/2/7.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit

class VCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = VCBaseViewColor()
        let button = UIButton.init(type: .custom)
        button.frame = VCCGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(UIImage.init(named: "YXCommonBack"), for: .normal)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment(rawValue: 1)!
        button.addTarget(self, action: #selector(navigationDismiss), for: .touchUpInside)
        let leftItem =  UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItem
        
    }
    func navigationDismiss(){
        if self.navigationController == nil {
            self .dismiss(animated: true, completion: nil)
            return
        }
        if self.navigationController?.viewControllers.count == 1 && (self.navigationController?.viewControllers.last? .isEqual(self))! {
            self.dismiss(animated: true, completion: nil)
            return
        }
        //其实是有返回值的
        _ = navigationController?.popViewController(animated: true)
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
