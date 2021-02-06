//
//  ContryService.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import Foundation
import ObjectMapper

final class Country: Mappable, Equatable, Hashable {
	var name: String?
	var topLevelDomain: [String]?
	var alpha2Code: String?
	var alpha3Code: String?
	var callingCodes: [String]?
	var capital: String?
	var altSpellings: [String]?
	var region: String?
	var subregion: String?
	var population: Int?
	var latlng: [Int]?
	var demonym: String?
	var area: Int?
	var gini: Double?
	var timezones: [String]?
	var borders: [String]?
	var nativeName: String?
	var numericCode: String?
	var currencies: [Currencies]?
	var languages: [Languages]?
	var translations: Translations?
	var flag: String?
	var regionalBlocs: [RegionalBlocs]?
	var cioc: String?
    private(set) var isSelected: Bool = false

	init?(map: Map) {

	}

    func mapping(map: Map) {
		name <- map["name"]
		topLevelDomain <- map["topLevelDomain"]
		alpha2Code <- map["alpha2Code"]
		alpha3Code <- map["alpha3Code"]
		callingCodes <- map["callingCodes"]
		capital <- map["capital"]
		altSpellings <- map["altSpellings"]
		region <- map["region"]
		subregion <- map["subregion"]
		population <- map["population"]
		latlng <- map["latlng"]
		demonym <- map["demonym"]
		area <- map["area"]
		gini <- map["gini"]
		timezones <- map["timezones"]
		borders <- map["borders"]
		nativeName <- map["nativeName"]
		numericCode <- map["numericCode"]
		currencies <- map["currencies"]
		languages <- map["languages"]
		translations <- map["translations"]
		flag <- map["flag"]
		regionalBlocs <- map["regionalBlocs"]
		cioc <- map["cioc"]
	}
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.area == rhs.area && lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(area)
    }

    func toggle() {
        isSelected = !isSelected
    }
}
