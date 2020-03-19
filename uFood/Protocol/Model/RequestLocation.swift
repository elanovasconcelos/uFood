//
//  RequestLocation.swift
//  uFood
//
//  Created by Elano on 18/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol RequestLocationDelegate: class {
    func locationModel(_ locationModel: RequestLocation, didChange location: Location)
}

protocol RequestLocation: class {
    var delegate: RequestLocationDelegate? { get set }
    
    func requestWhenInUseAuthorization()
    func updateLocation()
    func stopUpdateLocation()
}

