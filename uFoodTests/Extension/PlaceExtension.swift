//
//  PlaceExtension.swift
//  uFoodTests
//
//  Created by Elano on 18/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import uFood

extension Place {
    static func debugArray(count: Int = 10) -> [Place] {
        var result = [Place]()
        
        for index in 1...count {
            let place = Place(placeId: "\(index)",
                address: "address \(index)",
                name: "name \(index)",
                rating: Double(index))
            
            result.append(place)
        }
        
        return result
    }
    
    static func debug() -> Place {
        return debugArray(count: 1)[0]
    }
}
