//
//  File.swift
//  Countries
//
//  Created by mozhgan on 11/6/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import Foundation

protocol ThemeRepository {
    func load() -> Theme
    func save(_ theme: Theme)
}

final class DefaultThemeRepository: ThemeRepository {

    private let selectedThemeKey = "selectedThemeKey"
    private let defaults = UserDefaults.standard

    func load() -> Theme {
        if let storedTheme = defaults.string(forKey: selectedThemeKey),
            let theme = ThemeName(rawValue: storedTheme)?.theme {
            return theme
        } else {
            return DarkTheme()
        }
    }

    func save(_ theme: Theme) {
        defaults.setValue(theme.name.rawValue, forKey: selectedThemeKey)
        defaults.synchronize()
    }
}
