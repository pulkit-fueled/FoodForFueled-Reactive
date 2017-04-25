//
//  CellModel.swift
//  FoodForFueled-Reactive
//
//  Created by Pulkit Vaid on 20/04/17.
//  Copyright © 2017 Pulkit Vaid. All rights reserved.
//

import Foundation
import UIKit

protocol CellModel {
	var reuseIdententifier: String { get }
	var height: CGFloat { get }
}

extension CellModel {
	public var height: CGFloat {
		return 44.0
	}
}

struct RestaurantCellModel: CellModel {

	var restaurant: Restaurant?
	internal var height: CGFloat {
		return 44
	}
	internal var reuseIdententifier: String {
		return "RestaurantTableViewCell"
	}

	init(restaurant: Restaurant) {
		self.restaurant = restaurant
	}
}
