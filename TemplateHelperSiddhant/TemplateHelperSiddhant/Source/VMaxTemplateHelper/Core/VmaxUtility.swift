//
//  VmaxUtility.swift
//  IMASample
//
//  Created by admin_vserv on 05/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation
import UIKit

struct VmaxUtility {
    static var DEFAULT_TEXT_COLOR = "#FFFFFF"
    static var DEFAULT_BG_COLOR = "#808080"
    static var DEFAULT_BUTTON_BG_COLOR = "#FF0091"
    static var DEFAULT_SKIP_TIME = 6 * 1000; //6 seconds
    static var HEX_PATTERN = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$"
    static var shared = VmaxUtility()
    
    func isValidColor(hexColor: String) -> Bool {
        return false
    }
    
    func setBackGroundColor(view: UIView,drawableBg: Int,hexColorCodeBg: String) {
        
    }
    
    
    func loadButtonStyle(type: Ctabuttoncolorstyle,ctaButton: UIButton) {
        
        let greenAndYellow = UIImage(named: "VmaxgreenAndYellow", in: Bundle(for:InfeedAdssss.self), compatibleWith: nil)
        
        let orangeAndYellow = UIImage(named: "VmaxorangeAndYellow", in: Bundle(for:InfeedAdssss.self), compatibleWith: nil)
        
        let purpleAndOrange = UIImage(named: "VmaxpurpleAndOrange", in: Bundle(for:InfeedAdssss.self), compatibleWith: nil)
        
        let purpleAndBlue = UIImage(named: "VmaxpurpleAndBlue", in: Bundle(for:InfeedAdssss.self), compatibleWith: nil)
        
        let greenAndBlue = UIImage(named: "VmaxgreenAndBlue", in: Bundle(for:InfeedAdssss.self), compatibleWith: nil)
        
        let redAndPurple = UIImage(named: "VmaxredAndPurple", in: Bundle(for:InfeedAdssss.self), compatibleWith: nil)
        
        switch type{
        case .greenAndYellow:
            ctaButton.setBackgroundImage(greenAndYellow, for: .normal)
        case .orangeAndYellow:
            ctaButton.setBackgroundImage(orangeAndYellow, for: .normal)
        case .purpleAndOrange:
            ctaButton.setBackgroundImage(purpleAndOrange, for: .normal)
        case .purpleAndBlue:
            ctaButton.setBackgroundImage(purpleAndBlue, for: .normal)
        case .greenAndBlue:
            ctaButton.setBackgroundImage(greenAndBlue, for: .normal)
        case .redAndPurple:
            ctaButton.setBackgroundImage(redAndPurple, for: .normal)
        }
    }
  }

