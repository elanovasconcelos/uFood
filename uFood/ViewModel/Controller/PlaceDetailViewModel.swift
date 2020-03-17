//
//  PlaceDetailViewModel.swift
//  uFood
//
//  Created by Elano on 14/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class PlaceDetailViewModel: NSObject {

    private let server: RequestImage
    
    let imageCellViewModel = ImageCellViewModel()
    let cellModels = Observable<[CellViewModel]>([])
    let cellIdentifiers = [PlaceCellViewModel.cellIdentifier,
                           ImageCellViewModel.cellIdentifier]
    
    
    init(place: Place, server: RequestImage = PlaceModel()) {
        self.server = server
        super.init()
        
        setupModel(place: place)
        requestImage(photos: place.photos)
    }
    
    private func setupModel(place: Place) {
        cellModels.value = [imageCellViewModel,
                            PlaceCellViewModel(place: place)]
    }
    
    private func requestImage(photos: [Photo]) {
        guard let reference = photos.first?.photoReference else {
            imageCellViewModel.isLoading.value = false
            imageCellViewModel.image.value = nil
            return
        }

        imageCellViewModel.isLoading.value = true
        
        server.image(photoReference: reference, maxWidth: 750) { [weak self] (result) in
            self?.imageCellViewModel.isLoading.value = false
            switch result {
            case .failure(let error):
                print("requestImage|error: \(error)")
                self?.imageCellViewModel.image.value = nil
            case .success(let image):
                self?.imageCellViewModel.image.value = image
            }
        }
    }
}
