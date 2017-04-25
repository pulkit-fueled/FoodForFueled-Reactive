//
//  RestaurantTableViewCell.swift
//  FoodForFueled-Reactive
//
//  Created by Pulkit Vaid on 20/04/17.
//  Copyright © 2017 Pulkit Vaid. All rights reserved.
//

import UIKit

protocol CellConfigurable {
	func configureWithModel(cellModel: CellModel?)
}

final class RestaurantTableViewCell: UITableViewCell { }

extension RestaurantTableViewCell: CellConfigurable {
	func configureWithModel(cellModel: CellModel?) {
		if let model = cellModel as? RestaurantCellModel {
			textLabel?.text = model.restaurant?.name
			detailTextLabel?.text = "\(model.restaurant?.rating ?? 0.0)"
		}
	}
}

