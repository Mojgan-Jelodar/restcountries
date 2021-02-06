//
//  TextLabel.swift
//  Countries
//
//  Created by mozhgan on 11/6/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit

final class TextLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.font = UIFont.systemFont(ofSize: self.font.pointSize)
        self.textColor = ThemeManager.sharedInstance.current.textColor
    }
}
