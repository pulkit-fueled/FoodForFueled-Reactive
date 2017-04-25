//
//  Service.swift
//  Pipeline
//
//  Created by Pulkit on 28/10/16.
//  Copyright © 2016 Indus Valley Partners. All rights reserved.
//

import UIKit

struct Service: NetworkProtocol {

    internal var baseURL: String = ""
    init(baseURL: String) {
        self.baseURL = baseURL
    }
}
