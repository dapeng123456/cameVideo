//
//  ViewController.swift
//  SYPCameVideo
//
//  Created by admin on 2016/10/18.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
class ViewController: UIViewController ,AVCaptureFileOutputRecordingDelegate {
    //视频捕获 会话 它是input 和 output 的桥梁 它协调着 input 和 output 的数椐 传输
    let captureSession = AVCaptureSession()
    //视频输入设备 
    let videoDevice  = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    //音频输入 设备 
    let audioDevice  = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
    //将捕获的视频输入到文件中
    let fileOutput = AVCaptureMovieFileOutput()
    
    //开始 停顿 
    var startButton, stopButton : UIButton!
    
    //表示正在录制中
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加视频 音频输入设备
        let videoInput = try? AVCaptureDeviceInput(device: self.videoDevice)
        self.captureSession.addInput(videoInput)
        
        let audioInput = try? AVCaptureDeviceInput(device: self.audioDevice)
        self.captureSession.addInput(audioInput);
        
        //添加视频捕获输出
        self.captureSession.addOutput(self.fileOutput)
        
        //使用AVCaptureVideoPreviewLayer可以将摄像头的拍摄的实时画面显示在ViewController上
        let videoLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        videoLayer?.frame = self.view.bounds
        videoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(videoLayer!)
        //创建按钮 
        self.setupButton()
        //启动session会话
        self.captureSession.startRunning()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupButton() {
        //创建开始按钮
        self.startButton = UIButton(frame: CGRect(x:0,y:0,width:120,height:50))
        self.startButton.backgroundColor = UIColor.red
        self.startButton.layer.masksToBounds = true
        self.startButton.setTitle("开始", for: .normal)
        self.startButton.layer.cornerRadius = 20.0
        self.startButton.layer.position = CGPoint(x: self.view.bounds.width/2 - 70,
                                                  y:self.view.bounds.height-50)
        self.startButton.addTarget(self, action: #selector(onClickStartButton(sender:)),
                                   for: .touchUpInside)
        
        //创建停止按钮
        self.stopButton = UIButton(frame: CGRect(x:0,y:0,width:120,height:50))
        self.stopButton.backgroundColor = UIColor.gray
        self.stopButton.layer.masksToBounds = true
        self.stopButton.setTitle("停止", for: .normal)
        self.stopButton.layer.cornerRadius = 20.0
        
        self.stopButton.layer.position = CGPoint(x: self.view.bounds.width/2 + 70,
                                                 y:self.view.bounds.height-50)
        self.stopButton.addTarget(self, action: #selector(onClickStopButton(sender:)),
                                  for: .touchUpInside)
        
        //添加按钮到视图上
        self.view.addSubview(self.startButton);
        self.view.addSubview(self.stopButton);
    }
    func onClickStartButton(sender: UIButton){
        if !self.isRecording {
            //设置录像保存的地址 （在Documents目录下，名为temp.mp4）
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            let filePath : String? = "\(documentsDirectory)/temp.mp4"
            let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)
            
            //启动 视频 编码输出 
            fileOutput.startRecording(toOutputFileURL: fileURL as URL!, recordingDelegate: self)
            
            //记录状态：录像中...
            self.isRecording = true
            //开始、结束按钮颜色改变
            self.changeButtonColor(target: self.startButton, color: UIColor.gray)
            self.changeButtonColor(target: self.stopButton, color: UIColor.red)
        
            
        }
    
    }
    
    //停止按钮点击，停止录像
    func onClickStopButton(sender: UIButton){
        if self.isRecording {
            //停止视频编码输出
            fileOutput.stopRecording()
            
            //记录状态：录像结束
            self.isRecording = false
            //开始、结束按钮颜色改变
            self.changeButtonColor(target: self.startButton, color: UIColor.red)
            self.changeButtonColor(target: self.stopButton, color: UIColor.gray)
        }
    }

    //修改按钮的颜色
    func changeButtonColor(target: UIButton, color: UIColor){
        target.backgroundColor = color
    }
    
//    //录像开始的代理方法
//    func captureOutput(captureOutput: AVCaptureFileOutput!,
//                       didStartRecordingToOutputFileAtURL fileURL: NSURL!,
//                       fromConnections connections: [AnyObject]!) {
//    }
//    //录像结束的代理方法
//    func captureOutput(captureOutput: AVCaptureFileOutput!,
//                       didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!,
//                       fromConnections connections: [AnyObject]!, error: NSError!) {
//        var message:String!
//        //将录制好的录像保存到照片库中
////        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
////            PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(outputFileURL as URL)
////            }, completionHandler: { (isSuccess: Bool, error: NSError?) in
////                if isSuccess {
////                    message = "保存成功!"
////                } else{
////                    message = "保存失败：\(error!.localizedDescription)"
////                }
////                
////                dispatch_async(dispatch_get_main_queue(), {
////                    //弹出提示框
////                    let alertController = UIAlertController(title: message,
////                                                            message: nil, preferredStyle: .Alert)
////                    let cancelAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
////                    alertController.addAction(cancelAction)
////                    self.presentViewController(alertController, animated: true, completion: nil)
////                })
////        })
//    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!){
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!){
        var message:String!
        PHPhotoLibrary.shared().performChanges({ 
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
        }) { (isSuccess, error) in
            if isSuccess{
                message = "保存成功"
            }else{
                message = "保存失败：\(error!.localizedDescription)"
            }
            
            DispatchQueue.main.async(execute: {
                //弹出提示框
                let alertController = UIAlertController(title: message,
                                                        message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

