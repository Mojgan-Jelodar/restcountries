//
//  File.swift
//  Countries
//
//  Created by m.jelodar on 11/9/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//
import  Foundation
public extension String {

    ///
    /// Localize the current string to the selected language
    ///
    /// - returns: The localized string
    ///
    func localiz(comment: String = "") -> String {
        guard let bundle = Bundle.main.path(forResource: NSLocale.preferredLanguages.first, ofType: "lproj") else {
            return NSLocalizedString(self, comment: comment)
        }

        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
    }

}
