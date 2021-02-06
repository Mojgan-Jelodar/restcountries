//
//  RequestPolicy.swift
//
//  Created by Can Sahin on 28/06/2017.
//  Copyright © 2017 Can Sahin. All rights reserved.
//

import Foundation

import Alamofire
import Moya

/* Sample Data is not implemented yet */

//public enum RetrievePolicy{
//    case storeAsSampleData
//}
public enum RetryPolicy {
//    case sampleDataOnFailure
    case requestRetry(RequestMoyaRetryPolicy)
}

public class RequestMoyaRetryPolicy {

    var errorClosure: ((Swift.Error) -> Bool)
    public var retryCount: Int
    public var coolDownInterval: Double

    public required init (retryCount rCount: Int, coolDownInterval cDown: Double, onError error: @escaping(Swift.Error) -> Bool) {
        self.errorClosure = error
        self.retryCount = rCount
        self.coolDownInterval = cDown
    }
}
