//
//  ImageCellViewModel.swift
//  uFood
//
//  Created by Elano on 14/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ImageCellViewModel: NSObject, CellViewModel {
    static var cellIdentifier = "ImageTableViewCell"
    
    let isLoading = Observable<Bool>(true)
    let image = Observable<UIImage?>(nil)
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? ImageCell else { return }
        
        image.valueChanged = { (newImage) in
            cell.cellImageView.image = newImage
        }
        
        isLoading.valueChanged = { newValue in
            if newValue {
                cell.activityIndicator.startAnimating()
            } else {
                cell.activityIndicator.stopAnimating()
            }
        }
    }

}
