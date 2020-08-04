//
//  InFeedVideoAdMid.swift
//  IMASample
//
//  Created by admin_vserv on 16/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

protocol CtaButtonClicked: class {
    func ctaButtonClicked()
    func icontapped()
    func titletapped()
    func replaytapped()
    func descriptiontapped()
    func backViewTapped()
    func timeOver()
}

class InFeedVideoAdMid: UIView {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var brandName: UILabel!
    var delegate: CtaButtonClicked?
    var infeedAdModel: PostAdModel! {
        didSet {
            iconImage.downloaded(from: infeedAdModel.assets?.imageicon ?? "")
            brandName.text = infeedAdModel.assets?.title
            descriptionLabel.text = infeedAdModel.assets?.desc
            ctaButton.setTitle(infeedAdModel.assets?.ctatext, for: .normal)
            
           let titlehexColor = hexStringToUIColor(hex: infeedAdModel?.assets?.ctatextcolor ?? "")
        
            ctaButton.setTitleColor(titlehexColor, for: .normal)
           
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        makeUserInteraction()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if infeedAdModel.link?.url == "" && infeedAdModel.link?.fallback == "" {
            self.ctaButton.isHidden = true
        }
        else {
            self.ctaButton.isHidden = false
        }
        
        let ctabuttoncolorstyle = infeedAdModel.assets?.ctabuttoncolorstyle ?? "1"
        
        if let buttonType = Ctabuttoncolorstyle(rawValue: Character(ctabuttoncolorstyle)) {
            VmaxUtility.shared.loadButtonStyle(type: buttonType, ctaButton: self.ctaButton)
        }
        else {
            VmaxUtility.shared.loadButtonStyle(type: .greenAndYellow, ctaButton: self.ctaButton)
        }
    }
    
    func makeUserInteraction() {
        let iconTapGeture = UITapGestureRecognizer()
        iconTapGeture.numberOfTapsRequired = 1
        iconTapGeture.addTarget(self, action: #selector(iconTapped))
        iconImage.isUserInteractionEnabled = true
        iconImage.addGestureRecognizer(iconTapGeture)
        
        let titleTapGeture = UITapGestureRecognizer()
        titleTapGeture.numberOfTapsRequired = 1
        titleTapGeture.addTarget(self, action: #selector(titleTapped))
        brandName.isUserInteractionEnabled = true
        brandName.addGestureRecognizer(titleTapGeture)
        
        let descTapGeture = UITapGestureRecognizer()
        descTapGeture.numberOfTapsRequired = 1
        descTapGeture.addTarget(self, action: #selector(descTapped))
        descriptionLabel.isUserInteractionEnabled = true
        descriptionLabel.addGestureRecognizer(descTapGeture)
    }
    
    @objc func iconTapped() {
        self.delegate?.icontapped()
    }
    
    @objc func titleTapped() {
        self.delegate?.titletapped()
    }
    
    @objc func descTapped() {
        self.delegate?.descriptiontapped()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return .white
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @objc public class func instanceFromNib() -> UIView {
        let nativeBundle = Bundle(for: InFeedVideoAdMid.self)
        let views = nativeBundle.loadNibNamed("InFeedVideoAdMid", owner: self, options: nil)?.first as! UIView
        return views
        
    }

    
    @IBAction func ctaButtonAction(_ sender: UIButton) {
        self.delegate?.ctaButtonClicked()
    }
    
    
}


