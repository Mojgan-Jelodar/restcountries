//
//  ContryService.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import Foundation
import PromiseKit
import Moya

final class ContryService: DataServiceProtocol {
    public typealias MoyaTarget = Countries

    internal var moyaProvider: MoyaProvider<Countries>

    var session = URLSession(builder: URLSessionBuilder(build: { (builder) in
        builder.timeoutIntervalForResource = 60.0
        builder.timeoutIntervalForRequest = 20.0
    }))

    required init() {
        self.moyaProvider =  MoyaProvider(manager: (session?.build())!,
                                          plugins: [DebugNetworkLoggerPlugin()],
                                          trackInflights: true)
    }

    public func getRegionalBloc(_ region: Region) -> MoyaCancellablePromise<[Country]> {
        return self.request(target: Countries.list(region: region)).asParsedArray()
    }
}
