//
//  Request.swift
//  Pipeline
//
//  Created by Chetan Aggarwal on 21/10/16.
//  Copyright © 2016 Indus Valley Partners. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

let kKeyContentType: String = "Content-Type"
let kKeyAccept: String = "Accept"
let kValueApplicationJSON: String = "application/json"

class Request
{
    //MARK: - Properties
    var session: URLSession?
    var configuration: URLSessionConfiguration?
    
    //MARK: - Init
    init() {
        self.configuration = URLSessionConfiguration.default
        self.configuration?.timeoutIntervalForRequest = 60
        self.configuration?.requestCachePolicy = .useProtocolCachePolicy
        self.session = URLSession(configuration: self.configuration!)
    }
    
    var requestModel: RequestModel = RequestModel()
    
    //MARK: - SERVICE (Common)
	func serviceWithRequestModel (requestModel: RequestModel) -> SignalProducer<NetworkResponse, RequestError> {


		guard let urlRequest = RequestHelper.requestObjectFor(requestModel: requestModel) else {
			return SignalProducer<NetworkResponse, RequestError> {
				observer, _ in
				observer.send(error: RequestError.invalidPostBody)
			}
		}

/*		return URLSession.shared.reactive.data(with: urlRequest)
		.map {
			(data, urlResponse) in

			return NetworkResponse.response(data: data, urlResponse: urlResponse)
		}
		.mapError { (error) -> RequestError in
			return RequestError.error(error: error)
		}


*/

		return SignalProducer<NetworkResponse, RequestError> {

			sink, disposable in

			_ = URLSession.shared.reactive.data(with: urlRequest)
				.on(failed: {
					(error) in
					sink.send(error: RequestError.error(error: error))

				}) {
					(data, urlResponse) in
					if (urlResponse as? HTTPURLResponse)?.statusCode != 200 {
						sink.send(error: RequestError.noConnectivity )
					}
					else {
						sink.send(value: NetworkResponse.response(data: data, urlResponse: urlResponse))
						sink.sendCompleted()
					}
				}
				.start()
		}





/*		return SignalProducer<NetworkResponse, RequestError> {

			observer, disposable in

			let dataTask: URLSessionDataTask? = self.session?.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
				if error != nil {
					observer.send(error: .error(error: error!))
					return
				}

				if response == nil {
					observer.send(error: .invalidResponse)
				}

				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						observer.send(error: .invalidResponse)
					}
					else {
						//Success
						guard data != nil else {
							observer.send(error: .noDataFound)
							return
						}

						observer.send(value: NetworkResponse.response(data: data as Any, urlResponse: response!))
						observer.sendCompleted()
					}
				}
				else {
					observer.send(error: .invalidResponse)
					return
				}
			})
			dataTask?.resume()
		} */
    }
}
