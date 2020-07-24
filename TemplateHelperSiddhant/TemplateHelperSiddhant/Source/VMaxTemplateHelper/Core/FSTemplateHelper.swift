//
//  FSTemplateHelper.swift
//  IMASample
//
//  Created by admin_vserv on 05/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

struct FSTemplateHelper {
    static var shared = FSTemplateHelper()
    var vmaxTracker: VmaxTracker!
    
    var baseModel: BaseModel?
    var vmaxAdTemplateListener: VmaxAdTemplateListener?
    
    func getVmaxTracker() -> VmaxTracker {
        return vmaxTracker
    }
    
    mutating func setVmaxTracker(vmaxTracker: VmaxTracker){
        self.vmaxTracker = vmaxTracker
    }
    
    func getBaseModel() -> BaseModel {
        return baseModel!
    }
    
    mutating func setBaseModel(baseModel: BaseModel){
        self.baseModel = baseModel
    }
    
    func getVmaxAdTemplateListener() -> VmaxAdTemplateListener {
        return vmaxAdTemplateListener!
    }
    
    mutating func setVmaxAdTemplateListener(vmaxAdTemplateListener: VmaxAdTemplateListener){
        self.vmaxAdTemplateListener = vmaxAdTemplateListener
    }
    
    mutating func clearData(){
        self.vmaxTracker = nil
        baseModel = nil
        vmaxAdTemplateListener = nil
        //sInstance = null;  // need to rewrite again when bug is fixed
    }
}

