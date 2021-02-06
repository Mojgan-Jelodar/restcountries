//
//  Plugins.swift
//
//  Created by Can Sahin on 28/06/2017.
//  Copyright © 2017 Can Sahin. All rights reserved.
//

import Foundation
import Moya
import PromiseKit
import enum Result.Result

/// Simple network console logger for debug mode
public struct DebugNetworkLoggerPlugin: PluginType {
    private let logResponseData: Bool
    init(_ logResponseData: Bool = false) {
        self.logResponseData = logResponseData
    }
    public func willSend(_ request: RequestType, target: TargetType) {
        #if DEBUG
            print("- Outgoing Network Request -")

            print("Request: " + (request.request?.description ?? "(invalid request)"))

            if let headers = request.request?.allHTTPHeaderFields {
                print("Headers: " + headers.description)
            }
            if let body = request.request?.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
                print("Request Body: " + stringOutput)
            }
            print("")

        #endif
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        #if DEBUG
            if case .success(let rsp) = result {
                guard let response = rsp.response else {
                    print("Received empty network response for \(target).")
                    return
                }
                print("- Incoming Network Response -")
                print("Url: " + target.baseURL.appendingPathComponent(target.path).absoluteString)
                print("Response: " + response.description)
                if self.logResponseData, let stringData = String(data: rsp.data, encoding: String.Encoding.utf8) {
                    print("Data: " + stringData)
                }
            } else {
                print("- Incoming Network Response FAILED!! - \n")
                print("Url: " + target.baseURL.appendingPathComponent(target.path).absoluteString)

            }
            print("")

        #endif
    }
}
