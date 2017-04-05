//
//  VCMyScanViewController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/3/6.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit
import AVFoundation

class VCMyScanViewController: VCBaseViewController {

    
    
    //容器
    var customContainerView = UIView()
    /// 冲击波视图
    
    var scanLineView =  UIImageView()
    
    ///框
    
    var borderIV = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "扫一扫"
        
        cameraView()
        // Do any additional setup after loading the view.
    }
   
    func cameraView(){
        // session
        let mySession : AVCaptureSession = AVCaptureSession()
        var myDevice : AVCaptureDevice? //= AVCaptureDevice()
        let myImageOutput : AVCaptureStillImageOutput = AVCaptureStillImageOutput()
        let devices = AVCaptureDevice.devices()
        
        let audioCaptureDevice = AVCaptureDevice.devices(withMediaType: AVMediaTypeAudio)
        let audioInput = (try! AVCaptureDeviceInput(device: audioCaptureDevice?[0] as! AVCaptureDevice))  as AVCaptureInput
        
        for device in devices! {
            if((device as AnyObject).position == AVCaptureDevicePosition.back){
                myDevice = device as? AVCaptureDevice
            }
        }
        
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        print(status ==  AVAuthorizationStatus.authorized)
        print(status ==  AVAuthorizationStatus.denied)
        print(status ==  AVAuthorizationStatus.restricted)
        print(status.rawValue)
        
        if status !=  AVAuthorizationStatus.authorized {
            
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted :Bool) -> Void in
                if granted == false {
                    // Camera not Authorized
                    DispatchQueue.main.sync {
                        print("Camera not Authorized")
                        
                        return
                    }
                }
            });
        }
    }
    
    func checkCamera() {
        
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authStatus {
        case AVAuthorizationStatus.authorized:
            print("AVAuthorizationStatus.Authorized")
        case AVAuthorizationStatus.denied:
            print("AVAuthorizationStatus.Denied")
        case AVAuthorizationStatus.notDetermined:
            print("AVAuthorizationStatus.NotDetermined")
        case AVAuthorizationStatus.restricted:
            print("AVAuthorizationStatus.Restricted")
        default:
            print("AVAuthorizationStatus.Default")
        }
        
    
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
