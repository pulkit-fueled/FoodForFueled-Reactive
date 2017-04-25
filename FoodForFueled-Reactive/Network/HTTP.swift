//
//  HTTP.swift
//  FoodForFueled
//
//  Created by Pulkit Vaid on 02/11/16.
//  Copyright © 2016 Pulkit Vaid. All rights reserved.
//

import UIKit

class HTTP: NSObject {
    
    static let shared: HTTP = HTTP()
    private override init() {super.init()}

    var request: Request = Request()
}
