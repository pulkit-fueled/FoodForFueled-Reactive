//
//  RequestModel.swift
//  Pipeline
//
//  Created by Pulkit on 28/10/16.
//  Copyright © 2016 Indus Valley Partners. All rights reserved.
//

import UIKit

struct RequestModel {

    var type: RequestType = .get
    var url: String? = nil
    var headers: Dictionary<String, String>? = nil
    var urlParams: Dictionary<String, String>? = nil
    var body: Dictionary<String, AnyObject>? = nil
    var success: ((_ success: Bool, _ data: AnyObject?) -> Void)? = nil
    var failure: ((_ error: NSError) -> Void)? = nil 

	init() {

	}
}
