//
//  PlaceResponse.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct PlaceResponse: Decodable {
    let places: [Place] //candidates
    let status: String
    
    private enum CodingKeys : String, CodingKey {
        case places = "candidates"
        case status
    }
}
