//
//  LightTheme.swift
//  Countries
//
//  Created by mozhgan on 11/6/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit

struct DarkTheme: Theme {
    var name: ThemeName {
        return .dark
    }

    var tintColor: UIColor {
        return UIColor.colorFrom(hexString: "#DD7243")
    }

    var barStyle: UIBarStyle {
        return .black
    }

    var keyboardAppearance: UIKeyboardAppearance {
        return .dark
    }

    var backgroundColor: UIColor {
        return UIColor.colorFrom(hexString: "#000000")
    }

    var secondaryBackgroundColor: UIColor {
        return .groupTableViewBackground
    }

    var negativeBackgroundColor: UIColor {
        return UIColor.colorFrom(hexString: "#000000")

    }

    var titleTextColor: UIColor {
        return UIColor.colorFrom(hexString: "#FFFFFF")
    }
    var subtitleTextColor: UIColor {
        return UIColor.colorFrom(hexString: "#FFFFFF")
    }

    var textColor: UIColor {
        return UIColor.colorFrom(hexString: "#FFFFFF")
    }
}
