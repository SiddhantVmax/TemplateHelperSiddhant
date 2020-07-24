//
//  InterstitialVideoAdModel.swift
//  IMASample
//
//  Created by admin_vserv on 05/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

struct InterstitialVideoAdModel {
    var campaignid: String?
    var fsButtonColor: String?
    var fsLabel: String?
    var fsLabelColor: String?
    var linkFallback: String?
    var linkUrl: String?
    var skipAfter: String?
    var skippable: String?
    var video: String?
    var clickTrackers: [NSDictionary]?
    var viewability: [NSDictionary]?
}
