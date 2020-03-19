//
//  MockRequestPlaces.swift
//  uFoodTests
//
//  Created by Elano on 18/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import uFood

final class MockRequestPlaces: NSObject, RequestPlaces {

    private let returnError: Bool
    
    init(returnError: Bool = false) {
        self.returnError = returnError
    }
    
    func places(at location: Location, types: [RequestPlacesType], completionHandler: @escaping (Result<PlaceResponse, ServerError>) -> Void) {
        if returnError {
            completionHandler(.failure(.api))
            return
        }
        
        let response = PlaceResponse(places: Place.debugArray())
        completionHandler(.success(response))
    }
    func details(for placeId: String, completionHandler: @escaping (Result<DetailResponse, ServerError>) -> Void) {
        if returnError {
            completionHandler(.failure(.api))
            return
        }
        let response = DetailResponse(place: Place.debug())
        completionHandler(.success(response))
    }
}
