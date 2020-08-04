//
//  VMaxTemplateHelper.swift
//  IMASample
//
//  Created by admin_vserv on 04/07/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation
// zeeShorts v1 0.0.1
@objc public class VMaxtemplateHelper: NSObject {
    @objc(sharedInstance) public static let shared: VMaxtemplateHelper = VMaxtemplateHelper()
    
    public override init() {
        
        let vmaxFactory = VmaxAdFactory.getInstance() as? VmaxAdFactory
//        vmaxFactory?.addTemplate("In-Feed Video Ad Template", adData: "infeedAd")
//        vmaxFactory?.addTemplate("Interstitial Image Template", adData: "InterstitialImage")
//
//        print(vmaxFactory?.appTemplateList)
        let dict = ["In-Feed Video Ad Template":"infeedAd",
                    "Interstitial Image Template":"InterstitialImage",
                    "Interstitial Video Template":"InterstitialVideo"]
        
        print(dict as NSDictionary)
        vmaxFactory?.setTemplate(dict)
    }
    
    @objc public func registerTemplate() {
        let vmaxFactory = VmaxAdFactory.getInstance() as? VmaxAdFactory
        vmaxFactory?.addTemplate("In-Feed Video Ad Template", adData: "infeedAds")
    }
    
   
}
