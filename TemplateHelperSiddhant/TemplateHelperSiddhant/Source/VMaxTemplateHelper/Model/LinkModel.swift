//
//  LinkModel.swift
//  IMASample
//
//  Created by admin_vserv on 05/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

struct LinkModel: Codable {
    var fallback: String?
    var url: String?
    var clicktrackers: [String]?
}


