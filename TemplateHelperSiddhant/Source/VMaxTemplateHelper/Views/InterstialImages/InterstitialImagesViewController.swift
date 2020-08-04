//
//  InterstitialImagesViewController.swift
//  IMASample
//
//  Created by admin_vserv on 27/07/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import UIKit

class InterstitialImagesViewController: UIViewController {
    var adModel: PostAdModel?
    var vmaxAdTrackers: VmaxTracker?
    var vmaxAdView: VMaxAdView?
    @IBOutlet var skipAdBtn: UIButton!
    @IBOutlet var ctaButton: UIButton!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var skipAdBg: UIVisualEffectView!
    @IBOutlet var skipCountDownLabel: UILabel!
    @IBOutlet var skipAdLabel: UILabel!
    
    var skipAdTime = 6
    let stopAdTime = 10
    var currentAdShown = 0
    var skiptimer = Timer()
    var endAdTimer = Timer()
    var isAdPaused = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView() {
        print(adModel)
        let imageUrl = adModel?.assets?.imagemain ?? ""
        
        if imageUrl.isGif() {
            let gifURL = imageUrl
            let imageURL = UIImage.gifImageWithURL(gifURL)
            let imageView3 = UIImageView(image: imageURL)
            imageView3.frame = mainImage.frame
            mainImage.addSubview(imageView3)
        }
        else {
            mainImage.downloaded(from: adModel?.assets?.imagemain ?? "")
            mainImage.contentMode = .scaleAspectFill
        }
        
        if adModel?.link?.url == "" && adModel?.link?.url == "" {
            ctaButton.isHidden = true
        }
        else {
            ctaButton.isHidden = false
        }
        
        
        if adModel?.assets?.showskip == "1" {
            skiptimer.invalidate()
            skipAdBtn.isHidden = false
            skipAdBg.isHidden = false
            skipCountDownLabel.text = "\(skipAdTime)"
            skipAdBtn.isUserInteractionEnabled = false
            self.skiptimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showSkipAdButton), userInfo: nil, repeats: true)
            
            
        }
        else {
            skipAdBtn.isHidden = true
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
        
        self.skipAdBtn.clipsToBounds = true
        self.skipAdBtn.layer.cornerRadius = 5
        self.skipAdBg.clipsToBounds = true
        self.skipAdBg.layer.cornerRadius = 5
        
//        self.ctaButton.clipsToBounds = true
//        self.ctaButton.layer.cornerRadius = 20
        
//        self.endAdTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(endAdAction), userInfo: nil, repeats: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let ctabuttoncolorstyle = adModel?.assets?.ctabuttoncolorstyle ?? "1"
        
        if let buttonType = Ctabuttoncolorstyle(rawValue: Character(ctabuttoncolorstyle)) {
            VmaxUtility.shared.loadButtonStyleImages(type: buttonType, ctaButton: self.ctaButton)
        }
        else {
            VmaxUtility.shared.loadButtonStyleImages(type: .greenAndYellow, ctaButton: self.ctaButton)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { (notification) in
            self.isAdPaused = true
        }
        
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { (notification) in
            self.isAdPaused = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.endAdTimer.invalidate()
        self.endAdTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(endAdAction), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func ctaButtonAction(_ sender: Any) {
        if adModel?.assets?.showskip == "1" {
            self.endAdTimer.invalidate()
            
        }
        
        self.vmaxAdTrackers?.onClick()
        
    }
    
    @IBAction func skipAdAction(_ sender: Any) {
        self.endAdTimer.invalidate()
        self.vmaxAdTrackers?.logEvent("Skip")
        print("User initiated skip event logged")
        let vmaxDataListener = VmaxDataListener()
        if let adView = self.vmaxAdView {
            vmaxDataListener.onAdCloseLoaded(adView)
        }
        self.dismiss(animated: true, completion: nil)
        
        //        when ad gets auto-skipped - Hit "Auro-skip" event
        
        
    }
    
    
    @objc func showSkipAdButton() {
        self.skipAdTime = skipAdTime - 1
        if skipAdTime <= 0 {
            let vmaxDatalistener = VmaxDataListener()
            
            skipAdBtn.isUserInteractionEnabled = true
            self.skipCountDownLabel.text = ""
            self.skipAdLabel.text = "Skip Ad"
            
            self.skiptimer.invalidate()
            guard let adView = self.vmaxAdView else {return}
            vmaxDatalistener.onAdSkipables(adView)
        }
        else {
            self.skipCountDownLabel.text = "\(self.skipAdTime)"
        }
    }
    
    @objc func endAdAction() {
        if !isAdPaused {
            self.currentAdShown = self.currentAdShown + 1
        }
        
        if self.currentAdShown >= 11 {
            self.endAdTimer.invalidate()
            print("auto skip event logged")
            self.vmaxAdTrackers?.logEvent("Auto-Skip")
            let vmaxDataListener = VmaxDataListener()
            if let adView = self.vmaxAdView {
                vmaxDataListener.onAdCloseLoaded(adView)
            }
            self.dismiss(animated: true, completion: nil)
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
