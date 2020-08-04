//
//  InfeedAds.swift
//  IMASample
//
//  Created by admin_vserv on 30/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

@objc public class InterstitialImageAds: VMaxAd {
    
    var adData: NSDictionary?
    var vmaxAdTrackers: VmaxTracker?
    var postAdModel: PostAdModel?
    var arrayListNativeImageDownloads: NSArray?
    var adView: VMaxAdView!
    var vmaxDataListeners = VmaxDataListener()
    var isRendered = false
    var adID = ""
    var adModel: PostAdModel?
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
//            postAdModel = PostAdModel()
//            postAdModel?.assets = AssetsModel()
//            postAdModel?.link = LinkModel()
            
            do {
                let postAd = try JSONDecoder().decode(PostAdModel.self, from: payload)
                let postAdJson = try postAd.asDictionary()
                self.adModel = postAd
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
                if postAd.eventtrackers != nil {
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
        renderViewGroup(vmaxAdTemplateListener: nil, adType: Int(truncating: adScreenType), vc: viewController)

    }

    
    func renderViewGroup(vmaxAdTemplateListener: VmaxAdTemplateListener?,adType: Int,vc: UIViewController){
        
        viewLayout(vc: vc)
        
        let vmaxDataListeners = VmaxDataListener()
        
        vmaxDataListeners.onAdLoaded("success", vmaxAdView: self.adView)
    }
    
    func viewLayout(vc: UIViewController) {
        let nativeBundle = Bundle(for: InterstitialImagesViewController.self)
        let storyBoard = UIStoryboard.init(name: "InterstitialStoryboards", bundle: nativeBundle)
        if #available(iOS 13.0, *) {
            let interstitialImagesViewController: InterstitialImagesViewController = storyBoard.instantiateViewController(identifier: "InterstitialImagesViewController") as! InterstitialImagesViewController
            interstitialImagesViewController.modalPresentationStyle = .fullScreen
            interstitialImagesViewController.adModel = adModel
            interstitialImagesViewController.vmaxAdView = self.adView
            interstitialImagesViewController.vmaxAdTrackers = vmaxAdTrackers
            vc.present(interstitialImagesViewController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
            let interstitialImagesViewController: InterstitialImagesViewController = storyBoard.instantiateViewController(withIdentifier: "InterstitialImagesViewController") as! InterstitialImagesViewController
            interstitialImagesViewController.modalPresentationStyle = .fullScreen
            interstitialImagesViewController.adModel = adModel
            interstitialImagesViewController.vmaxAdView = self.adView
            interstitialImagesViewController.vmaxAdTrackers = vmaxAdTrackers
            vc.present(interstitialImagesViewController, animated: true, completion: nil)
        }
        
//        
        
    }
    

    
    
    
    @objc public func getTracker() -> VmaxTracker?{
        if self.vmaxTracker != nil {
            return self.vmaxTracker
        }
        return nil
    }
    
}

