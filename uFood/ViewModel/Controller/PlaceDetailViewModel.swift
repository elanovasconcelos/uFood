//
//  PlaceDetailViewModel.swift
//  uFood
//
//  Created by Elano on 14/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol PlaceDetailViewModelDelegate: class {
    func placeDetailViewModel(_ placeDetailViewModel: PlaceDetailViewModel, didReceived error: ServerError)
}

final class PlaceDetailViewModel: NSObject {

    private let server: RequestImage & RequestPlaces
    private(set) var cellModels = Observable<[CellViewModel]>([])
    
    weak var delegate: PlaceDetailViewModelDelegate?
    
    let imageCellViewModel = ImageCellViewModel()
    let cellIdentifiers = [PlaceCellViewModel.cellIdentifier,
                           ImageCellViewModel.cellIdentifier,
                           ReviewCellViewModel.cellIdentifier]
    
    
    init(place: Place, server: RequestImage & RequestPlaces = PlaceModel()) {
        self.server = server
        super.init()
        
        setupModel(place: place)
        requestImage(photos: place.photos)
        requestDetail(for: place)
    }
    
    private func setupModel(place: Place) {
        cellModels.value = [imageCellViewModel,
                            PlaceCellViewModel(place: place)]
    }
    
    private func requestImage(photos: [Photo]?) {
        guard let reference = photos?.first?.photoReference else {
            imageCellViewModel.isLoading.value = false
            imageCellViewModel.image.value = nil
            return
        }

        imageCellViewModel.isLoading.value = true
        
        server.image(photoReference: reference, maxWidth: 750) { [weak self] (result) in
            guard let self = self else { return }
            self.imageCellViewModel.isLoading.value = false
            
            switch result {
            case .failure(let error):
                self.delegate?.placeDetailViewModel(self, didReceived: error)
                self.imageCellViewModel.image.value = nil
            case .success(let image):
                self.imageCellViewModel.image.value = image
            }
        }
    }
    
    private func requestDetail(for place: Place) {
        server.details(for: place.placeId) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.delegate?.placeDetailViewModel(self, didReceived: error)
            case .success(let detailResponse):
                let reviews: [Review]? = detailResponse.place.reviews?.sorted().reversed()
                let models = ReviewCellViewModel.from(reviews: reviews)
                self.cellModels.value.append(contentsOf: models)
            }
        }
    }
}
