//
//  Countries.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//
import Foundation
import Moya

enum Region: String {
    case EU, EFTA, CARICOM, PA, AU, USAN, EEU, AL, ASEAN, CIAS, CEFTA, NAFTA, SAARC
}
enum Countries {
    case list(region: Region)
}

extension Countries: TargetType {
    var baseURL: URL {
        return URL(string: "https://restcountries.eu/rest/v2/regionalbloc/")!
    }

    var path: String {
        switch self {
        case .list(let region):
            return region.rawValue
        }
    }

    var method: Moya.Method {
        switch self {
        case .list:
            return Method.get
        }
    }

    var validationType: ValidationType {
        switch self {
        case .list:
            return ValidationType.successCodes
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json;charset=utf-8"]
    }

    var task: Task {
        switch self {
        case .list:
            return .requestPlain
        }
    }

    var sampleData: Data {
        switch self {
        case .list:
            return AppFileSystemDirectory(using: .documents).readFile(withName: "") ?? Data()
        }
    }
}
