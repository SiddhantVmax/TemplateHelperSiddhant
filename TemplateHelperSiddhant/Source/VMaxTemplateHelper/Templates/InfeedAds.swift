//
//  InfeedAds.swift
//  IMASample
//
//  Created by admin_vserv on 30/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

@objc public class InfeedAds: VMaxAd {
    
    var adData: NSDictionary?
    var vmaxAdTrackers: VmaxTracker?
    var postAdModel: PostAdModel?
    var arrayListNativeImageDownloads: NSArray?
    var adView: VMaxAdView!
    var infeedvideoAdMid = InFeedVideoAdMid()
    var infeedvideoAdEnd = InFeedViewAdEnd()
    var vmaxDataListeners = VmaxDataListener()
    var isRendered = false
    var adID = ""
    @objc public override func parse(_ payload: Data, adData: [AnyHashable : Any], vmaxDataListener: VmaxDataListener, vmaxAdView: VMaxAdView, templateName: String) {
        print(payload)
        self.adView = vmaxAdView
        storeData(templateName: templateName, payload: payload, vmaxDataListener: vmaxDataListener, vmaxAdView: vmaxAdView, adData: adData as NSDictionary)
    }
    
    @objc public override func getAdId(_ adId: String) {
        print(adId)
        self.adID = adId
    }
    
    func storeData(templateName: String,payload: Data,vmaxDataListener: VmaxDataListener?,vmaxAdView: VMaxAdView,adData: NSDictionary) {
        if templateName != "" {
            
            let headerString = adData.value(forKey: "X-VSERV-BODY") as? String ?? ""
            
            self.vmaxAdTrackers = VmaxTracker(name: headerString, showLogEvent: false)
            self.vmaxAdTrackers?.setAdid(self.adID)
            postAdModel = PostAdModel()
            postAdModel?.assets = AssetsModel()
            postAdModel?.link = LinkModel()
            
            do {
                let postAd = try JSONDecoder().decode(PostAdModel.self, from: payload)
                self.postAdModel = postAd
                let postAdJson = try postAd.asDictionary()
                vmaxAdTrackers?.parseAdData(postAdJson)
                //
                let vmaxDataListeners = VmaxDataListener()
                var adViewObj = vmaxAdView.getVmaxAd
                adViewObj = VMaxAd()
                adViewObj!.iconUrl = postAd.assets?.imageicon ?? ""
                adViewObj!.postId = postAd.assets?.postid ?? ""
                adViewObj!.adOffset = postAd.assets?.adoffset ?? ""
                adViewObj!.vmaxTracker = vmaxAdTrackers!
                vmaxAdView.getVmaxAd = adViewObj
                if self.postAdModel?.eventtrackers != nil {
                    vmaxAdTrackers?.setEventTrackers()
                }
                
                vmaxDataListeners.onSuccess(templateName, vmaxAdView: vmaxAdView)
                isRendered = true
            }
            catch {
                print(error)
                let error = VMaxAdError(domain: kVMaxAdErrorDetailUnknownError, code: ErrorCode.vMaxAdErrorUnknownError.rawValue, userInfo: [kVMaxAdErrorDetail:"invalid payload"])
                self.vmaxDataListeners.onFailure(error, vmaxAdView: self.adView)
                
            }
        }
    }
    
    public override func render(_ vmaxAdTemplateListener: VmaxAdTemplateListener, adScreenType: NSNumber, viewController: UIViewController) {
        renderViewGroup(vmaxAdTemplateListener: nil, adType: Int(truncating: adScreenType))
    }
    
    
    
    func renderViewGroup(vmaxAdTemplateListener: VmaxAdTemplateListener?,adType: Int){
        
        if adType == 0 {
            viewLayout(isMidAd: true)
        }
        else {
            viewLayout(isMidAd: false)
        }
        
        let vmaxDataListeners = VmaxDataListener()
        
        vmaxDataListeners.onAdLoaded("success", vmaxAdView: self.adView)
    }
    
