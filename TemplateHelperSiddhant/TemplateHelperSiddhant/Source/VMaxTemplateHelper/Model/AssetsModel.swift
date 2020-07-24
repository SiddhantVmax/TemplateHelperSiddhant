//
//  AssetsModel.swift
//  IMASample
//
//  Created by admin_vserv on 05/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

struct AssetsModel: Codable {
    var bgcolor: String?
    var ctabuttoncolor: String?
    var ctatext: String?
    var ctatextcolor: String?
    var desc: String?
    var desc2: String?
    var imageicon: String?
    var postid: String?
    var sponsored: String?
    var title: String?
    var fsbuttoncolor: String?
    var fstext: String?
    var fstextcolor: String?
    var showskip: String?
    var skipafter: String?
    var imageclick: String?
    var imagemain: String?
    var adoffset: String?
    var ctabuttoncolorstyle: String?
        
    //    1. Gradient - Green & Yellow
    //    2. Gradient - Orange & Yellow
    //    3. Gradient - Purple & Orange
    //    4. Gradient - Purple & Blue
    //    5. Gradient - Green & Blue
    //    6. Gradient - Red & Purple (Original)CTA button
        
//    let CTA_BUTTON_STYLE_GRADIENT_GREEN_YELLOW = 1
}



enum Ctabuttoncolorstyle: Character {
    case greenAndYellow = "1"
    case orangeAndYellow = "2"
    case purpleAndOrange = "3"
    case purpleAndBlue = "4"
    case greenAndBlue = "5"
    case redAndPurple = "6"
}
