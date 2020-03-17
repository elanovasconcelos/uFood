//
//  Place.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Place: Decodable {
    let placeId: String
    let address: String
    let name: String
    let rating: Double
    let openingHours: OpeningHours?
    let photos: [Photo]
    let reviews: [Review]?
    
    private enum CodingKeys : String, CodingKey {
        case address = "vicinity"
        case openingHours = "opening_hours"
        case placeId = "place_id"
        case name
        case rating
        case photos
        case reviews
    }
}

//MARK: - Comparable
extension Place: Comparable {
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.rating == rhs.rating
    }
    
    static func < (lhs: Place, rhs: Place) -> Bool {
        return lhs.rating < rhs.rating
    }
}