    func viewLayout(isMidAd: Bool) {
        DispatchQueue.main.async {
            self.infeedvideoAdMid.removeFromSuperview()
            self.infeedvideoAdEnd.removeFromSuperview()
            if isMidAd{
                let viewFrame = self.adView.viewObject.frame
                let width = viewFrame.size.width
                let height = viewFrame.size.height
                self.adView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                self.infeedvideoAdMid = self.infeedVideoAdMid()
                self.infeedvideoAdMid.alpha = 1
                self.infeedvideoAdMid.infeedAdModel = self.postAdModel!
                self.infeedvideoAdMid.delegate = self
                
                
                self.infeedvideoAdMid.translatesAutoresizingMaskIntoConstraints = false
                self.adView.addSubview(self.infeedvideoAdMid)
                
                //                postAdTemplateIconLayout.bottomAnchor.constraint(equalTo: self.adView.bottomAnchor, constant: 0).isActive = true
                self.infeedvideoAdMid.leadingAnchor.constraint(equalTo: self.adView.leadingAnchor, constant: 0).isActive = true
                self.infeedvideoAdMid.widthAnchor.constraint(equalToConstant: width).isActive = true
                self.infeedvideoAdMid.heightAnchor.constraint(equalToConstant: height).isActive = true
                //                infeedvideoAdMid.trailingAnchor.constraint(equalTo: self.adView.trailingAnchor, constant: 0).isActive = true
                
                self.adView.addSubview(self.infeedvideoAdMid)
                
                
                //
                self.infeedvideoAdMid.topAnchor.constraint(equalTo: self.adView.topAnchor, constant: 0).isActive = true
            }
            else {
                
                
                let viewFrame = self.adView.viewObject.frame
                let width = viewFrame.size.width
                let height = viewFrame.size.height
                self.adView.frame = CGRect(x: 0, y: 0, width: width, height: height)
                
                self.infeedvideoAdEnd = self.infeedVideoAdEnd()
                self.infeedvideoAdEnd.alpha = 1
                self.infeedvideoAdEnd.infeedAdModel = self.postAdModel!
                self.infeedvideoAdEnd.delegate = self
                
                self.infeedvideoAdEnd.translatesAutoresizingMaskIntoConstraints = false
                self.adView.addSubview(self.infeedvideoAdEnd)
                
                //                postAdTemplateLayout.bottomAnchor.constraint(equalTo: self.adView.bottomAnchor, constant: 0).isActive = true
                
                self.infeedvideoAdEnd.leadingAnchor.constraint(equalTo: self.adView.leadingAnchor, constant: 0).isActive = true
                
                self.infeedvideoAdEnd.widthAnchor.constraint(equalToConstant: width).isActive = true
                self.infeedvideoAdEnd.heightAnchor.constraint(equalToConstant: height).isActive = true
                self.adView.addSubview(self.infeedvideoAdEnd)
                //                postAdTemplateLayout.trailingAnchor.constraint(equalTo: self.adView.trailingAnchor, constant: 0).isActive = true
                
                self.infeedvideoAdEnd.topAnchor.constraint(equalTo: self.adView.topAnchor, constant: 0).isActive = true
            }
        }
        
    }
    
    func infeedVideoAdMid() -> InFeedVideoAdMid {
        let infoWindow = InFeedVideoAdMid.instanceFromNib() as! InFeedVideoAdMid
        return infoWindow
    }
    
    func infeedVideoAdEnd() -> InFeedViewAdEnd {
        let infoWindow = InFeedViewAdEnd.instanceFromNib() as! InFeedViewAdEnd
        return infoWindow
    }
    
    
    @objc public func getTracker() -> VmaxTracker?{
        if self.vmaxTracker != nil {
            return self.vmaxTracker
        }
        return nil
    }
    
}

extension InfeedAds: CtaButtonClicked {
    func icontapped() {
        self.vmaxDataListeners.onAdElementClicked(.asset_ImageIcon, vmaxAdView: self.adView)
    }
    
    func titletapped() {
        self.vmaxDataListeners.onAdElementClicked(.asset_Title, vmaxAdView: self.adView)
    }
    
    func replaytapped() {
        self.vmaxDataListeners.onAdElementClicked(.asset_Replay, vmaxAdView: self.adView)
    }
    
    func ctaButtonClicked() {
        self.vmaxAdTrackers?.onClick()
    }
    
    func descriptiontapped() {
        self.vmaxAdTrackers?.onClick()
    }
    
    func backViewTapped() {
        self.vmaxDataListeners.onAdElementClicked(.asset_Replay, vmaxAdView: self.adView)
    }
    
    func timeOver() {
        self.vmaxDataListeners.onAdElementClicked(.asset_Replay, vmaxAdView: self.adView)
    }
}
