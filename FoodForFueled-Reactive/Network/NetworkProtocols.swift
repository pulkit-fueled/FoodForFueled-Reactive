//
//  NetworkProtocols.swift
//  FoodForFueled
//
//  Created by Pulkit Vaid on 02/11/16.
//  Copyright © 2016 Pulkit Vaid. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Result

enum RequestType {
    case get
    case post
    case put
    case delete
}

protocol NetworkProtocol {
	var baseURL: String { get }
    func get(url: String) -> RequestInstance
    func post(url: String) -> RequestInstance
}

extension NetworkProtocol {

	func get(url: String) -> RequestInstance {
		return setupRequestInstanceForURL(url: url, type: .get)
	}

	func post(url: String) -> RequestInstance {
		return setupRequestInstanceForURL(url: url, type: .post)
	}

	func setupRequestInstanceForURL(url: String, type: RequestType) -> RequestInstance {
		var requestModel: RequestModel = RequestModel()
		requestModel.type = type
		requestModel.url = baseURL + url
		return RequestInstance(requestModel: requestModel)
	}
}

protocol Parsable {
	static func parse(networkResponse: NetworkResponse) -> (value: Self?, error: ParseError?)
}

enum NetworkResponse {
	case response (data: Any, urlResponse: URLResponse)
}

protocol RestautantError: Error {
	var message: String { get }
}

enum RequestError: RestautantError {

	var message: String {
		switch self {
		case .noResponse:
			return "Could not get any response from server."
		case .invalidResponse:
			return "Invalid response from server."
		case .noConnectivity:
			return "Please check your internet connectivity"
		case .invalidPostBody:
			return "Data entered is invalid"
		case .noDataFound:
			return "Could not get data from server"
		case .error(let error):
			return error.localizedDescription
		}
	}

	case noResponse
	case invalidResponse
	case noConnectivity
	case invalidPostBody
	case noDataFound
	case error(error: Error)
}

enum ParseError: RestautantError {
	var message: String {
		switch self {
		case .dataFoundNil(let message):
			return message
		case .unexpectedValue(let message):
			return message
		case .error(let error):
			return error.localizedDescription
		}
	}
	case unexpectedValue(message: String)
	case dataFoundNil(message: String)
	case error(error: Error)
}
