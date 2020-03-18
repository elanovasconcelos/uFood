//
//  Review.swift
//  uFood
//
//  Created by Elano on 15/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

struct Review: Decodable {
    let authorName: String
    let profilePhotoUrl: String
    let rating: Double
    let relativeTimeDescription: String
    let text: String
    let time: Double
    
    private enum CodingKeys : String, CodingKey {
        case rating
        case text
        case time
        case authorName = "author_name"
        case profilePhotoUrl = "profile_photo_url"
        case relativeTimeDescription = "relative_time_description"
    }
}

extension Review: Comparable {
    static func < (lhs: Review, rhs: Review) -> Bool {
        return lhs.time < rhs.time
    }
}
