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
        
        let greenAndYellow = UIImage(named: "VmaxgreenAndYellow", in: Bundle(for:InfeedAds.self), compatibleWith: nil)
        
        let orangeAndYellow = UIImage(named: "VmaxorangeAndYellow", in: Bundle(for:InfeedAds.self), compatibleWith: nil)
        
        let purpleAndOrange = UIImage(named: "VmaxpurpleAndOrange", in: Bundle(for:InfeedAds.self), compatibleWith: nil)
        
        let purpleAndBlue = UIImage(named: "VmaxpurpleAndBlue", in: Bundle(for:InfeedAds.self), compatibleWith: nil)
        
        let greenAndBlue = UIImage(named: "VmaxgreenAndBlue", in: Bundle(for:InfeedAds.self), compatibleWith: nil)
        
        let redAndPurple = UIImage(named: "VmaxredAndPurple", in: Bundle(for:InfeedAds.self), compatibleWith: nil)
        
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
//    func loadButtonStyle(type: Ctabuttoncolorstyle,ctaButton: UIButton) {
//        switch type{
//        case .greenAndYellow:
//            ctaButton.setBackgroundImage(UIImage.init(named: "greenAndYellow"), for: .normal)
//        case .orangeAndYellow:
//            ctaButton.setBackgroundImage(UIImage.init(named: "orangeAndYellow"), for: .normal)
//        case .purpleAndOrange:
//            ctaButton.setBackgroundImage(UIImage.init(named: "purpleAndOrange"), for: .normal)
//        case .purpleAndBlue:
//            ctaButton.setBackgroundImage(UIImage.init(named: "purpleAndBlue"), for: .normal)
//        case .greenAndBlue:
//            ctaButton.setBackgroundImage(UIImage.init(named: "greenAndBlue"), for: .normal)
//        case .redAndPurple:
//            ctaButton.setBackgroundImage(UIImage.init(named: "redAndPurple"), for: .normal)
//        }
//    }
    
    
    
    func loadButtonStyleImages(type: Ctabuttoncolorstyle,ctaButton: UIButton) {
        
        let greenAndYellow = UIImage(named: "btn_small_gradient_green_yellow_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let orangeAndYellow = UIImage(named: "btn_small_gradient_orange_yellow_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let purpleAndOrange = UIImage(named: "btn_small_gradient_purple_orange_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let purpleAndBlue = UIImage(named: "btn_small_gradient_purpule_blue_Orange_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let greenAndBlue = UIImage(named: "btn_small_gradient_green_blue_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let redAndPurple = UIImage(named: "btn_small_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
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
    
    func loadButtonStyleVideo(type: Ctabuttoncolorstyle,ctaButton: UIButton) {
        
        let greenAndYellow = UIImage(named: "btn_small_gradient_green_yellow_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let orangeAndYellow = UIImage(named: "btn_small_gradient_orange_yellow_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let purpleAndOrange = UIImage(named: "btn_small_gradient_purple_orange_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let purpleAndBlue = UIImage(named: "btn_small_gradient_purpule_blue_Orange_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let greenAndBlue = UIImage(named: "btn_small_gradient_green_blue_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
        let redAndPurple = UIImage(named: "btn_small_active_install_now", in: Bundle(for:InterstitialImagesViewController.self), compatibleWith: nil)
        
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

