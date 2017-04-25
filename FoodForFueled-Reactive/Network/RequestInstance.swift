//
//  RequestInstance.swift
//  Pipeline
//
//  Created by Pulkit on 28/10/16.
//  Copyright © 2016 Indus Valley Partners. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class RequestInstance {
    
    var requestModel: RequestModel = RequestModel()
    
    init(requestModel: RequestModel) {
        self.requestModel = requestModel
    }
    
    func headers(headers: Dictionary<String, String>) -> RequestInstance {
        self.requestModel.headers = headers
        return self
    }
    
    func urlParams(urlParams: Dictionary<String, String>) -> RequestInstance {
        self.requestModel.urlParams = urlParams
        return self
    }
    
    func body(body: Dictionary<String, AnyObject>) -> RequestInstance {
        self.requestModel.body = body
        return self
    }
    
    func success(success: @escaping (_ isSuccess: Bool, _ data: AnyObject?) -> Void) -> RequestInstance {
        self.requestModel.success = success
        return self
    }
    
    func failure(failure: @escaping (_ error: NSError) -> Void) -> RequestInstance {
        self.requestModel.failure = failure
        return self
    }
    
    func send() -> SignalProducer<NetworkResponse, RequestError> {
        return HTTP.shared.request.serviceWithRequestModel(requestModel: self.requestModel)
    }
}
