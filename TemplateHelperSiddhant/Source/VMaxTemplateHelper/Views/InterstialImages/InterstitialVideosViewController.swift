//
//  InterstitialVideosViewController.swift
//  IMASample
//
//  Created by admin_vserv on 28/07/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import UIKit
import AVFoundation
class InterstitialVideosViewController: UIViewController {
    @IBOutlet var playpauseIcon: UIImageView!
    var adModel: PostAdModel?
    var vastAdModel: VastAdModel?
    var vmaxAdTrackers: VmaxTracker?
    var vmaxAdView: VMaxAdView?
    @IBOutlet var skipAdBg: UIVisualEffectView!
    @IBOutlet var skipAdButton: UIButton!
    @IBOutlet var ctaButton: UIButton!
    
    var skipAdTime = 6
    let stopAdTime = 10
    var player = AVPlayer()
    var skiptimer = Timer()
    var endAdTimer = Timer()
    var isCtaClicked = false
    var totalVideotime = 0.0
    var isVideoPaused = false
    @IBOutlet var skipAdLabel: UILabel!
    @IBOutlet var skipAdCountDownlabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView(){
        
        guard let vastAds = self.vastAdModel else {return}
        guard let videoStringUrl = vastAds.videoUrl else {return}
        print(videoStringUrl)
        guard let videoURL = URL(string: videoStringUrl) else {return}
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        print("hitting start")
        assignTapGesture()
        fireQuartileEvents()
        
        
        if adModel?.link?.url == "" && adModel?.link?.url == "" {
            ctaButton.isHidden = true
        }
        else {
            ctaButton.isHidden = false
        }
        
        
        if adModel?.assets?.showskip == "1" {
            skiptimer.invalidate()
            skipAdButton.isHidden = false
            skipAdBg.isHidden = false
            skipAdCountDownlabel.text = "\(skipAdTime)"
            self.skipAdButton.isUserInteractionEnabled = false
            self.skiptimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showSkipAdButton), userInfo: nil, repeats: true)
        }
        else {
            skipAdButton.isHidden = true
            skipAdBg.isHidden = true
        }
        
        
        ctaButton.setTitle(adModel?.assets?.ctatext, for: .normal)
        ctaButton.sizeToFit()
        ctaButton.titleLabel?.minimumScaleFactor = 0.5
        ctaButton.titleLabel?.numberOfLines = 1
        ctaButton.titleLabel?.adjustsFontSizeToFitWidth = true
        let ctaButtonedge = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        ctaButton.titleEdgeInsets = ctaButtonedge
        let titlehexColor = hexStringToUIColor(hex: adModel?.assets?.ctatextcolor ?? "")
        ctaButton.setTitleColor(titlehexColor, for: .normal)
        
        self.skipAdButton.clipsToBounds = true
        self.skipAdButton.layer.cornerRadius = 5
        self.skipAdBg.clipsToBounds = true
        self.skipAdBg.layer.cornerRadius = 5
        
        self.ctaButton.clipsToBounds = true
        self.ctaButton.layer.cornerRadius = 20
        
        //
        self.view.bringSubviewToFront(self.ctaButton)
        self.view.bringSubviewToFront(self.skipAdBg)
        self.view.bringSubviewToFront(self.skipAdButton)
         self.view.bringSubviewToFront(self.playpauseIcon)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { (notification) in
            if let pauseURL = self.vastAdModel?.pause{
                self.vmaxAdTrackers?.fireVastTrackRequest(pauseURL)
                self.vmaxAdTrackers?.fireVastEventOMSDK("pause")
            }
            
            self.player.pause()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { (notification) in
            self.player.play()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let ctabuttoncolorstyle = adModel?.assets?.ctabuttoncolorstyle ?? "1"
        
        if let buttonType = Ctabuttoncolorstyle(rawValue: Character(ctabuttoncolorstyle)) {
            VmaxUtility.shared.loadButtonStyleVideo(type: buttonType, ctaButton: self.ctaButton)
        }
        else {
            VmaxUtility.shared.loadButtonStyleVideo(type: .greenAndYellow, ctaButton: self.ctaButton)
        }
    }
    
    @IBAction func skipAdButtonAction(_ sender: Any) {
        player.pause()
        self.vmaxAdTrackers?.logEvent("Skip")
        print("User initiated skip event logged")

        if let adView = self.vmaxAdView {
            let dataListener = VmaxDataListener()
            dataListener.onAdCloseLoaded(adView)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func ctaButtonAction(_ sender: Any) {
        isCtaClicked = true
        self.vmaxAdTrackers?.onClick()
    }
    
    private func assignTapGesture() {
        let tap = UITapGestureRecognizer()
        tap.numberOfTouchesRequired = 1
        tap.addTarget(self, action: #selector(viewTapped))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func viewTapped() {
        if isVideoPaused {
            if let resumeURL = self.vastAdModel?.resume{
                self.vmaxAdTrackers?.fireVastTrackRequest(resumeURL)
                self.vmaxAdTrackers?.fireVastEventOMSDK("resume")
            }
            self.playpauseIcon.image = UIImage(named: "")
            print("adVideo is playing")
            self.player.play()
            self.isVideoPaused = false
            
        }
        else {
            if let pauseURL = self.vastAdModel?.pause{
                self.vmaxAdTrackers?.fireVastTrackRequest(pauseURL)
                self.vmaxAdTrackers?.fireVastEventOMSDK("pause")
            }
            let playImage = UIImage(named: "VmaxPlay", in: Bundle(for:InterstitialVideosViewController.self), compatibleWith: nil)
            self.playpauseIcon.image = playImage
            print("adVideo is paused")
            self.player.pause()
            self.isVideoPaused = true
        }
    }
    
    @objc func showSkipAdButton() {
        self.skipAdTime = skipAdTime - 1
        if skipAdTime <= 0 {
            let vmaxDatalistener = VmaxDataListener()
            self.skipAdCountDownlabel.text = ""
            self.skipAdLabel.text = "Skip Ad"
            self.skiptimer.invalidate()
            self.skipAdButton.isUserInteractionEnabled = true
            guard let adView = self.vmaxAdView else {return}
            vmaxDatalistener.onAdSkipables(adView)
        }
        else {
            self.skipAdCountDownlabel.text = "\(self.skipAdTime)"
        }
    }
    
    @objc func endAdAction() {
        player.pause()
        self.endAdTimer.invalidate()
        print("auto skip event logged")
        self.vmaxAdTrackers?.logEvent("Auto-Skip")
        if let adView = self.vmaxAdView {
            let dataListener = VmaxDataListener()
            dataListener.onAdCloseLoaded(adView)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        if let completeUrl = self.vastAdModel?.complete{
            print(completeUrl)
            self.vmaxAdTrackers?.fireVastTrackRequest(completeUrl)
            self.vmaxAdTrackers?.fireVastEventOMSDK("complete")
        }
        if isCtaClicked {
            if skipAdButton.isHidden {
                if let adView = self.vmaxAdView {
                    let dataListener = VmaxDataListener()
                    dataListener.onAdCloseLoaded(adView)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
        else {
            self.endAdTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(endAdAction), userInfo: nil, repeats: false)
        }
    }

    
    func fireQuartileEvents() {
        if let startUrl = self.vastAdModel?.startUrl{
            print(startUrl)
            self.vmaxAdTrackers?.fireVastTrackRequest(startUrl)
            self.vmaxAdTrackers?.fireVastEventOMSDK("start")
        }
        self.totalVideotime = player.currentItem?.asset.duration.seconds ?? 0.0
        print(self.totalVideotime)
        let midQuartitle = self.totalVideotime/2
        print(midQuartitle)
        let firstQuartile = midQuartitle/2
        print(firstQuartile)
        let thirdQuartile = midQuartitle + firstQuartile
        print(thirdQuartile)
        
        
        self.player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(Float64(1.0), preferredTimescale: Int32(Double(NSEC_PER_SEC))), queue: nil) { (playerTime) in
            let playerCurrentTime = playerTime.seconds.rounded()
            
            if playerCurrentTime == firstQuartile.rounded() {
                print("hitting firstQuartile")
                if let firstQuartileUrl = self.vastAdModel?.firstQuartile{
                    print(firstQuartileUrl)
                    self.vmaxAdTrackers?.fireVastTrackRequest(firstQuartileUrl)
                    self.vmaxAdTrackers?.fireVastEventOMSDK("firstQuartile")
                }
            }
            else if playerCurrentTime == midQuartitle.rounded() {
                print("hitting midQuartitle")
                if let midQuartitleUrl = self.vastAdModel?.midpoint{
                    print(midQuartitleUrl)
                    self.vmaxAdTrackers?.fireVastTrackRequest(midQuartitleUrl)
                    self.vmaxAdTrackers?.fireVastEventOMSDK("midpoint")
                }
            }
            else if playerCurrentTime == thirdQuartile.rounded() {
                print("hitting thirdQuartile")
                if let thirdQuartileUrl = self.vastAdModel?.thirdQuartile{
                    print(thirdQuartileUrl)
                    self.vmaxAdTrackers?.fireVastTrackRequest(thirdQuartileUrl)
                    self.vmaxAdTrackers?.fireVastEventOMSDK("thirdQuartile")
                }
            }
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return .white
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
