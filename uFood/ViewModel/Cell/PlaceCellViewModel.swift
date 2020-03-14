//
//  PlaceCellViewModel.swift
//  uFood
//
//  Created by Elano on 11/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class PlaceCellViewModel: NSObject, CellViewModel {
    let cellIdentifier = "PlaceTableViewCell"
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? PlaceCell else {
            return
        }
        
        
    }
    

}
