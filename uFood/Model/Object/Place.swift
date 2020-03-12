//
//  Place.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Place: Decodable {
    let formattedAddress: String
    let name: String
    let rating: Double
    let openingHours: OpeningHours
    let photos: [Photo]
    
    private enum CodingKeys : String, CodingKey {
        case formattedAddress = "formatted_address"
        case openingHours = "opening_hours"
        case name
        case rating
        case photos
    }
}
