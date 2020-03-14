//
//  PlaceListViewModel.swift
//  uFood
//
//  Created by Elano on 14/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol PlaceListViewModelDelegate: class {
    func placeListViewModel(_ placeListViewModel: PlaceListViewModel, didReceived error: ServerError)
}

final class PlaceListViewModel: NSObject {

    private let server: RequestPlaces
    private let location = Location(latitude: -33.8670522, longitude: 151.1957362)
    
    weak var delegate: PlaceListViewModelDelegate?
    
    let cellModels = Observable<[Place]>([])
    
    init(server: RequestPlaces = PlaceModel()) {
        self.server = server
    }
    
    func requestPlaces() {
        server.places(at: location, types: [.bar, .cafe, .restaurant]) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.delegate?.placeListViewModel(self, didReceived: error)
            case .success(let placeResponse):
                self.cellModels.value = placeResponse.places
            }
        }
    }
}
