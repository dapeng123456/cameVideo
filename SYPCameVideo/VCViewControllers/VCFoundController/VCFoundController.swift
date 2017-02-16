//
//  VCFoundController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/1/16.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit

class VCFoundController: VCBaseViewController {

    var signInButton = UIButton ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发现"
        
        signInButton = UIButton(frame: CGRect(x:100, y:100, width:64, height:44))
        signInButton .setTitle("注册", for: .normal)
        signInButton .setTitleColor(UIColor.red, for: .normal)
        signInButton .setTitleColor(UIColor.black, for: .normal)
        signInButton .addTarget(self, action: #selector(zhuceButTag), for: .touchUpInside)
        view .addSubview(signInButton)

        
        
        // Do any additional setup after loading the view.
    }

    func zhuceButTag() {
        let viewcontroller = VCVideoPreviewsViewController()
        
        
    navigationController?.pushViewController(viewcontroller, animated: false)
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
