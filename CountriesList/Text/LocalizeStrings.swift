//
//  File.swift
//  Countries
//
//  Created by m.jelodar on 11/9/19.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import Foundation

struct LocalizeStrings {
    struct CountryListView {
        static let countryListView = "COUNTRY_LIST_TITLE".localiz()
        static let refreshingString = "PULL_TO_REFRESH".localiz()
        static let title = "PULL_TO_REFRESH".localiz()
        static let searchbarPlaceHolder = "SELECT_FOR_COUNTRIES".localiz()
        static let add = "ADD".localiz()
        static let added = "ADDED".localiz()
        static let done = "DONE".localiz()
    }
    struct Home {
        static let choose = "CHOOSE".localiz()
        static let title = "Countries".localiz()
        static let caption = "YOUR_SELECTED_COUNTRIES_ARE_HERE".localiz()
    }

    struct CommonStrings {
        static let alertTitle = "ALERT".localiz()
        static let ok = "OK".localiz()
    }
}
