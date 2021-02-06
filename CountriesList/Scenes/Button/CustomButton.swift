//
//  CustomButton.swift
//  HamrahBank
//
//  Created by hafiz on 4/25/18.
//  Copyright © 2018 hafiz. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    var isRtl: Bool = true {
        didSet {
            if isRtl ==  true {
                self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                self.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                self.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            } else {
                self.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
                self.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
                self.imageView?.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
            }

        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.config()
    }

    internal func config() {
        self.isRtl =  UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft ? true : false
        self.layer.cornerRadius = Layout.defaultCornerRadius
        self.clipsToBounds = true
    }

}
