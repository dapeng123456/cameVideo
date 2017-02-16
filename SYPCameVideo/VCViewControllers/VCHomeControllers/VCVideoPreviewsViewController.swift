//
//  VCVideoPreviewsViewController.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit
import AVFoundation
class VCVideoPreviewsViewController: UIViewController {
 
    var playerLayer = AVPlayerLayer()
    var  urlSTring = String()
    var avplayer = AVPlayer()
    var progressSlider = UISlider()
    var missSeeking = Bool()
    var avplayertime : AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCBaseViewColor()
        title = "预览"
        //let  url  = NSURL(string: urlSTring)
        let url = ""
        
        let  playerItem = AVPlayerItem.init(url: url as! URL)
        avplayer = AVPlayer(playerItem : playerItem)
        playerLayer.player = avplayer
        //播放层
        playerLayer.frame = CGRect(x: 0, y: 64, width: SWIDTH, height: SWIDTH)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.contentsScale = UIScreen.main.scale
        playerLayer.contentsGravity = kCAGravityCenter
        view.layer.addSublayer(playerLayer)

        progressSlider = UISlider()
        progressSlider.frame = CGRect(x: -2,y: SWIDTH+64-15, width: SWIDTH+4, height: 30)
        progressSlider.isUserInteractionEnabled = true //允许 拖动
        progressSlider.isContinuous = false
        
        progressSlider.addTarget(self, action: #selector(VCVideoPreviewsViewController.pssSliderBegin(_:)), for: .touchDown)
        progressSlider.addTarget(self, action: #selector(VCVideoPreviewsViewController.pssSliderChanged(_:)), for:.valueChanged)
        progressSlider.addTarget(self, action: #selector(VCVideoPreviewsViewController.pssSliderEnd(_:)), for: .touchCancel)
        progressSlider.addTarget(self, action: #selector(VCVideoPreviewsViewController.pssSliderEnd(_:)), for: .touchUpInside)
        progressSlider.addTarget(self, action: #selector(VCVideoPreviewsViewController.pssSliderEnd(_:)), for: .touchUpOutside)
        //播放进度按钮
        progressSlider.setThumbImage(UIImage(named: "YXReplay_Handle"), for: UIControlState())
        progressSlider.setThumbImage(UIImage(named: "YXReplay_Handle"), for: .highlighted)
        progressSlider.setMinimumTrackImage(UIImage(named: "YXReplay_Progress"), for: UIControlState())
        progressSlider.setMaximumTrackImage(UIImage(named: "YXReplay_ProgressBG"), for: UIControlState())
        
        view.addSubview(progressSlider)
        self.updateProgress(0, duration: 1)
        //播放进度
        avplayertime = avplayer.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 60), queue: nil, using: { [weak self](time) in
            guard let wself = self else { return  }
            guard let currentItem = wself.avplayer.currentItem else{
                return
            }
            let currenttime = currentItem.currentTime()
            wself.updateProgress(CGFloat(CMTimeGetSeconds(currenttime)), duration: CGFloat( CMTimeGetSeconds(currentItem.duration)))
            
            }) as AnyObject?

        // Do any additional setup after loading the view.
    }

    func avplayerStop()  {
        avplayer.pause()
    }
    
    // 开始播放
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avplayer.play()
    }
    //退出暂定播放
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        avplayer.pause()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension VCVideoPreviewsViewController {
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(VCVideoPreviewsViewController.playbackFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avplayer.currentItem)
        self.avplayer.currentItem?.addObserver(self, forKeyPath: "status", options: [NSKeyValueObservingOptions.old,NSKeyValueObservingOptions.new], context: nil)
        
    }
    func playbackFinished() {
        avplayer.seek(to: CMTimeMake(0, 1))
        avplayer.play()
        
    }
    func removeNotification() {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    func cancelBtAction() {
        
//        guard let filePath = self.filePath else { return }
//        do {
//            try FileManager.default.removeItem(atPath: filePath)
//            
//        } catch let error as NSError {
//            //			SSLogInfo("添加Video设备异常\(error)")
//            log.info("添加Video设备异常\(error)")
//        }
       
        
    }
    func sendBtBtAction() {
        
    }
    func pssSliderBegin(_ sender:UISlider){
        missSeeking = true
        self.avplayer.pause()
        self.superclass?.cancelPreviousPerformRequests(withTarget: self)
        
        
        
        
        
        
    }
    func pssSliderEnd(_ sender:UISlider){
        missSeeking = false
        self.avplayer.play()
        
        
    }
    func pssSliderChanged(_ sender:UISlider){
        var  time :Double
        if  let cmtime = self.avplayer.currentItem?.duration{
            time = CMTimeGetSeconds(cmtime)
        }else{
            time = 99999999
        }
        let totime = CMTimeMakeWithSeconds(time*Double(sender.value),44100)
        self.avplayer.seek(to: totime)
        
    }
    func pssSliderTapped(_ sender:UIGestureRecognizer){
        
        
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status"{
            guard  let  changeStatus =  change?[NSKeyValueChangeKey.newKey] as? NSNumber  else {
                return
            }
            let statusInt =  Int(changeStatus) 
            switch statusInt  {
            case AVPlayerItemStatus.readyToPlay.rawValue:
                progressSlider.isUserInteractionEnabled = true
                
                
            case AVPlayerItemStatus.failed.rawValue:
                progressSlider.isUserInteractionEnabled = false
                
                break
                
            case AVPlayerItemStatus.unknown.rawValue:
                progressSlider.isUserInteractionEnabled = false
                
                break
                
            default:
                break
            }
            
            
            
        }
        
    }
    func updateProgress(_ current:CGFloat,duration:CGFloat){
        
        progressSlider.setValue(Float(current/duration), animated: false)
    }
    
    
    
}
