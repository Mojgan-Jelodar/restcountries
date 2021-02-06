//
//  Serialization.swift
//
//  Created by Can Sahin on 28/06/2017.
//  Copyright © 2017 Can Sahin. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Serialization {
    enum ErrorCode: Int {
        case noData = 1
        case DecodingError = 2
    }

    static func newError(_ code: ErrorCode, failureReason: String) -> NSError {
        let errorDomain = "com.responseSerialization.error"

        let userInfo = [NSLocalizedFailureReasonErrorKey: failureReason]
        let returnError = NSError(domain: errorDomain, code: code.rawValue, userInfo: userInfo)

        return returnError
    }

    class ObjectCoder {
        public static func codableSerializer<T: Codable>() -> DataResponseSerializer<T> {
            return DataResponseSerializer { _, _, data, error in
                if let err = error {
                    return .failure(err)
                }
                guard let response = data else {
                    let failureReason = "Data could not be serialized. Input data was nil."
                    let error = Serialization.newError(.noData, failureReason: failureReason)
                    return .failure(error)
                }
                let decoder = JSONDecoder()
                do {
                    let obj =  try decoder.decode(T.self, from: response)
                    return .success(obj)
                } catch {
                    let failureReason = "Data could not be decoded."
                    let error = Serialization.newError(.DecodingError, failureReason: failureReason)
                    return .failure(error)
                }

            }
        }
    }

    class ObjectMapper {
        public static func responseObject<T: BaseMappable>() -> DataResponseSerializer<T> {
            return DataResponseSerializer { _, _, data, error in
                if let err = error {
                    return .failure(err)
                }
                guard let jsonString = data?.asString() else {
                    let failureReason = "Data could not be serialized. Input data was nil."
                    let error = Serialization.newError(.noData, failureReason: failureReason)
                    return .failure(error)
                }
                guard let result = Mapper<T>().map(JSONString: jsonString) else {
                    return .failure(Serialization.newError(.DecodingError, failureReason: "Data could not be serialized"))
                }
                return .success(result)

            }
        }

        public static func responseArray<T: BaseMappable>() -> DataResponseSerializer<[T]> {
            return DataResponseSerializer { _, _, data, error in
                if let err = error {
                    return .failure(err)
                }
                guard let jsonString = data?.asString() else {
                    let failureReason = "Data could not be serialized. Input data was nil."
                    let error = Serialization.newError(.noData, failureReason: failureReason)
                    return .failure(error)
                }
                guard let result = Mapper<T>().mapArray(JSONString: jsonString) else {
                    return .failure(Serialization.newError(.DecodingError, failureReason: "Data could not be serialized"))
                }
                return .success(result)

            }
        }
    }

}
