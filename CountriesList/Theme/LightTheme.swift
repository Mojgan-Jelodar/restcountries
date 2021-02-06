//
//  LightTheme.swift
//  Countries
//
//  Created by mozhgan on 11/6/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit

struct LightTheme: Theme {
    var name: ThemeName {
        return .light
    }

    var tintColor: UIColor {
        return UIColor.colorFrom(hexString: "#2892ee")
    }

    var barStyle: UIBarStyle {
        return .default
    }

    var keyboardAppearance: UIKeyboardAppearance {
        return .light
    }

    var backgroundColor: UIColor {
        return UIColor.colorFrom(hexString: "#a9aaab")
    }

    var secondaryBackgroundColor: UIColor {
        return UIColor.colorFrom(hexString: "#f9fafb")
    }

    var negativeBackgroundColor: UIColor {
        return UIColor.colorFrom(hexString: "#f9fafb")
    }

    var titleTextColor: UIColor {
       return UIColor.black
    }
    var subtitleTextColor: UIColor {
        return UIColor.black
    }

    var textColor: UIColor {
        return UIColor.black
    }
}
