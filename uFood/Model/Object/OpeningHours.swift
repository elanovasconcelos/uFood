//
//  OpeningHours.swift
//  uFood
//
//  Created by Elano on 12/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct OpeningHours: Decodable {
    let openNow: Bool
    
    private enum CodingKeys : String, CodingKey {
        case openNow = "open_now"
    }
}
