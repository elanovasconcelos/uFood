//
//  RequestLocation.swift
//  uFood
//
//  Created by Elano on 18/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol RequestLocation: class {
    func requestWhenInUseAuthorization()
    func updateLocation()
    func stopUpdateLocation()
    
    var delegate: LocationModelDelegate? { get set }
}

