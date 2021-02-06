//
//  URLSession.swift
//  CountriesList
//
//  Created by m.jelodar on 1/31/21.
//

import Foundation
import Alamofire

final class URLSessionBuilder {
    var timeoutIntervalForRequest: TimeInterval?

    var timeoutIntervalForResource: TimeInterval?

    typealias BuildURLSessionClosure = (URLSessionBuilder) -> Void

    required init(build: BuildURLSessionClosure) {
       build(self)
    }
}

struct URLSession {
    var timeoutIntervalForRequest: TimeInterval?

    var timeoutIntervalForResource: TimeInterval?

    private(set) lazy var session: SessionManager = {
       return  SessionManager(
                configuration: configuration
            )
    }()

    private lazy var configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = self.timeoutIntervalForRequest!
        configuration.timeoutIntervalForResource = self.timeoutIntervalForResource!
        return configuration
    }()

    init?(builder: URLSessionBuilder) {

        self.timeoutIntervalForResource = builder.timeoutIntervalForResource
        self.timeoutIntervalForRequest = builder.timeoutIntervalForRequest
    }

    mutating func build() -> SessionManager {
        return self.session
    }
}
