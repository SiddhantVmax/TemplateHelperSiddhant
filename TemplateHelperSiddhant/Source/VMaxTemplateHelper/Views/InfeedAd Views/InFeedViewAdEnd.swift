//
//  InFeedViewAdEnd.swift
//  IMASample
//
//  Created by admin_vserv on 16/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import Foundation

class InFeedViewAdEnd: UIView {
    
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var descriptionButton: UILabel!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    var delegate: CtaButtonClicked?
    var timer = Timer()
    var infeedAdModel: PostAdModel! {
        didSet {
            iconImage.downloaded(from: infeedAdModel.assets?.imageicon ?? "")
            brandName.text = infeedAdModel.assets?.title
            descriptionButton.text = infeedAdModel.assets?.desc
            ctaButton.setTitle(infeedAdModel.assets?.ctatext, for: .normal)
            let titlehexColor = hexStringToUIColor(hex: infeedAdModel?.assets?.ctatextcolor ?? "")
            
            ctaButton.setTitleColor(titlehexColor, for: .normal)
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeUserInteraction()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timeOver), userInfo: nil, repeats: false)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let ctabuttoncolorstyle = infeedAdModel.assets?.ctabuttoncolorstyle ?? "1"
        
        if let buttonType = Ctabuttoncolorstyle(rawValue: Character(ctabuttoncolorstyle)) {
            VmaxUtility.shared.loadButtonStyle(type: buttonType, ctaButton: self.ctaButton)
        }
        else {
            VmaxUtility.shared.loadButtonStyle(type: .greenAndYellow, ctaButton: self.ctaButton)
        }
        
        
        
    }

    
    @objc func timeOver() {
        self.delegate?.timeOver()
        timer.invalidate()
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
            let nativeBundle = Bundle(for: InFeedViewAdEnd.self)
            let views = nativeBundle.loadNibNamed("InFeedVideoAdEnd", owner: self, options: nil)?.first as! UIView
            return views
    //        return UINib(nibName: "InFeedVideoAdEnd", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
        }
    
    @IBAction func ctaButtonAction(_ sender: Any) {
        self.delegate?.ctaButtonClicked()
    }
    
    @IBAction func replayAction(_ sender: Any) {
        self.delegate?.replaytapped()
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
        descriptionButton.isUserInteractionEnabled = true
        descriptionButton.addGestureRecognizer(descTapGeture)
        
        let mainViewTapGeture = UITapGestureRecognizer()
        mainViewTapGeture.numberOfTapsRequired = 1
        mainViewTapGeture.addTarget(self, action: #selector(viewTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(mainViewTapGeture)
        
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
    
    @objc func viewTapped() {
        self.delegate?.backViewTapped()
    }
    
}
