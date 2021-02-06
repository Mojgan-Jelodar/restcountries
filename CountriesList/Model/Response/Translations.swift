//
//  ContryService.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import Foundation
import ObjectMapper

struct Translations: Mappable {
	var de: String?
	var es: String?
	var fr: String?
	var ja: String?
	var it: String?
	var br: String?
	var pt: String?
	var nl: String?
	var hr: String?
	var fa: String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		de <- map["de"]
		es <- map["es"]
		fr <- map["fr"]
		ja <- map["ja"]
		it <- map["it"]
		br <- map["br"]
		pt <- map["pt"]
		nl <- map["nl"]
		hr <- map["hr"]
		fa <- map["fa"]
	}

}
