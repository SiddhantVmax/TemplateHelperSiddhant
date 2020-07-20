//
//  EventTrackerModel.swift
//  IMASample
//
//  Created by admin_vserv on 09/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

struct EventTrackerModel: Codable {
    var event: Int?
    var methods: Int?
    var url: String?
    var ext: ExtModel?
}

struct ExtModel: Codable {
    var vendorKey: String?
    var verification_parameters: String?
}
