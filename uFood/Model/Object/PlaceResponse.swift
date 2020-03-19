//
//  PlaceResponse.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct PlaceResponse: Decodable {
    let places: [Place]
    let status: String
    
    init(places: [Place], status: String = "OK") {
        self.places = places
        self.status = status
    }
    
    //MARK: -
    private enum CodingKeys : String, CodingKey {
        case places = "results"
        case status
    }
}
