//
//  Photo.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Photo: Decodable {
    let width: Int
    let height: Int
    let photoReference: String
    
    private enum CodingKeys : String, CodingKey {
        case width
        case height
        case photoReference = "photo_reference"
    }
}
