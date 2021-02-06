//
//  Theme.swift
//  Countries
//
//  Created by mozhgan on 11/6/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit

enum ThemeName: String {

    case light, dark

    var theme: Theme {
        switch self {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        }
    }
}

protocol Theme {
    var name: ThemeName { get }
    var tintColor: UIColor { get }
    var barStyle: UIBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
    var backgroundColor: UIColor { get }
    var secondaryBackgroundColor: UIColor { get }
    var negativeBackgroundColor: UIColor { get }
    var titleTextColor: UIColor { get }
    var subtitleTextColor: UIColor { get }
    var textColor: UIColor { get }
}
