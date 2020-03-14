//
//  RequestPlaces.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol RequestPlaces {
    func places(at location: Location, types: [RequestPlacesType], completionHandler: @escaping (Result<PlaceResponse, ServerError>) -> Void)
}

//MARK: -
enum RequestPlacesType: String {
    case bar
    case restaurant
    case cafe
}
