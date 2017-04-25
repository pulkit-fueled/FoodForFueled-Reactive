//
//  Engine.swift
//  FoodForFueled
//
//  Created by Pulkit Vaid on 02/11/16.
//  Copyright © 2016 Pulkit Vaid. All rights reserved.
//

import UIKit

class Engine {
    
    //MARK: - Singleton Reference
    static let shared: Engine = Engine()
    private init() { }
    
    //MARK: - CoreData Access Point
//    var coreData: CoreData = {
//        let coreData = CoreData(moduleName: "FoodForFueled-Reactive")
//        return coreData
//    }()

    //MARK: - FourSquare Access Point
    var restaurantService: Service = Service(baseURL: "https://api.foursquare.com/v2/venues/")
}
