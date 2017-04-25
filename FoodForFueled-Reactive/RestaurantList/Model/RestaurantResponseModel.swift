//
//  RestaurantResponseModel.swift
//  FoodForFueled-Reactive
//
//  Created by Pulkit Vaid on 07/04/17.
//  Copyright © 2017 Pulkit Vaid. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

final class RestaurantResponseModel: Parsable {

	var restaurants: MutableProperty<Array<Restaurant>> = MutableProperty<Array<Restaurant>>(Array<Restaurant>())
	var restaurantCellModelAray: Array<RestaurantCellModel> = Array<RestaurantCellModel>()

	static func parse(networkResponse: NetworkResponse) -> (value: RestaurantResponseModel?, error: ParseError?) {
		
		switch networkResponse {
		case let .response(data, urlResponse):
			print(urlResponse)

			let result = RestaurantListParser.restaurantsFromData(data: data)

			var value: RestaurantResponseModel? = nil
			if let restaurants = result.value {
				value = RestaurantResponseModel()
				value?.restaurants.value = restaurants
				return (value, nil)
			}
			else {
				return (nil, result.error)
			}
		}
	}
}

struct RestaurantListParser {
	/**
	Returns the list of retaurants extracted from the given data
	*/
	static func restaurantsFromData(data: Any) -> (value: [Restaurant]?, error: ParseError?) {

		guard let data = data as? Data else {
			return (nil, ParseError.dataFoundNil(message: "Data from server fround nil"))
		}
		guard let jsonDict = RestaurantListParser.jsonFromData(data: data) as? Dictionary<String, Any> else {
			return (nil, ParseError.unexpectedValue(message: "Unexpected response from server"))
		}

		guard let responseDict = jsonDict["response"] as? Dictionary<String, Any> else {
			return (nil, ParseError.unexpectedValue(message: "Unexpected response from server"))
		}

		guard let groupsArray = responseDict["groups"] as? Array<Dictionary<String, Any>> else {
			return (nil, ParseError.unexpectedValue(message: "Unexpected response from server"))
		}

		guard let itemsArray = groupsArray[0]["items"] as? Array<Dictionary<String, Any>> else {
			return (nil, ParseError.unexpectedValue(message: "Unexpected response from server"))
		}

		var lRestaurantArray = [Restaurant]()

		for item in itemsArray {


			guard let venueDict = item["venue"] as? Dictionary<String, Any> else {
				continue
			}

			guard let id = venueDict["id"] as? String else {
				continue
			}

			guard let name = venueDict["name"] as? String else {
				continue
			}

			guard let rating = venueDict["rating"] as? Double else {
				continue
			}

			guard let locationDict = venueDict["location"] as? Dictionary<String, Any> else {
				continue
			}

			guard let address = locationDict["address"] as? String else {
				continue
			}


			let restaurant = Restaurant(name: name, address: address, rating: rating, disliked: false, id: id, reviews: nil)

			lRestaurantArray.append(restaurant)
		}

		return (lRestaurantArray, nil)
	}

	static func jsonFromData(data: Data) -> Any? {
		do {
			let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
			return json
		}
		catch {
			return nil
		}
	}
}

