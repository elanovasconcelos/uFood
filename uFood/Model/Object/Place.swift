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
    let rating: Double?
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let reviews: [Review]?
    
    init(placeId: String = "",
         address: String = "",
         name: String = "",
         rating: Double? = nil,
         openingHours: OpeningHours? = nil,
         photos: [Photo]? = nil,
         reviews: [Review]? = nil)
    {
        self.placeId = placeId
        self.address = address
        self.name = name
        self.rating = rating
        self.openingHours = openingHours
        self.photos = photos
        self.reviews = reviews
    }
    
    //MARK: -
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
        let first = lhs.rating ?? 0
        let second = rhs.rating ?? 0
        
        return first < second
    }
}
