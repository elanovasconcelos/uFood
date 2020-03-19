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
    private let location: RequestLocation
    private var currentLocation: Location? { didSet { requestPlaces() } }
    
    weak var delegate: PlaceListViewModelDelegate?
    
    let cellModels = Observable<[PlaceCellViewModel]>([])
    let cellIdentifiers = [PlaceCellViewModel.cellIdentifier]
    
    //MARK: -
    init(server: RequestPlaces = PlaceModel(), location: RequestLocation = LocationModel()) {
        self.server = server
        self.location = location
        
        super.init()
        
        location.delegate = self
    }
    
    /// Requests a location or the permission to get it if is the first time.
    func requestLocation() {
        currentLocation = nil
        location.requestWhenInUseAuthorization()
        location.updateLocation()
    }
    
    /// Requests places for the current location. It's called automaticaly aftert get a location.
    func requestPlaces() {
        guard let currentLocation = currentLocation else { return }
        
        server.places(at: currentLocation, types: [.bar, .cafe, .restaurant]) { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.delegate?.placeListViewModel(self, didReceived: error)
            case .success(let placeResponse):
                self.cellModels.value = PlaceCellViewModel.from(places: placeResponse.places)
            }
        }
    }

    /// Returns a Place for a table IndexPath if the index is valid.
    /// - Parameter indexPath: indexPath of a place
    func place(at indexPath: IndexPath) -> Place? {
        let row = indexPath.row
        
        if row >= cellModels.value.count {
            return nil
        }
        
        return cellModels.value[row].place
    }
}

extension PlaceListViewModel: RequestLocationDelegate {
    func locationModel(_ locationModel: RequestLocation, didChange location: Location) {
        if currentLocation != nil {
            return
        }
        currentLocation = location
    }
}
