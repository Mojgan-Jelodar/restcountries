//
//  ContryService.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import Foundation
import ObjectMapper

struct Languages: Mappable {
	var iso639_1: String?
	var iso639_2: String?
	var name: String?
	var nativeName: String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		iso639_1 <- map["iso639_1"]
		iso639_2 <- map["iso639_2"]
		name <- map["name"]
		nativeName <- map["nativeName"]
	}

}
