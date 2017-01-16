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
import AVKit

class ViewController: UIViewController ,AVCaptureFileOutputRecordingDelegate {
    //视频捕获 会话 它是input 和 output 的桥梁 它协调着 input 和 output 的数椐 传输
    let captureSession = AVCaptureSession()
    //视频输入设备 
    let videoDevice  = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    //音频输入 设备 
    let audioDevice  = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
    //将捕获的视频输入到文件中
    let fileOutput = AVCaptureMovieFileOutput()
    //录制、保存按钮
    var recordButton, saveButton : UIButton!
//    //开始 停顿 
//    var startButton, stopButton : UIButton!
    var videoAssets = [AVAsset]()
    //保存所有录像 片段的Url数组
    var assetURLs = [String]()
    //单独 录像片段 的index 索引
    var appendix: Int32 = 1
    //最大允许的录制时间
    let totalSeconds: Float64 = 30.00
    //每秒帧数
    var framesPerSecond:Int32 = 30
    //剩余时间
     var remainingTime : TimeInterval = 30.0
    //表示是否停止录像
    var stopRecording: Bool = false
    //剩余时间计时器
    var timer: Timer?
    //进度条计时器
    var progressBarTimer: Timer?
    //进度条计时器时间间隔
    var incInterval: TimeInterval = 0.05
    //进度条
    var progressBar: UIView = UIView()
    //当前进度条终点位置
    var oldX: CGFloat = 0
    
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
        videoLayer?.frame = VCCGRect(x: 0, y: SHEIGHT*0.1, width: SWIDTH, height: SWIDTH)
        videoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(videoLayer!)
        //创建按钮 
        self.setupButton()
        //启动session会话
        self.captureSession.startRunning()
        
        //添加进度条
        progressBar.frame = VCCGRect(x: 0, y: 0, width: SWIDTH, height: SHEIGHT*0.1)
        progressBar.backgroundColor = VCRGBColor(r: 4, g: 3, b: 3, a: 0.5)
        view.addSubview(progressBar)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setupButton() {
        //创建开始按钮
        self.recordButton = UIButton(frame: VCCGRect(x: 0, y: 0, width: 120, height: 50))
        self.recordButton.backgroundColor = UIColor.red
        self.recordButton.layer.masksToBounds = true
        self.recordButton.setTitle("按住录像", for: .normal)
        self.recordButton.layer.cornerRadius = 20.0
        self.recordButton.layer.position = CGPoint(x: self.view.bounds.width/2 - 70,
                                                  y:self.view.bounds.height-50)
        
        self.recordButton.addTarget(self, action: #selector(onTouchDownRecordButton(sender:)),
                                    for: .touchDown)
        self.recordButton.addTarget(self, action: #selector(onTouchUpRecordButton(sender:)),
                                    for: .touchUpInside)
        
        //创建停止按钮
        self.saveButton = UIButton(frame: CGRect(x:0,y:0,width:70,height:50))
        self.saveButton.backgroundColor = UIColor.gray
        self.saveButton.layer.masksToBounds = true
        self.saveButton.setTitle("停止", for: .normal)
        self.saveButton.layer.cornerRadius = 20.0
        
        self.saveButton.layer.position = CGPoint(x: self.view.bounds.width/2 + 70,
                                                 y:self.view.bounds.height-50)
        self.saveButton.addTarget(self, action: #selector(onClickStopButton(sender:)),
                                  for: .touchUpInside)
        
        //添加按钮到视图上
        self.view.addSubview(self.recordButton);
        self.view.addSubview(self.saveButton);
    }
    
    
    //按下录制按钮，开始录制片段
    func  onTouchDownRecordButton(sender: UIButton){
        if(!stopRecording) {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                            .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            let outputFilePath = "\(documentsDirectory)/output-\(appendix).mov"
            appendix += 1
            let outputURL = NSURL(fileURLWithPath: outputFilePath)
            let fileManager = FileManager.default
            if(fileManager.fileExists(atPath: outputFilePath)) {
                
                do {
                    try fileManager.removeItem(atPath: outputFilePath)
                } catch _ {
                }
            }
            print("开始录制：\(outputFilePath) ")
            fileOutput.startRecording(toOutputFileURL: outputURL as URL!, recordingDelegate: self)
        }
    }
    
    //松开录制按钮，停止录制片段
    func  onTouchUpRecordButton(sender: UIButton){
        if(!stopRecording) {
            timer?.invalidate()
            progressBarTimer?.invalidate()
            //暂停录制
            fileOutput.stopRecording()
        }
    }
    
