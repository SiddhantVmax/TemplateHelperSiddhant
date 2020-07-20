//
//  PostAd.swift
//  IMASample
//
//  Created by admin_vserv on 08/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

@objc public class PostAd: NSObject {

    class var swiftSharedInstance: PostAd {
        struct Singleton {
            static let instance = PostAd()
        }
        return Singleton.instance
    }
    
    var adData: NSDictionary?
    var vmaxTracker: VmaxTracker?
    var postAdModel: PostAdModel?
    var arrayListNativeImageDownloads: NSArray?
    var adView: VMaxAdView!
    
    @objc public class func sharedInstance() -> PostAd {
        return PostAd.swiftSharedInstance
    }

    
//    public func parse(_ payload: String!, adData: [AnyHashable : Any]!, vmaxDataListener: VmaxDataListener!) {
//        print("parse")
////        storeData(payload: payload,adData: adData! as NSDictionary, vmaxDataListener: vmaxDataListener)
//    }
    
    @objc public func getPostAdData(postAddata: NSMutableDictionary){
        print(postAddata)
        
        guard let payload = postAddata.value(forKey: "payload") as? String else {
            print("error")
            return
        }
        guard let adDatas = postAddata.value(forKey: "adData") as? Data else {
            print("error")
            return
        }
        guard let vmaxAdView = postAddata.value(forKey: "vmaxAdView") as? VMaxAdView else {
           print("error")
            return
        }
        self.adView = vmaxAdView
        storeData(payload: payload, adData: adDatas, vmaxDataListener: nil, vmaxAdView: vmaxAdView)
    }

    
    public func getTracker() -> VmaxTracker? {
        print("")
        if(vmaxTracker != nil) {
            return vmaxTracker;
        }
        return nil;
    }

    public func render(_ vmaxAdTemplateListener: VmaxAdTemplateListener!) {
        print("render")
        renderViewGroup(vmaxAdTemplateListener: vmaxAdTemplateListener) // not working
    }
    
    @objc public func renderPostAd() {
        renderViewGroup(vmaxAdTemplateListener: nil)
    }
    
    

    public func onDestroy() {
        print("")
    }

    func storeData(payload: String,adData: Data,vmaxDataListener: VmaxDataListener?,vmaxAdView: VMaxAdView) {
        if payload != "" {
            vmaxTracker = VmaxTracker(name: payload)
            postAdModel = PostAdModel()
            postAdModel?.assets = AssetsModel()
            postAdModel?.link = LinkModel()

            do {
                let postAd = try JSONDecoder().decode(PostAdModel.self, from: adData)
                self.postAdModel = postAd
                let postAdJson = try postAd.asDictionary()
                vmaxTracker?.parseAdData(postAdJson)
                let vmaxDataListeners = VmaxDataListener()
                vmaxDataListeners.onSuccess(payload, vmaxAdView: vmaxAdView)
            }
            catch {
                print(error)
            }
        }
    }


    func renderViewGroup(vmaxAdTemplateListener: VmaxAdTemplateListener?){
        if self.postAdModel?.assets?.imageicon != nil {
            print("=========siddhant")
            viewLayout(isWithIcon: true)
        }
        else if self.postAdModel?.assets?.imageicon == nil && self.postAdModel?.assets?.desc == nil {
            viewLayout(isWithIcon: true)
            print("=========siddhant1")
        }
        else {
            viewLayout(isWithIcon: false)
            print("=========siddhant2")
        }
        let vmaxDataListeners = VmaxDataListener()
        vmaxDataListeners.onAdLoaded("success", vmaxAdView: self.adView)
        
    }

    func viewLayout(isWithIcon: Bool) {
        DispatchQueue.main.async {
            if isWithIcon{
                var postAdTemplateIconLayout = PostAdTemplateIconLayout()
                postAdTemplateIconLayout = self.postAdTemplateIconLayoutloadNiB()
                postAdTemplateIconLayout.alpha = 1
                postAdTemplateIconLayout.postAdModel = self.postAdModel!
                
                
                
                postAdTemplateIconLayout.translatesAutoresizingMaskIntoConstraints = false
                self.adView.addSubview(postAdTemplateIconLayout)

//                postAdTemplateIconLayout.bottomAnchor.constraint(equalTo: self.adView.bottomAnchor, constant: 0).isActive = true
                postAdTemplateIconLayout.leadingAnchor.constraint(equalTo: self.adView.leadingAnchor, constant: 0).isActive = true
                postAdTemplateIconLayout.widthAnchor.constraint(equalToConstant: 269).isActive = true
                postAdTemplateIconLayout.heightAnchor.constraint(equalToConstant: 152).isActive = true
                self.adView.addSubview(postAdTemplateIconLayout)
//                postAdTemplateIconLayout.trailingAnchor.constraint(equalTo: self.adView.trailingAnchor, constant: 0).isActive = true
//
                postAdTemplateIconLayout.topAnchor.constraint(equalTo: self.adView.topAnchor, constant: 0).isActive = true
            }
            else {
                var postAdTemplateLayout = PostAdTemplateLayout()
                postAdTemplateLayout = self.postAdTemplateLayoutloadNiB()
                postAdTemplateLayout.alpha = 1
                postAdTemplateLayout.postAdModel = self.postAdModel!
                
                
                postAdTemplateLayout.translatesAutoresizingMaskIntoConstraints = false
                self.adView.addSubview(postAdTemplateLayout)
                
//                postAdTemplateLayout.bottomAnchor.constraint(equalTo: self.adView.bottomAnchor, constant: 0).isActive = true

                postAdTemplateLayout.leadingAnchor.constraint(equalTo: self.adView.leadingAnchor, constant: 0).isActive = true
                
                postAdTemplateLayout.widthAnchor.constraint(equalToConstant: 269).isActive = true
                postAdTemplateLayout.heightAnchor.constraint(equalToConstant: 152).isActive = true
                self.adView.addSubview(postAdTemplateLayout)
//                postAdTemplateLayout.trailingAnchor.constraint(equalTo: self.adView.trailingAnchor, constant: 0).isActive = true
               
                postAdTemplateLayout.topAnchor.constraint(equalTo: self.adView.topAnchor, constant: 0).isActive = true
            }
        }
        
    }
    
    func postAdTemplateIconLayoutloadNiB() -> PostAdTemplateIconLayout {
        let infoWindow = PostAdTemplateIconLayout.instanceFromNib() as! PostAdTemplateIconLayout
        return infoWindow
    }

    func postAdTemplateLayoutloadNiB() -> PostAdTemplateLayout {
        let infoWindow = PostAdTemplateLayout.instanceFromNib() as! PostAdTemplateLayout
        return infoWindow
    }

    func getPostId() -> String? {
        if postAdModel?.assets?.postid != nil {
            return postAdModel?.assets?.postid
        }
        return nil

    }
}



extension NSLayoutConstraint {
    
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
