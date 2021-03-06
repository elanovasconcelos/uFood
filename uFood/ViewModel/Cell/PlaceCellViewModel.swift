//
//  PlaceCellViewModel.swift
//  uFood
//
//  Created by Elano on 11/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class PlaceCellViewModel: NSObject, CellViewModel {
    static let cellIdentifier = "PlaceTableViewCell"
    
    let name: String
    let openNow: String
    let rating: String
    let place: Place
    
    init(place: Place) {
        self.place = place
        self.name = place.name
        
        if let rating = place.rating {
            self.rating =  "Rating: \(rating)"
        }else {
            self.rating = ""
        }

        if let openNow = place.openingHours?.openNow, openNow {
            self.openNow = "Open Now!"
        }else {
            self.openNow = ""
        }
    }
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? PlaceCell else {
            return
        }
        
        cell.nameLabel.text = name
        cell.openLabel.text = openNow
        cell.ratingLabel.text = rating
    }
    
    //MARK: - 
    static func from(places: [Place]) -> [PlaceCellViewModel] {
        return places.map({ PlaceCellViewModel(place: $0) })
    }
}
