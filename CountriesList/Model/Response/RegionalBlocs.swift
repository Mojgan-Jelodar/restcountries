//
//  ContryService.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import Foundation
import ObjectMapper

struct RegionalBlocs: Mappable {
	var acronym: String?
	var name: String?
	var otherAcronyms: [String]?
	var otherNames: [String]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		acronym <- map["acronym"]
		name <- map["name"]
		otherAcronyms <- map["otherAcronyms"]
		otherNames <- map["otherNames"]
	}

}
