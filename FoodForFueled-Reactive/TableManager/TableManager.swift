//
//  ListManager.swift
//  FoodForFueled-Reactive
//
//  Created by Pulkit Vaid on 19/04/17.
//  Copyright © 2017 Pulkit Vaid. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift

class TableManager: NSObject, UITableViewDataSource, UITableViewDelegate {

	var dataSource: Array<CellModel>?

	//MARK: - UITableViewDataSource
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cellModel = dataSource?[indexPath.row]

		let cell = tableView.dequeueReusableCell(withIdentifier: cellModel!.reuseIdententifier, for: indexPath)
		if let cell = cell as? CellConfigurable {
			cell.configureWithModel(cellModel: cellModel)
		}
		return cell
	}
}
