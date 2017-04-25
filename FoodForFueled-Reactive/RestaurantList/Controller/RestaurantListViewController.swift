//
//  RestaurantListViewController.swift
//  FoodForFueled-Reactive
//
//  Created by Pulkit Vaid on 07/04/17.
//  Copyright © 2017 Pulkit Vaid. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift


class RestaurantListViewController: UIViewController {

	let viewModel: RestaurantViewModel = RestaurantViewModel()
	var disposable: CompositeDisposable = CompositeDisposable()

	@IBOutlet weak var tableView: UITableView!
	var tableManager: TableManager = TableManager()

    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: "RestaurantTableViewCell")
		tableView.dataSource = tableManager

		disposable += viewModel.fetchrestaurants().startWithResult {
			[weak self]
			result in
			switch result {
			case .failure(let error):
				self?.handleError(error: error)
			case .success(let restaurantResponseModel):
				self?.handleSuccess(restaurantResponseModel: restaurantResponseModel)
			}
		}
    }

	//MARK: - Private 
	private func handleError(error: Error) {
		print(error)
	}

	private func handleSuccess(restaurantResponseModel: RestaurantResponseModel) {

		self.tableManager.dataSource = restaurantResponseModel.restaurantCellModelAray
		self.tableView.reactive.reloadData <~ restaurantResponseModel.restaurants.map{
			_ in ()
		}
	}
}
