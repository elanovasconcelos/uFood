//
//  DetailResponse.swift
//  uFood
//
//  Created by Elano on 16/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct DetailResponse: Decodable {
    let place: Place
    let status: String
    
    init(place: Place, status: String = "OK") {
        self.place = place
        self.status = status
    }
    
    //MARK: -
    private enum CodingKeys : String, CodingKey {
        case place = "result"
        case status
    }
}
