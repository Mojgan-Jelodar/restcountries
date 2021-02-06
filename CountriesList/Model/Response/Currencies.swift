//
//  ContryService.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import Foundation
import ObjectMapper

struct Currencies: Mappable {
	var code: String?
	var name: String?
	var symbol: String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		code <- map["code"]
		name <- map["name"]
		symbol <- map["symbol"]
	}

}
