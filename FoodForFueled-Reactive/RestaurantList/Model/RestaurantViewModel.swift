//
//  RestaurantViewModel.swift
//  FoodForFueled-Reactive
//
//  Created by Pulkit Vaid on 07/04/17.
//  Copyright © 2017 Pulkit Vaid. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class RestaurantViewModel {

	func fetchrestaurants() -> SignalProducer<RestaurantResponseModel, ParseError> {
		return SignalProducer {
			sink, disposable in

			Engine.shared.restaurantService
				.get(url: "explore")
				.urlParams(urlParams: [
					"ll": "28.5802%2C77.318",
					"v": "20131016",
					"radius": "5000",
					"section": "food",
					"limit": "50",
					"oauth_token": "RY1GUGQTRFL5IXZUQSQ12W1YCQHFNJTLUQFO3LFUSURIBA1H"
					])
				.send()
				.on(failed: {

					requestError in
					switch requestError {
					case .error(let error):
						sink.send(error: ParseError.error(error: error))
					case .invalidPostBody:
						sink.send(error: ParseError.error(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data entered is invalid"])))
					default:
						sink.send(error: ParseError.error(error: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Some eror occured"])))
					}

				},	value: {

					networkResponse in
					let result = RestaurantResponseModel.parse(networkResponse: networkResponse)

					if let value = result.value {


						result.value?.restaurantCellModelAray = value.restaurants.value.map {
							restaurant in
							RestaurantCellModel(restaurant: restaurant)
						}						
						sink.send(value: value)
						sink.sendCompleted()

					}
					else if let error = result.error {
						sink.send(error: error)
					}
					else {
						fatalError("Unknown case encountered")
					}
				})
				.start()
		}
	}
}
