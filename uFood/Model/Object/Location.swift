//
//  Location.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Location: Decodable {
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys : String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
