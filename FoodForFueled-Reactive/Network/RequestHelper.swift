//
//  RequestHelper.swift
//  FoodForFueled-Reactive
//
//  Created by Pulkit Vaid on 25/04/17.
//  Copyright © 2017 Pulkit Vaid. All rights reserved.
//

import Foundation

final class RequestHelper {

	class func requestObjectFor(requestModel: RequestModel) -> URLRequest? {

		let lRequestModel = requestModel
		var urlString = lRequestModel.url!
		var index = 0
		for (key, val) in lRequestModel.urlParams! {
			if index == 0 {
				urlString += "?"
			}
			else {
				urlString += "&"
			}
			urlString += "\(key)=\(val)"
			index += 1
		}

		let url = URL(string: urlString)
		var request: URLRequest = URLRequest(url: url!)

		switch lRequestModel.type {
		case .get:  request.httpMethod = "GET"
		case .post: request.httpMethod = "POST"
		case .put:  request.httpMethod = "PUT"
		case .delete: request.httpMethod = "DELETE"
		}

		if lRequestModel.headers != nil {
			for (key, val) in lRequestModel.headers! {
				request.setValue(val, forHTTPHeaderField: key)
			}
		}

		if lRequestModel.body != nil {
			do {
				let bodyData = try JSONSerialization.data(withJSONObject: lRequestModel.body!, options: .prettyPrinted)
				request.httpBody = bodyData
			}
			catch {
				return nil
			}
		}
		return request
	}

}