    //录像开始的代理方法
        func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!){
            //开启定时器
            startProgressBarTimer()
            startTimer()
        }
    
    //录像结束的代理方法
    func captureOutput(captureOutput: AVCaptureFileOutput!,
                       didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!,
                       fromConnections connections: [AnyObject]!, error: NSError!) {
        
    }
    
    //录像结束的代理方法
        func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!){
            
            let asset : AVURLAsset = AVURLAsset(url: outputFileURL as URL, options: nil)
            var duration : TimeInterval = 0.0
            duration = CMTimeGetSeconds(asset.duration)
            print("生成视频片段：\(asset)")
            videoAssets.append(asset)
            assetURLs.append(outputFileURL.path)
            remainingTime = remainingTime - duration
            
            //到达允许最大录制时间，自动合并视频
            if remainingTime <= 0 {
                mergeVideos()
            }
    }

    //剩余时间计时器
    func startTimer() {
        timer = Timer(timeInterval: remainingTime, target: self,
                        selector: #selector(ViewController.timeout), userInfo: nil,
                        repeats:true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    //录制时间达到最大时间
    func timeout() {
        stopRecording = true
        print("时间到。")
        fileOutput.stopRecording()
        timer?.invalidate()
        progressBarTimer?.invalidate()
    }
    
    //进度条计时器
    func startProgressBarTimer() {
        progressBarTimer = Timer(timeInterval: incInterval, target: self,
                                   selector: #selector(ViewController.progress),
                                   userInfo: nil, repeats: true)
        RunLoop.current.add(progressBarTimer!,
                                            forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    //修改进度条进度
    func progress() {
        let progressProportion: CGFloat = CGFloat(incInterval / totalSeconds)
        let progressInc: UIView = UIView()
        progressInc.backgroundColor = UIColor(red: 55/255, green: 186/255, blue: 89/255,
                                              alpha: 1)
        let newWidth = progressBar.frame.width * progressProportion
        progressInc.frame = CGRect(x: oldX , y: 0, width: newWidth,
                                   height: progressBar.frame.height)
        oldX = oldX + newWidth
        progressBar.addSubview(progressInc)
    }
    
    //保存按钮点击
    func onClickStopButton(sender: UIButton){
        mergeVideos()
    }
    
    //合并视频片段
    func mergeVideos() {
        let duration = totalSeconds
        
        let composition = AVMutableComposition()
        //合并视频、音频轨道
        let firstTrack = composition.addMutableTrack(
            withMediaType: AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
        let audioTrack = composition.addMutableTrack(
            withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
        
        var insertTime: CMTime = kCMTimeZero
        for asset in videoAssets {
            print("合并视频片段：\(asset)")
            do {
                try firstTrack.insertTimeRange(
                    CMTimeRangeMake(kCMTimeZero, asset.duration),
                    of: asset.tracks(withMediaType: AVMediaTypeVideo)[0] ,
                    at: insertTime)
            } catch _ {
            }
            do {
                try audioTrack.insertTimeRange(
                    CMTimeRangeMake(kCMTimeZero, asset.duration),
                    of: asset.tracks(withMediaType: AVMediaTypeAudio)[0] ,
                    at: insertTime)
            } catch _ {
            }
            
            insertTime = CMTimeAdd(insertTime, asset.duration)
        }
        //旋转视频图像，防止90度颠倒
        firstTrack.preferredTransform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        
        //获取合并后的视频路径
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                .userDomainMask,true)[0]
        let destinationPath = documentsPath + "/mergeVideo-\(arc4random()%1000).mov"
        print("合并后的视频：\(destinationPath)")
        let videoPath: NSURL = NSURL(fileURLWithPath: destinationPath as String)
        let exporter = AVAssetExportSession(asset: composition,
                                            presetName:AVAssetExportPresetHighestQuality)!
        exporter.outputURL = videoPath as URL
        exporter.outputFileType = AVFileTypeQuickTimeMovie
        exporter.shouldOptimizeForNetworkUse = true
        exporter.timeRange = CMTimeRangeMake(
            kCMTimeZero,CMTimeMakeWithSeconds(Float64(duration), framesPerSecond))
        exporter.exportAsynchronously(completionHandler: {
            //将合并后的视频保存到相册
            self.exportDidFinish(session: exporter)
        })
    }
    
    //将合并后的视频保存到相册
    func exportDidFinish(session: AVAssetExportSession) {
        print("视频合并成功！")
        let outputURL: NSURL = session.outputURL! as NSURL
        //将录制好的录像保存到照片库中
         PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputURL as URL)
            }, completionHandler: { (isSuccess, error) in
               DispatchQueue.main.async(execute: {
                    //重置参数
                    self.reset()

                    //弹出提示框
                    let alertController = UIAlertController(title: "视频保存成功",
                                                            message: "是否需要回看录像？", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                        action in
                        //录像回看
                        self.reviewRecord(outputURL: outputURL)
                    })
                
                
                    let cancelAction = UIAlertAction(title: "取消", style: .cancel,
                                                     handler: nil)
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true,
                                               completion: nil)
                })
        })
    }
    
    //视频保存成功，重置各个参数，准备新视频录制
    func reset() {
        //删除视频片段
        for assetURL in assetURLs {
            if(FileManager.default.fileExists(atPath: assetURL)) {
                do {
                    try FileManager.default.removeItem(atPath: assetURL)
                } catch _ {
                }
                print("删除视频片段: \(assetURL)")
            }
        }
        
        //进度条还原
        let subviews = progressBar.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
        
        //各个参数还原
        videoAssets.removeAll(keepingCapacity: false)
        assetURLs.removeAll(keepingCapacity: false)
        appendix = 1
        oldX = 0
        stopRecording = false
        remainingTime = totalSeconds
    }
    
    //录像回看
    func reviewRecord(outputURL: NSURL) {
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: outputURL as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

