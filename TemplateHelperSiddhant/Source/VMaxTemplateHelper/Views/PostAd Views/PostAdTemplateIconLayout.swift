//
//  PostAdTemplateIconLayout.swift
//  IMASample
//
//  Created by admin_vserv on 08/06/20.
//  Copyright © 2020 kaltura. All rights reserved.
//

import UIKit

class PostAdTemplateIconLayout: UIView {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var sponsoredLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var brandnameLabel: UILabel!
    
    var postAdModel: PostAdModel!{
        didSet {
            brandnameLabel.text = postAdModel.assets?.title
            titleLabel.text = postAdModel.assets?.desc2
            sponsoredLabel.text = postAdModel.assets?.sponsored
            downloadButton.setTitle(postAdModel.assets?.ctatext, for: .normal)
            downloadButton.backgroundColor = hexStringToUIColor(hex: postAdModel?.assets?.ctabuttoncolor ?? "")
            downloadButton.setTitleColor(hexStringToUIColor(hex: postAdModel?.assets?.ctatextcolor ?? ""), for: .normal)
            icon.downloaded(from: postAdModel.assets?.imageicon ?? "")
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        print("awakeFromNib")
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
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
        return UINib(nibName: "PostAdTemplateIconLayout", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
}
